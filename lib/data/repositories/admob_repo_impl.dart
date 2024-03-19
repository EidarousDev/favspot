import 'package:dartz/dartz.dart';
import 'package:google_mobile_ads/src/ad_containers.dart';

import '../../core/failures.dart';
import '../../domain/entities/ad_entity.dart';
import '../../domain/repositories/admob_repo.dart';
import '../data_sources/admob_data_source.dart';

class AdmobRepoImpl implements AdmobRepo {
  final AdmobDataSource admobDataSource;

  AdmobRepoImpl(this.admobDataSource);

  @override
  Future<Either<Failure, BannerAd?>> createBannerAd() async {
    try {
      return Right(await admobDataSource.createBannerAd());
    } catch (ex) {
      return Left(HttpFailure(message: '$ex'));
    }
  }

  @override
  Future<Either<Failure, void>> createInterstitialAd() async {
    try {
      return Right(await admobDataSource.createInterstitialAd());
    } catch (ex) {
      return Left(HttpFailure(message: '$ex'));
    }
  }

  @override
  Future<Either<Failure, List<AdEntity>>> getCustomAds() async {
    try {
      return Right(await admobDataSource.getCustomAds());
    } catch (ex) {
      return Left(HttpFailure(message: '$ex'));
    }
  }
}
