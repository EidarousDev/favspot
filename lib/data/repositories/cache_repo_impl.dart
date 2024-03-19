import 'package:dartz/dartz.dart';
import 'package:favspot/core/failures.dart';

import '../../domain/repositories/cache_repo.dart';
import '../data_sources/cache_data_source.dart';

class CacheRepoImpl implements CacheRepo {
  final CacheDataSource cacheDataSource;

  CacheRepoImpl(this.cacheDataSource);

  @override
  Future<Either<Failure, void>> delete(String key) async {
    try {
      return Right(await cacheDataSource.delete(key));
    } catch (ex) {
      return Left(CacheFailure(message: '$ex'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAll() async {
    try {
      return Right(await cacheDataSource.deleteAll());
    } catch (ex) {
      return Left(CacheFailure(message: '$ex'));
    }
  }

  @override
  Future<Either<Failure, String?>> read(String key) async {
    try {
      return Right(await cacheDataSource.read(key));
    } catch (ex) {
      return Left(CacheFailure(message: '$ex'));
    }
  }

  @override
  Future<Either<Failure, void>> write(
      {required String key, required String value}) async {
    try {
      return Right(await cacheDataSource.write(key: key, value: value));
    } catch (ex) {
      return Left(CacheFailure(message: '$ex'));
    }
  }
}
