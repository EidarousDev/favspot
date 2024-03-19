import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/check_in_entity.dart';

abstract class BlogRepo {
  Future<Either<Failure, List<CheckInEntity>>> getCheckIns(
      {required Timestamp? startAfter});
}
