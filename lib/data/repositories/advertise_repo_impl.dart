import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../domain/repositories/advertise_repo.dart';
import '../data_sources/advertise_data_source.dart';

class AdvertiseRepoImpl implements AdvertiseRepo {
  final AdvertiseDataSource advertiseDataSource;

  AdvertiseRepoImpl(this.advertiseDataSource);
  @override
  Future<Either<Failure, void>> sendEmail(
      {required String name,
      required String email,
      required String subject,
      required String message}) async {
    try {
      return Right(await advertiseDataSource.sendEmail(
          name: name, email: email, subject: subject, message: message));
    } catch (ex) {
      return Left(HttpFailure(message: '$ex'));
    }
  }
}
