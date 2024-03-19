import 'package:dartz/dartz.dart';

import '../../core/failures.dart';

abstract class CacheRepo {
  Future<Either<Failure, String?>> read(String key);
  Future<Either<Failure, void>> write(
      {required String key, required String value});
  Future<Either<Failure, void>> delete(String key);
  Future<Either<Failure, void>> deleteAll();
}
