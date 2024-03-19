import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/package_info_entity.dart';

abstract class PackageInfoRepo {
  Future<Either<Failure, PackageInfoEntity>> getAppInfo();
}
