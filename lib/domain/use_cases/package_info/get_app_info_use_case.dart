import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/package_info_entity.dart';
import '../../repositories/package_info_repo.dart';

class GetAppInfoUseCase extends UseCase<PackageInfoEntity, NoParams> {
  final PackageInfoRepo packageInfoRepo;

  GetAppInfoUseCase(this.packageInfoRepo);
  @override
  Future<Either<Failure, PackageInfoEntity>> call(NoParams params) async {
    return await packageInfoRepo.getAppInfo();
  }
}
