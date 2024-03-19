import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/cache_repo.dart';

class DeleteAllCacheUseCase extends UseCase<void, NoParams> {
  final CacheRepo cacheRepo;

  DeleteAllCacheUseCase(this.cacheRepo);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await cacheRepo.deleteAll();
  }
}
