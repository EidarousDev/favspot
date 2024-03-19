import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/check_in_entity.dart';

class CheckInModel extends CheckInEntity {
  CheckInModel(
      {super.id,
      required super.region,
      required super.place,
      required super.city,
      required super.status,
      required super.userId,
      required super.userName,
      super.imageUrl,
      super.date,
      super.post});

  Map<String, dynamic> toJson() => {
        'region': region,
        'place': place,
        'city': city,
        'status': status,
        'user': userName,
        'userId': userId,
        'date': FieldValue.serverTimestamp(),
        'imageUrl': imageUrl,
        'post': false,
      };

  factory CheckInModel.fromSnapshot(snapshot) {
    final data = snapshot.data();
    return CheckInModel(
      id: snapshot.id,
      region: data['region'],
      place: data['place'],
      city: data['city'],
      status: data['status'],
      userId: data['userId'],
      userName: data['user'],
      imageUrl: data['imageUrl'],
      date: data['date'],
      post: data['post'],
    );
  }
}
