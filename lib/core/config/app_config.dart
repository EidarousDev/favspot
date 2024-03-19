import 'dart:ui';

class AppConfig {
  static const String appName = 'FavSpot';
  static const String imagePlaceHolder = 'https://i.stack.imgur.com/dr5qp.jpg';
  static const String englishLanguage = 'en';
  static const String spanishLanguage = 'es';
  static const String defaultLanguage = englishLanguage;
  static var supportedLanguages = [
    const Locale(englishLanguage),
    const Locale(spanishLanguage),
  ];
  static const defaultLocale = Locale(defaultLanguage);
  static const defaultName = 'John Doe';
  static const defaultEmail = 'example@gmail.com';
  static const defaultAvatar = 'https://i.stack.imgur.com/dr5qp.jpg';
  static const defaultSubject = 'Need Support';
  static String uid = ''; // Logged in user ID is stored in this variable
  static const emailServiceId = 'service_8kj2rz9';
  static const emailServiceUserId = 'zog_cnn_La7gZ_e0y';
  static const emailAPI = 'https://api.emailjs.com/api/v1.0/email/send';
  static const sharePicText = 'Find this picture on FavSpot.io';
  static const sharePicSubject = 'Get FavSpot for Free!';
  static const siteUrl = 'https://favspot.io/';
  static const termsOfServiceUrl = '${siteUrl}terms-of-service/';
  static const privacyPolicyUrl = '${siteUrl}privacy-policy/';
  static const playStoreUrl =
      'https://play.google.com/store/apps/details?id=dev.smartx.favspot';
  static const appleStoreUrl =
      'https://apps.apple.com/mx/app/favspot/id1630979750';
  static const maxBlogPosts = 50;
  static const queryLimit = 20;
  static const googleSignInClientId = '222222222.apps.googleusercontent.com';
  static const googleSignInClientIdIOS = '222222.apps.googleusercontent.com';
}
