import 'package:cloud_firestore/cloud_firestore.dart';

class CityEntity {
  final String id;
  final GeoPoint location;
  final String name;
  final String region;
  final bool appear;

  CityEntity(
      {required this.id,
      required this.location,
      required this.name,
      required this.region,
      required this.appear});
}
