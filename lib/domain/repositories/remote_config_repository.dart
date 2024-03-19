import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/remote_config_entity.dart';

abstract class RemoteConfigRepository {
  Future<Either<Failure, RemoteConfigEntity>> getConfig();
}
