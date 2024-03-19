import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/user_entity.dart';
import '../../repositories/auth_repo.dart';

class AuthenticateUserUseCase extends UseCase<UserEntity, NoParams> {
  final AuthRepo authRepo;

  AuthenticateUserUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepo.authenticateUser();
  }
}
