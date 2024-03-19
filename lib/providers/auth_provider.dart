import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../core/config/app_config.dart';
import '../core/use_case.dart';
import '../domain/entities/user_entity.dart';
import '../domain/use_cases/auth/authenticate_user_use_case.dart';
import '../domain/use_cases/auth/login_apple_use_case.dart';
import '../domain/use_cases/auth/login_facebook_use_case.dart';
import '../domain/use_cases/auth/login_google_use_case.dart';
import '../domain/use_cases/auth/logout_use_case.dart';
import '../domain/use_cases/profile/remove_delete_request_use_case.dart';

class AuthProvider extends ChangeNotifier {
  final AuthenticateUserUseCase authenticateUserUseCase;
  final LoginAppleUseCase loginAppleUseCase;
  final LoginFacebookUseCase loginFacebookUseCase;
  final LoginGoogleUseCase loginGoogleUseCase;
  final LogoutUseCase logoutUseCase;
  final RemoveDeleteAccountRequestUseCase removeDeleteAccountRequestUseCase;

  AuthProvider(
      {required this.authenticateUserUseCase,
      required this.loginAppleUseCase,
      required this.loginFacebookUseCase,
      required this.loginGoogleUseCase,
      required this.logoutUseCase, required this.removeDeleteAccountRequestUseCase});

  UserEntity? _user;

  UserEntity? get user => _user;

  Future<void> checkAuth() async {
    debugPrint('=== checkAuth ===');
    EasyLoading.show();
    final result = await authenticateUserUseCase(NoParams());
    result.fold((l) {
      if (_user != null) {
        // Authentication failed, make sure user variables are null
        _user = null;
        AppConfig.uid = '';
      }
    }, (user) {
      debugPrint('User Authenticated :)');
      AppConfig.uid = user.id;
      _user = user;
    });
    notifyListeners();
    EasyLoading.dismiss();
  }

  Future<void> logout({required Function onSuccess}) async {
    EasyLoading.show();
    final result = await logoutUseCase(
        UpdateDeviceTokenParams(loggedIn: false, deviceToken: ''));
    result.fold((l) => null, (success) {
      AppConfig.uid = '';
      _user = null;
      onSuccess();
    });
    notifyListeners();
    EasyLoading.dismiss();
  }

  Future<void> signInWithGoogle({required Function onSuccess, required Function(String errorMessage) onFailure}) async {
    EasyLoading.show();
    final result = await loginGoogleUseCase(NoParams());
    result.fold((l) {
      if (_user != null) {
        // Login failed, make sure user variables are null
        _user = null;
        AppConfig.uid = '';
          onFailure('Login Failed: ${l.message!}');
      }
    }, (user) {
      AppConfig.uid = user.id;
      _user = user;
      removeDeleteRequestIfExists();
      onSuccess();
    });
    debugPrint('After onSuccess ${user?.id}');
    notifyListeners();
    EasyLoading.dismiss();
  }

  Future<void> signInWithApple({required Function onSuccess}) async {
    EasyLoading.show();
    final result = await loginAppleUseCase(NoParams());
    result.fold((l) {
      if (_user != null) {
        // Login failed, make sure user variables are null
        _user = null;
        AppConfig.uid = '';
      }
    }, (user) {
      AppConfig.uid = user.id;
      _user = user;
      removeDeleteRequestIfExists();
      onSuccess();
    });
    notifyListeners();
    EasyLoading.dismiss();
  }

  Future<void> signInWithFacebook({required Function onSuccess}) async {
    EasyLoading.show();
    final result = await loginFacebookUseCase(NoParams());
    result.fold((l) {
      if (_user != null) {
        // Login failed, make sure user variables are null
        _user = null;
        AppConfig.uid = '';
      }
    }, (user) {
      AppConfig.uid = user.id;
      _user = user;
      removeDeleteRequestIfExists();
      onSuccess();
    });
    notifyListeners();
    EasyLoading.dismiss();
  }

  Future<void> removeDeleteRequestIfExists() async {
    await removeDeleteAccountRequestUseCase(NoParams());
  }
}
