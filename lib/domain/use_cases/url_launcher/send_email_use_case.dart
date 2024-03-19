import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/url_launcher_repo.dart';

class OpenEmailUseCase extends UseCase<void, LaunchUrlParams> {
  final UrlLauncherRepo urlLauncherRepo;

  OpenEmailUseCase(this.urlLauncherRepo);

  @override
  Future<Either<Failure, void>> call(LaunchUrlParams params) async {
    return await urlLauncherRepo.openEmail(email: params.emailOrUrl);
  }
}
