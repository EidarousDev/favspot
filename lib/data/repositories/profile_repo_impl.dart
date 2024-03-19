import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../domain/repositories/profile_repo.dart';
import '../data_sources/profile_data_source.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileDataSource profileDataSource;

  ProfileRepoImpl(this.profileDataSource);
  @override
  Future<Either<Failure, void>> createDeleteAccountRequest() async {
    try {
      return Right(await profileDataSource.createDeleteAccountRequest());
    } catch (ex) {
      return Left(ServerFailure(message: '$ex'));
    }
  }

  @override
  Future<Either<Failure, void>> removeDeleteRequestIfExists() async {
    try {
      return Right(await profileDataSource.removeDeleteRequestIfExists());
    } catch (ex) {
    return Left(ServerFailure(message: '$ex'));
    }
  }
}
