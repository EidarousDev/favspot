import 'package:dartz/dartz.dart';

import '../../core/failures.dart';

abstract class AdvertiseRepo {
  Future<Either<Failure, void>> sendEmail(
      {required String name,
      required String email,
      required String subject,
      required String message});
}
