import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/config/app_config.dart';
import '../../core/config/firestore_config.dart';
import '../models/check_in_model.dart';

abstract class BlogDataSource {
  Future<List<CheckInModel>> getCheckIns({required Timestamp? startAfter});
}

class BlogDataSourceImpl implements BlogDataSource {
  @override
  Future<List<CheckInModel>> getCheckIns(
      {required Timestamp? startAfter}) async {
    Query query = kCheckInRef
        .orderBy('date', descending: true)
        .where('post', isEqualTo: true);
    if (startAfter != null) {
      debugPrint('startAfter=');
      debugPrint('$startAfter');
      query = query.startAfter([startAfter]);
    }
    final result = await query.limit(AppConfig.queryLimit).get();
    final allDocuments = result.docs;
    final checkIns =
        allDocuments.map((doc) => CheckInModel.fromSnapshot(doc)).toList();
    return checkIns;
  }
}
