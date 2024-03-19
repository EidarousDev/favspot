import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../core/config/exception_messages.dart';
import '../../core/config/firestore_config.dart';
import '../../core/exceptions.dart';
import '../../di/di.dart';
import '../models/user_model.dart';
import 'common_data_source.dart';

abstract class AuthDataSource {
  Future<UserModel> authenticateUser();
  Future<UserModel> loginWithGoogle();
  Future<UserModel> loginWithFacebook();
  Future<UserModel> loginWithApple();
  Future<void> logout();
  Future<UserModel> getUserById(String id);
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<UserModel> authenticateUser() async {
    User? firebaseUser = di<FirebaseAuth>().currentUser;
    if (firebaseUser == null) {
      throw ServerException(ExceptionMessages.noUserWithThisId);
    }
    Map<String, dynamic> userMap =
        await CommonDataSource.getUserData(firebaseUser.uid);
    return UserModel.fromJson(userMap);
  }

  @override
  Future<UserModel> getUserById(String id) async {
    return UserModel.fromJson((await CommonDataSource.getUserData(id)));
  }

  @override
  Future<UserModel> loginWithFacebook() async {
    final LoginResult result =
        await di<FacebookAuth>().login().catchError((onError) {
      throw ServerException(ExceptionMessages.facebookSignInFailed);
    });

    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      final AuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);
      final UserCredential authResult =
          await di<FirebaseAuth>().signInWithCredential(credential);
      final User? firebaseUser = authResult.user;

      if (firebaseUser == null) {
        throw ServerException(ExceptionMessages.googleSignInFailed);
      }
      final userData = await di<FacebookAuth>().getUserData();
      return getUserDataOrSignUp(
        userId: firebaseUser.uid,
        name: userData['name'],
        email: userData['email'],
        profileImage: userData['picture']['data']['url'],
      );
    } else {
      debugPrint('${result.status}');
      debugPrint(result.message);
      throw ServerException(ExceptionMessages.facebookSignInFailed);
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount;
    try{
      googleSignInAccount = await di<GoogleSignIn>().signIn();
    } catch(error) {
      debugPrint('Google Sign in Failed in the first try! $error');
      throw ServerException('${ExceptionMessages.googleSignInFailed} $error');
    }
    if (googleSignInAccount == null) {
      debugPrint('googleSignInAccount == null');
      throw ServerException(ExceptionMessages.googleSignInFailed);
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await di<FirebaseAuth>().signInWithCredential(credential);
    final User? firebaseUser = authResult.user;

    if (firebaseUser == null) {
      debugPrint('googleSignInAccount firebaseUser == null');
      throw ServerException(ExceptionMessages.googleSignInFailed);
    }
    return getUserDataOrSignUp(
      userId: firebaseUser.uid,
      name: googleSignInAccount.displayName,
      email: googleSignInAccount.email,
      profileImage: googleSignInAccount.photoUrl,
    );
  }

  @override
  Future<UserModel> loginWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    // Request credential for the currently signed in Apple account.
    debugPrint('==== Login with Apple ====');
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    final displayName =
        '${appleCredential.givenName} ${appleCredential.familyName}';
    // final userEmail = '${appleCredential.email}';
    final User? firebaseUser = authResult.user;

    if (firebaseUser == null) {
      debugPrint('firebaseUser = null');
      throw ServerException(ExceptionMessages.appleSignInFailed);
    }
    debugPrint('apple.displayName = $displayName');
    debugPrint('firebaseUser.email = ${firebaseUser.email}');
    debugPrint('firebaseUser.photoURL = ${firebaseUser.photoURL}');
    return getUserDataOrSignUp(
      userId: firebaseUser.uid,
      name: displayName,
      email: firebaseUser.email,
      profileImage: firebaseUser.photoURL,
    );
  }

  @override
  Future<void> logout() async {
    await di<FirebaseAuth>().signOut();
  }

  static Future<UserModel> getUserDataOrSignUp(
      {required String userId,
      String? email,
      String? name,
      String? profileImage}) async {
    DocumentSnapshot userDocSnapshot = await kUsersRef.doc(userId).get();

    if (userDocSnapshot.exists) {
      debugPrint('Successful sign in :) Getting User Data');
      return UserModel.fromJson(
          (userDocSnapshot.data()! as Map<String, dynamic>)
            ..putIfAbsent('id', () => userDocSnapshot.id));
    }
    debugPrint('Creating a New User');
    UserModel user = UserModel(
        id: userId, name: name, email: email, profileImage: profileImage);
    return await CommonDataSource.createUser(userModel: user);
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
