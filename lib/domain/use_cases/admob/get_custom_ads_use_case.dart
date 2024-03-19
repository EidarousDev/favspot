import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../../core/use_case.dart';
import '../../entities/ad_entity.dart';
import '../../repositories/admob_repo.dart';

class GetCustomAdsUseCase extends UseCase<List<AdEntity>, NoParams> {
  final AdmobRepo admobRepo;

  GetCustomAdsUseCase(this.admobRepo);
  @override
  Future<Either<Failure, List<AdEntity>>> call(NoParams params) async {
    return await admobRepo.getCustomAds();
  }
}
