import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../core/config/app_config.dart';
import '../../core/config/exception_messages.dart';
import '../../core/config/firestore_config.dart';
import '../../core/exceptions.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/username_generator.dart';
import '../../di/di.dart';
import '../models/user_model.dart';

class CommonDataSource {
  static Future<Map<String, dynamic>> getUserData(String userId) async {
    DocumentSnapshot userDocSnapshot = await kUsersRef.doc(userId).get();

    if (userDocSnapshot.exists) {
      return (userDocSnapshot.data() as Map<String, dynamic>)
        ..putIfAbsent('id', () => userDocSnapshot.id);
    }
    throw ServerException(ExceptionMessages.userNotAuthed);
  }

  static Future<bool> isUsernameTaken(String username) async {
    final QuerySnapshot result =
        await kUsersRef.where('username', isEqualTo: username).limit(1).get();
    return result.docs.isNotEmpty;
  }

  static Future<UserModel> createUser({required UserModel userModel}) async {
    debugPrint('createUser');
    List? search = Helper.searchList(userModel.name ?? AppConfig.defaultName);
    var username = UsernameGen.generateWith(seperator: '_');
    bool wasUsernameTaken = await isUsernameTaken(username);
    if (wasUsernameTaken) {
      username = UsernameGen.generateWith(seperator: '_'); // generate a new one
    }
    Map<String, dynamic> userMap = userModel.toJson();
    userMap['search'] = search;
    userMap['username'] = username;
    await kUsersRef.doc(userModel.id).set(userMap);
    return UserModel.fromJson(userMap..putIfAbsent('id', () => userModel.id));
  }

  static Future<String> uploadFile(
      {required File file, required String path}) async {
    Reference storageReference = di<FirebaseStorage>().ref().child(path);
    UploadTask? uploadTask = storageReference.putFile(file);

    await uploadTask;
    String url = await storageReference.getDownloadURL();
    return url;
  }
}
