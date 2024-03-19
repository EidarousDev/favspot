import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/use_case.dart';
import '../domain/entities/ad_entity.dart';
import '../domain/use_cases/admob/create_banner_ad_use_case.dart';
import '../domain/use_cases/admob/create_interstitial_ad_use_case.dart';
import '../domain/use_cases/admob/get_custom_ads_use_case.dart';

class AdmobProvider extends ChangeNotifier {
  final CreateBannerAdUseCase createBannerAdUseCase;
  final CreateInterstitialAdUseCase createInterstitialAdUseCase;
  final GetCustomAdsUseCase getCustomAdsUseCase;

  AdmobProvider({
    required this.createBannerAdUseCase,
    required this.createInterstitialAdUseCase,
    required this.getCustomAdsUseCase,
  });

  // Private State
  BannerAd? _bannerAd;
  List<AdEntity> _customAds = [];

  // Getters
  BannerAd? get bannerAd => _bannerAd;
  UnmodifiableListView<AdEntity> get customAds =>
      UnmodifiableListView(_customAds);

  void showBannerAd() async {
    final result = await createBannerAdUseCase(NoParams());
    result.fold((l) {
      debugPrint('Failed to load Banner Ad${l.message}');
      _bannerAd = null;
    }, (ad) => _bannerAd = ad);
    notifyListeners();
  }

  void showInterstitialAd() async =>
      await createInterstitialAdUseCase(NoParams());

  void loadCustomAds() async {
    final result = await getCustomAdsUseCase(NoParams());
    result.fold((l) => debugPrint('Failed to get Custom Ads ${l.message}'),
        (ads) {
      debugPrint('here?');
      _customAds = ads;
      notifyListeners();
    });
  }
}
