import 'package:dartz/dartz.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../repositories/admob_repo.dart';

class CreateBannerAdUseCase extends UseCase<BannerAd?, NoParams> {
  final AdmobRepo admobRepo;

  CreateBannerAdUseCase(this.admobRepo);
  @override
  Future<Either<Failure, BannerAd?>> call(NoParams params) async {
    return await admobRepo.createBannerAd();
  }
}
