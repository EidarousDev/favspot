import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../domain/repositories/check_in_repo.dart';
import '../data_sources/check_in_data_source.dart';
import '../models/check_in_model.dart';

class CheckInRepoImpl implements CheckInRepo {
  final CheckInDataSource checkInDataSource;

  CheckInRepoImpl(this.checkInDataSource);

  @override
  Future<Either<Failure, void>> createCheckIn(CheckInModel checkInModel) async {
    try {
      return Right(await checkInDataSource.createCheckIn(checkInModel));
    } catch (ex) {
      return Left(HttpFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> notifyAdminByEmail(
      {required String message}) async {
    try {
      return Right(
          await checkInDataSource.notifyAdminByEmail(message: message));
    } catch (ex) {
      return Left(HttpFailure(message: ex.toString()));
    }
  }
}
