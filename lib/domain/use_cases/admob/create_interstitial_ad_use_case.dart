import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/admob_repo.dart';

class CreateInterstitialAdUseCase extends UseCase<void, NoParams> {
  final AdmobRepo admobRepo;

  CreateInterstitialAdUseCase(this.admobRepo);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await admobRepo.createInterstitialAd();
  }
}
