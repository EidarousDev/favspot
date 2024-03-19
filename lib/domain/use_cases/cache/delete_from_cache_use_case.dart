import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/cache_repo.dart';

class DeleteFromCacheUseCase extends UseCase<void, CacheParams> {
  final CacheRepo cacheRepo;

  DeleteFromCacheUseCase(this.cacheRepo);
  @override
  Future<Either<Failure, void>> call(CacheParams params) async {
    return await cacheRepo.delete(params.key!);
  }
}
