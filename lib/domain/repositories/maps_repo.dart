import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/beach_entity.dart';
import '../entities/city_entity.dart';
import '../entities/region_entity.dart';

abstract class MapsRepo {
  Future<Either<Failure, List<BeachEntity>>> getBeaches();
  Future<Either<Failure, List<RegionEntity>>> getRegions();
  Future<Either<Failure, List<CityEntity>>> getCitiesInRegion(String region);
}
