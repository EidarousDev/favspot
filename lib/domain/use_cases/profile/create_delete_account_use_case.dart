import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/profile_repo.dart';

class CreateDeleteAccountRequestUseCase extends UseCase<void, NoParams> {
  final ProfileRepo profileRepo;

  CreateDeleteAccountRequestUseCase(this.profileRepo);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await profileRepo.createDeleteAccountRequest();
  }
}
