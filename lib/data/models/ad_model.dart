import '../../domain/entities/ad_entity.dart';

class AdModel extends AdEntity {
  AdModel(
      {required super.id,
      required super.imageUrl,
      super.region,
      super.url,
      required super.date,
      required super.enabled});

  factory AdModel.fromSnapshot(snapshot) {
    final data = snapshot.data();
    return AdModel(
        id: snapshot.id,
        imageUrl: data['imageUrl'],
        region: data['region'],
        url: data['url'],
        date: data['date'],
        enabled: data['enabled']);
  }
}
