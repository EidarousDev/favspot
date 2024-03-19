import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'di.dart';

void initExternals() {
  di.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  di.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  di.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  di.registerLazySingleton<FirebaseRemoteConfig>(
      () => FirebaseRemoteConfig.instance);
  di.registerLazySingleton<MobileAds>(() => MobileAds.instance);
  di.registerLazySingleton<ImagePicker>(() => ImagePicker());
  di.registerLazySingleton<FlutterSecureStorage>(() =>
      const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true)));
  di.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],));
  di.registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);
}
