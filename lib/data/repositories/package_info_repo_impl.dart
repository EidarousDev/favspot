import 'package:dartz/dartz.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/failures.dart';
import '../../domain/entities/package_info_entity.dart';
import '../../domain/repositories/package_info_repo.dart';

class PackageInfoRepoImpl implements PackageInfoRepo {
  @override
  Future<Either<Failure, PackageInfoEntity>> getAppInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return Right(PackageInfoEntity(
        appName: info.appName,
        packageName: info.packageName,
        buildNumber: info.buildNumber,
        version: info.version));
  }
}
