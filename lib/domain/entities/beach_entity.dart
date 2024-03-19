import 'package:cloud_firestore/cloud_firestore.dart';

class BeachEntity {
  final String id;
  final String description;
  final String imageUrl;
  final String city;
  final String place;
  final String status;
  final String region;
  final Timestamp timestamp;
  final GeoPoint location;

  BeachEntity(
      {required this.id,
      required this.description,
      required this.imageUrl,
      required this.city,
      required this.region,
      required this.place,
      required this.status,
      required this.timestamp,
      required this.location});
}
