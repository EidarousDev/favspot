import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import '../../core/config/firestore_config.dart';
import '../../domain/entities/remote_config_entity.dart';

class RemoteConfigModel extends RemoteConfigEntity {
  RemoteConfigModel(
      {required super.androidVersion,
      required super.iOSVersion,
      required super.forceAndroidUpdate,
      required super.forceIOSUpdate});

  factory RemoteConfigModel.fromMap(Map<String, RemoteConfigValue> config) {
    debugPrint('config[RemoteConfigParams.androidVersion]!.source.name');
    debugPrint('${config[RemoteConfigParams.androidVersion]!.source.name}');
    return RemoteConfigModel(
        androidVersion: config[RemoteConfigParams.androidVersion]!.asString(),
        iOSVersion: config[RemoteConfigParams.iOSVersion]!.asString(),
        forceAndroidUpdate:
            config[RemoteConfigParams.forceAndroidUpdate]!.asBool(),
        forceIOSUpdate: config[RemoteConfigParams.forceIOSUpdate]!.asBool());
  }
}
