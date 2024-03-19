import 'package:cloud_firestore/cloud_firestore.dart';

class CheckInEntity {
  final String? id;
  final String region;
  final String place;
  final String city;
  final String status;
  final String? userId;
  final String? userName;
  final String? imageUrl;
  final Timestamp? date;
  final bool? post;

  CheckInEntity(
      {this.id,
      required this.region,
      required this.place,
      required this.city,
      required this.status,
      required this.userId,
      required this.userName,
      this.imageUrl,
      this.date,
      this.post});
}
