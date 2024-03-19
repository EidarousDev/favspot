import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../data_sources/auth_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImpl(this.authDataSource);
  @override
  Future<Either<Failure, UserEntity>> authenticateUser() async {
    try {
      return Right(await authDataSource.authenticateUser());
    } catch (ex) {
      return Left(ServerFailure(
          message: ex is FirebaseAuthException ? ex.message : ex.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithFacebook() async {
    try {
      final user = await authDataSource.loginWithFacebook();
      return Right(user);
    } catch (ex) {
      return Left(ServerFailure(
          message: ex is FirebaseAuthException ? ex.message : ex.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithApple() async {
    try {
      final user = await authDataSource.loginWithApple();
      return Right(user);
    } catch (ex) {
      return Left(ServerFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle() async {
    try {
      final user = await authDataSource.loginWithGoogle();
      return Right(user);
    } catch (ex) {
      return Left(ServerFailure(
          message: ex is FirebaseAuthException ? ex.message : ex.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await authDataSource.logout();
      return const Right(unit);
    } catch (ex) {
      // Couldn't logout for some reason
      return Left(ServerFailure(
          message: ex is FirebaseAuthException ? ex.message : ex.toString()));
    }
  }
}
