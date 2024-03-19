import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/url_launcher_repo.dart';

class LaunchUrlUseCase extends UseCase<void, LaunchUrlParams> {
  final UrlLauncherRepo urlLauncherRepo;

  LaunchUrlUseCase(this.urlLauncherRepo);

  @override
  Future<Either<Failure, void>> call(params) async {
    return await urlLauncherRepo.launchUrl(url: params.emailOrUrl);
  }
}
