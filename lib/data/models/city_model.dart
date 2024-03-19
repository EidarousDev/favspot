import '../../domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  CityModel(
      {required super.id,
      required super.location,
      required super.name,
      required super.region,
      required super.appear});

  Map<String, dynamic> toJson() => {
        'location': location,
        'name': name,
        'region': region,
        'screen_appear': appear,
      };

  factory CityModel.fromSnapshot(snapshot) {
    final data = snapshot.data();
    return CityModel(
        id: snapshot.id,
        region: data['region'],
        location: data['location'],
        name: data['name'],
        appear: data['screen_appear']);
  }
}
