import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/cache_repo.dart';

class ReadCacheUseCase extends UseCase<String?, CacheParams> {
  final CacheRepo cacheRepo;

  ReadCacheUseCase(this.cacheRepo);
  @override
  Future<Either<Failure, String?>> call(CacheParams params) async {
    return await cacheRepo.read(params.key!);
  }
}
