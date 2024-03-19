import 'package:cloud_firestore/cloud_firestore.dart';

class RegionEntity {
  final String id;
  final String region;
  final GeoPoint location;

  RegionEntity(
      {required this.id, required this.region, required this.location});
}
