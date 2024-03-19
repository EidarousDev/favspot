import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> authenticateUser();
  Future<Either<Failure, UserEntity>> loginWithGoogle();
  Future<Either<Failure, UserEntity>> loginWithApple();
  Future<Either<Failure, UserEntity>> loginWithFacebook();
  Future<Either<Failure, Unit>> logout();
}
