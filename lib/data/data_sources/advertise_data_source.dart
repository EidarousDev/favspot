import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/config/app_config.dart';

abstract class AdvertiseDataSource {
  Future<void> sendEmail(
      {required String name,
      required String email,
      required String subject,
      required String message});
}

class AdvertiseDataSourceImpl implements AdvertiseDataSource {
  @override
  Future<void> sendEmail(
      {required String name,
      required String email,
      required String subject,
      required String message}) async {
    final url = Uri.parse(AppConfig.emailAPI);
    await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': AppConfig.emailServiceId,
        'template_id': 'template_3du4lim',
        'user_id': AppConfig.emailServiceUserId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        }
      }),
    );
  }
}
