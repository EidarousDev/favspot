import 'package:dartz/dartz.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/failures.dart';
import '../entities/ad_entity.dart';

abstract class AdmobRepo {
  Future<Either<Failure, List<AdEntity>>> getCustomAds();
  Future<Either<Failure, BannerAd?>> createBannerAd();
  Future<Either<Failure, void>> createInterstitialAd();
}
