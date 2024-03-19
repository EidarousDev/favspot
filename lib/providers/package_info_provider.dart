import 'package:flutter/material.dart';

import '../core/use_case.dart';
import '../domain/use_cases/package_info/get_app_info_use_case.dart';

class PackageInfoProvider extends ChangeNotifier {
  final GetAppInfoUseCase getAppInfoUseCase;

  PackageInfoProvider({required this.getAppInfoUseCase});

  // Private States
  String _packageName = '';
  String _appName = '';
  String _version = '';
  String _buildNumber = '';

  // Getters
  String get packageName => _packageName;
  String get appName => _appName;
  String get version => _version;
  String get buildNumber => _buildNumber;

  // Methods
  Future<void> getAppInfo() async {
    debugPrint('=== getAppInfo ===');
    final result = await getAppInfoUseCase(NoParams());
    result.fold((l) => debugPrint('Failed to get App Info'), (info) {
      _packageName = info.packageName;
      _appName = info.appName;
      _version = info.version;
      _buildNumber = info.buildNumber;
      debugPrint('AppVersion = $_version');
    });
    notifyListeners();
  }

  Future<void> checkForUpdate(
      {required String remoteVersion, required Function onForceUpdate}) async {
    /// remoteVersion parameter is read from the backend (Firebase Remote Config)
    /// onForceUpdate a callback function to let you decide what to do if the update is required.
    debugPrint('remoteVersion = $remoteVersion while appVersion = $_version');
    if (remoteVersion != _version) {
      onForceUpdate();
    }
  }
}
