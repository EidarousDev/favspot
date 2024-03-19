import 'package:flutter/material.dart';

import '../core/use_case.dart';
import '../domain/use_cases/remote_config/get_remote_config_use_case.dart';

class RemoteConfigProvider extends ChangeNotifier {
  final GetRemoteConfigUseCase getRemoteConfigUseCase;

  RemoteConfigProvider({required this.getRemoteConfigUseCase});

  // Private States
  bool _forceIOSUpdate = false;
  bool _forceAndroidUpdate = true;
  String _iOSVersion = '1.0.0';
  String _androidVersion = '1.0.0';

  // Getters
  bool get forceIOSUpdate => _forceIOSUpdate;
  bool get forceAndroidUpdate => _forceAndroidUpdate;
  String get iOSVersion => _iOSVersion;
  String get androidVersion => _androidVersion;

  // Methods
  Future<void> getRemoteConfigValues() async {
    debugPrint('==== getRemoteConfigValues ====');
    final result = await getRemoteConfigUseCase(NoParams());
    result.fold((l) => debugPrint('Failed to get Remote Config Values'),
        (config) {
      debugPrint('Got Remote Config!!!!');
      _forceIOSUpdate = config.forceIOSUpdate;
      _forceAndroidUpdate = config.forceAndroidUpdate;
      _iOSVersion = config.iOSVersion;
      _androidVersion = config.androidVersion;
    });
    notifyListeners();
  }
}
