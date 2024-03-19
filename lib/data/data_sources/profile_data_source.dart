import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/config/app_config.dart';
import '../../core/config/firestore_config.dart';

abstract class ProfileDataSource {
  Future<void> createDeleteAccountRequest();
  Future<void> removeDeleteRequestIfExists();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  @override
  Future<void> createDeleteAccountRequest() async {
    await kDeleteRequestsRef.add(
        {'userId': AppConfig.uid, 'timestamp': FieldValue.serverTimestamp()});
  }

  @override
  Future<void> removeDeleteRequestIfExists() async {
    final result = await kDeleteRequestsRef.where('userId', isEqualTo: AppConfig.uid).get();
    if(result.size > 0){
      result.docs.forEach((doc) => doc.reference.delete());
    }
  }
}
