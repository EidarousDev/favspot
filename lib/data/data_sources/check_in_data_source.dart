import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/config/app_config.dart';
import '../../core/config/firestore_config.dart';
import '../models/check_in_model.dart';

abstract class CheckInDataSource {
  Future<void> createCheckIn(CheckInModel checkInModel);
  Future<void> notifyAdminByEmail({required String message});
}

class CheckInDataSourceImpl implements CheckInDataSource {
  @override
  Future<void> createCheckIn(CheckInModel checkInModel) async {
    await kCheckInRef.add(checkInModel.toJson());
  }

  @override
  Future<void> notifyAdminByEmail({required String message}) async {
    final url = Uri.parse(AppConfig.emailAPI);
    await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': AppConfig.emailServiceId,
        'template_id': 'template_0qg38af',
        'user_id': AppConfig.emailServiceUserId,
        'template_params': {
          'user_name': "FavSpot Checking",
          'user_email': "hello@favspot.io",
          'user_subject': "FavSpot Checking",
          'user_message': message,
        }
      }),
    );
  }
}
