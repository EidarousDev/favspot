import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../domain/entities/remote_config_entity.dart';
import '../../domain/repositories/remote_config_repository.dart';
import '../data_sources/remote_config_data_source.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  final RemoteConfigDataSource remoteConfigDataSource;

  RemoteConfigRepositoryImpl(this.remoteConfigDataSource);

  @override
  Future<Either<Failure, RemoteConfigEntity>> getConfig() async {
    try {
      final result = await remoteConfigDataSource.getConfig();
      return Right(result);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }
}
