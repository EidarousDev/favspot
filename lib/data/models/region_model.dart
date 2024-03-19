import '../../domain/entities/region_entity.dart';

class RegionModel extends RegionEntity {
  RegionModel(
      {required super.id, required super.region, required super.location});

  factory RegionModel.fromSnapshot(snapshot) {
    final data = snapshot.data();
    return RegionModel(
        id: snapshot.id, region: data['region'], location: data['location']);
  }
}
