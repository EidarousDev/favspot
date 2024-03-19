import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../data/models/check_in_model.dart';
import 'failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class CacheParams {
  final String? key;
  final String? value;

  CacheParams({this.key, this.value});
}

class SendEmailParams {
  final String name;
  final String email;
  final String subject;
  final String message;

  SendEmailParams(
      {required this.name,
      required this.email,
      required this.subject,
      required this.message});
}

class NotifyAdminParams {
  final String message;

  NotifyAdminParams({required this.message});
}

class UpdateDeviceTokenParams {
  final String deviceToken;
  final bool loggedIn;

  UpdateDeviceTokenParams({required this.deviceToken, required this.loggedIn});
}

class CitiesParams {
  final String region;

  CitiesParams({required this.region});
}

class UploadFileParams {
  final File file;

  UploadFileParams(this.file);
}

class DownloadFileParams {
  final String url;

  DownloadFileParams(this.url);
}

class CheckInParams {
  final CheckInModel checkInModel;

  CheckInParams({required this.checkInModel});
}

class LaunchUrlParams {
  final String emailOrUrl;

  LaunchUrlParams({required this.emailOrUrl});
}

class BlogParams {
  final Timestamp? startAfter;

  BlogParams({this.startAfter});
}

class NoParams {}
