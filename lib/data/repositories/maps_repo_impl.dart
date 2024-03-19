import 'package:dartz/dartz.dart';
import 'package:favspot/domain/entities/city_entity.dart';
import 'package:favspot/domain/entities/region_entity.dart';

import '../../core/failures.dart';
import '../../domain/repositories/maps_repo.dart';
import '../data_sources/maps_data_source.dart';
import '../models/beach_model.dart';

class MapsRepoImpl implements MapsRepo {
  final MapsDataSource mapsDataSource;

  MapsRepoImpl(this.mapsDataSource);
  @override
  Future<Either<Failure, List<BeachModel>>> getBeaches() async {
    try {
      return Right(await mapsDataSource.getBeaches());
    } catch (ex) {
      return Left(ServerFailure(message: '$ex'));
    }
  }

  @override
  Future<Either<Failure, List<RegionEntity>>> getRegions() async {
    try {
      return Right(await mapsDataSource.getRegions());
    } catch (ex) {
      return Left(ServerFailure(message: '$ex'));
    }
  }

  @override
  Future<Either<Failure, List<CityEntity>>> getCitiesInRegion(
      String region) async {
    try {
      return Right(await mapsDataSource.getCitiesInRegion(region));
    } catch (ex) {
      return Left(ServerFailure(message: '$ex'));
    }
  }
}
