import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../data/models/check_in_model.dart';

abstract class CheckInRepo {
  Future<Either<Failure, void>> createCheckIn(CheckInModel checkInModel);
  Future<Either<Failure, void>> notifyAdminByEmail({required String message});
}
