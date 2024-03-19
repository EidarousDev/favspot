import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/check_in_repo.dart';

class NotifyAdminByEmailUseCase extends UseCase<void, NotifyAdminParams> {
  final CheckInRepo checkInRepo;

  NotifyAdminByEmailUseCase(this.checkInRepo);
  @override
  Future<Either<Failure, void>> call(NotifyAdminParams params) async {
    return await checkInRepo.notifyAdminByEmail(message: params.message);
  }
}
