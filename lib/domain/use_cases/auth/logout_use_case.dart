import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/auth_repo.dart';

class LogoutUseCase extends UseCase<Unit, UpdateDeviceTokenParams> {
  final AuthRepo authRepo;

  LogoutUseCase(this.authRepo);
  @override
  Future<Either<Failure, Unit>> call(UpdateDeviceTokenParams params) async {
    return await authRepo.logout();
  }
}
