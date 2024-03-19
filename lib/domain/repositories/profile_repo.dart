import 'package:dartz/dartz.dart';

import '../../core/failures.dart';

abstract class ProfileRepo {
  Future<Either<Failure, void>> createDeleteAccountRequest();
  Future<Either<Failure, void>> removeDeleteRequestIfExists();
}
