import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/check_in_repo.dart';

class CreateCheckInUseCase extends UseCase<void, CheckInParams> {
  final CheckInRepo checkInRepo;

  CreateCheckInUseCase(this.checkInRepo);
  @override
  Future<Either<Failure, void>> call(params) async {
    return await checkInRepo.createCheckIn(params.checkInModel);
  }
}
