import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:favspot/core/failures.dart';

import '../../domain/entities/check_in_entity.dart';
import '../../domain/repositories/blog_repo.dart';
import '../data_sources/blog_data_source.dart';

class BlogRepoImpl implements BlogRepo {
  final BlogDataSource blogDataSource;

  BlogRepoImpl(this.blogDataSource);
  @override
  Future<Either<Failure, List<CheckInEntity>>> getCheckIns(
      {required Timestamp? startAfter}) async {
    try {
      return Right(await blogDataSource.getCheckIns(startAfter: startAfter));
    } catch (ex) {
      return Left(CacheFailure(message: '$ex'));
    }
  }
}
