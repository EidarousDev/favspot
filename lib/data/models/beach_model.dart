import '../../core/config/app_config.dart';
import '../../domain/entities/beach_entity.dart';

class BeachModel extends BeachEntity {
  BeachModel(
      {required super.id,
      required super.description,
      required super.imageUrl,
      required super.city,
      required super.place,
      required super.region,
      required super.status,
      required super.timestamp,
      required super.location});

  Map<String, dynamic> toJson() => {
        'place': place,
        'city': city,
        'region': region,
        'status': status,
        'Descripcion': description,
        'location': location,
        'ImageUrl': imageUrl,
      };

  factory BeachModel.fromSnapshot(snapshot) {
    final data = snapshot.data();
    return BeachModel(
        id: snapshot.id,
        description: data['Descripcion'] ?? '',
        imageUrl: data['ImageURL'] ?? AppConfig.imagePlaceHolder,
        city: data['city'] ?? '',
        place: data['place'] ?? '',
        region: data['region'] ?? '',
        status: data['status'] ?? '',
        timestamp: data['date'],
        location: data['location']);
  }
}
