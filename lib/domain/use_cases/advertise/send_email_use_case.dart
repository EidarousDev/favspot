import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/advertise_repo.dart';

class SendEmailUseCase extends UseCase<void, SendEmailParams> {
  final AdvertiseRepo advertiseRepo;

  SendEmailUseCase(this.advertiseRepo);
  @override
  Future<Either<Failure, void>> call(SendEmailParams params) async {
    return await advertiseRepo.sendEmail(
        name: params.name,
        email: params.email,
        subject: params.subject,
        message: params.message);
  }
}
