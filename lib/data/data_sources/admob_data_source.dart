import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/config/admob_config.dart';
import '../../core/config/firestore_config.dart';
import '../models/ad_model.dart';

abstract class AdmobDataSource {
  Future<List<AdModel>> getCustomAds();
  Future<BannerAd?> createBannerAd();
  Future<void> createInterstitialAd();
}

class AdmobDataSourceImpl implements AdmobDataSource {
  @override
  Future<BannerAd?> createBannerAd() async {
    return await BannerAd(
        size: AdSize.banner,
        adUnitId: AdmobConfig.bannerAdUnitId,
        listener: AdmobConfig.bannerAdListener,
        request: const AdRequest())
      ..load();
  }

  @override
  Future<void> createInterstitialAd() async {
    await InterstitialAd.load(
        adUnitId: AdmobConfig.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              ad.fullScreenContentCallback = FullScreenContentCallback(
                  onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                //createInterstitialAdUseCase(NoParams()); // create a new ad
              }, onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                //createInterstitialAdUseCase(NoParams()); // create a new ad
              });
              ad.show();
            },
            onAdFailedToLoad: (error) =>
                debugPrint('Failed to load InterstitialAd')));
  }

  @override
  Future<List<AdModel>> getCustomAds() async {
    final result = await kAdsRef
        .where('imageUrl', isNull: false)
        .where('enabled', isEqualTo: true)
        .get();
    final allDocuments = result.docs;
    final ads = allDocuments.map((doc) => AdModel.fromSnapshot(doc)).toList();
    return ads;
  }
}
