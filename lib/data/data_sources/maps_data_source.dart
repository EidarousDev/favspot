import '../../core/config/firestore_config.dart';
import '../models/beach_model.dart';
import '../models/city_model.dart';
import '../models/region_model.dart';

abstract class MapsDataSource {
  Future<List<BeachModel>> getBeaches();
  Future<List<RegionModel>> getRegions();
  Future<List<CityModel>> getCitiesInRegion(String region);
}

class MapsDataSourceImpl implements MapsDataSource {
  @override
  Future<List<BeachModel>> getBeaches() async {
    final result = await kBeachesRef.get();
    final allDocuments = result.docs;
    final beaches =
        allDocuments.map((doc) => BeachModel.fromSnapshot(doc)).toList();
    return beaches;
  }

  @override
  Future<List<RegionModel>> getRegions() async {
    final result = await kRegionsRef.get();
    final allDocuments = result.docs;
    final regions =
        allDocuments.map((doc) => RegionModel.fromSnapshot(doc)).toList();
    return regions;
  }

  @override
  Future<List<CityModel>> getCitiesInRegion(String region) async {
    final result = await kCitiesRef.where('region', isEqualTo: region).orderBy('name').get();
    final allDocuments = result.docs;
    final cities =
        allDocuments.map((doc) => CityModel.fromSnapshot(doc)).toList();
    return cities;
  }
}
