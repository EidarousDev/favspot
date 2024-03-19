import 'package:cloud_firestore/cloud_firestore.dart';

class AdEntity {
  final String id;
  final String imageUrl;
  final String? region;
  String? url;
  final bool enabled;
  final Timestamp date;

  AdEntity(
      {required this.id,
      required this.imageUrl,
      this.region,
      required this.url,
      required this.date,
      required this.enabled});
}
