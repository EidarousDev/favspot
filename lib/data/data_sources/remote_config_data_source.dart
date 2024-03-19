import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../core/config/firestore_config.dart';
import '../models/remote_config_model.dart';

abstract class RemoteConfigDataSource {
  Future<RemoteConfigModel> getConfig();
}

class RemoteConfigDataSourceImpl implements RemoteConfigDataSource {
  final FirebaseRemoteConfig firebaseRemoteConfig;
  RemoteConfigDataSourceImpl({
    required this.firebaseRemoteConfig,
  });

  Future<FirebaseRemoteConfig> setupRemoteConfig() async {
    await firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(minutes: 1),
    ));
    await firebaseRemoteConfig.setDefaults(<String, dynamic>{
      RemoteConfigParams.forceIOSUpdate: false,
      RemoteConfigParams.forceAndroidUpdate: false,
      RemoteConfigParams.iOSVersion: '1.0.0',
      RemoteConfigParams.androidVersion: '1.0.0',
    });
    RemoteConfigValue(null, ValueSource.valueStatic);
    return firebaseRemoteConfig;
  }

  @override
  Future<RemoteConfigModel> getConfig() async {
    //setupRemoteConfig();
    await firebaseRemoteConfig.fetchAndActivate();
    final forceAndroidUpdate =
        firebaseRemoteConfig.getBool(RemoteConfigParams.forceAndroidUpdate);
    final forceIOSUpdate =
        firebaseRemoteConfig.getBool(RemoteConfigParams.forceIOSUpdate);
    final androidVersion =
        firebaseRemoteConfig.getString(RemoteConfigParams.androidVersion);
    final iOSVersion =
        firebaseRemoteConfig.getString(RemoteConfigParams.iOSVersion);
    // debugPrint(
    //     'forceAndroidUpdate = $forceAndroidUpdate & forceiOSUpdate = $forceIOSUpdate, androidVersion = $androidVersion, iOSVersion = $iOSVersion');
    return RemoteConfigModel(
        androidVersion: androidVersion,
        iOSVersion: iOSVersion,
        forceIOSUpdate: forceIOSUpdate,
        forceAndroidUpdate: forceAndroidUpdate);
  }
}
