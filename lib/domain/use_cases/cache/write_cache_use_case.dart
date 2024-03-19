import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/cache_repo.dart';

class WriteCacheUseCase extends UseCase<void, CacheParams> {
  final CacheRepo cacheRepo;

  WriteCacheUseCase(this.cacheRepo);
  @override
  Future<Either<Failure, void>> call(CacheParams params) async {
    return await cacheRepo.write(key: params.key!, value: params.value!);
  }
}
