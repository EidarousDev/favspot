import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/remote_config_entity.dart';
import '../../repositories/remote_config_repository.dart';

class GetRemoteConfigUseCase extends UseCase<RemoteConfigEntity, NoParams> {
  final RemoteConfigRepository remoteConfigRepository;

  GetRemoteConfigUseCase(this.remoteConfigRepository);
  @override
  Future<Either<Failure, RemoteConfigEntity>> call(NoParams params) async {
    return await remoteConfigRepository.getConfig();
  }
}
