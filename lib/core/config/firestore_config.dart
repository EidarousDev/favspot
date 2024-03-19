import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../di/di.dart';

final CollectionReference kUsersRef =
    di<FirebaseFirestore>().collection('users');

final CollectionReference kBeachesRef =
    di<FirebaseFirestore>().collection('beaches');

final CollectionReference kRegionsRef =
    di<FirebaseFirestore>().collection('regions');

final CollectionReference kCitiesRef =
    di<FirebaseFirestore>().collection('cities');

final CollectionReference kCheckInRef =
    di<FirebaseFirestore>().collection('checking');

final CollectionReference kDeleteRequestsRef =
    di<FirebaseFirestore>().collection('deleteRequests');

final CollectionReference kAdsRef = di<FirebaseFirestore>().collection('ads');

// Firebase RemoteConfig Parameters
class RemoteConfigParams {
  static const String iOSVersion = 'ios_version';
  static const String androidVersion = 'android_version';
  static const String forceIOSUpdate = 'force_ios_update';
  static const String forceAndroidUpdate = 'force_android_update';
}

class BeachStatus {
  static final String low = 'Low';
  static final String free = 'Free';
  static final String abundant = 'Abundant';
  static final String moderate = 'Moderate';
  static final String excessive = 'Excessive';
}

// Firebase Storage Folder Name
class StoragePaths {
  static const String checkIns = 'check_ins';
}

class Status {
  const Status(this.status, this.icon);
  final String status;
  final Icon icon;
}

final List<Status> kBeachesStatuses = <Status>[
  Status(
      BeachStatus.free,
      Icon(
        Icons.location_on,
        color: Colors.blue,
      )),
  Status(
      BeachStatus.low,
      Icon(
        Icons.location_on,
        color: Colors.green,
      )),
  Status(
      BeachStatus.moderate,
      Icon(
        Icons.location_on,
        color: Colors.yellow,
      )),
  Status(
      BeachStatus.abundant,
      Icon(
        Icons.location_on,
        color: Colors.orange,
      )),
  Status(
      BeachStatus.excessive,
      Icon(
        Icons.location_on,
        color: Colors.red,
      )),
];
