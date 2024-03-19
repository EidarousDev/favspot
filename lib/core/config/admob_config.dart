import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobConfig {
  static String get bannerAdUnitId {
    // return 'ca-app-pub-3940256099942544/6300978111';
    // TODO: Comment the previous line and UnComment the following in Production
    if (Platform.isIOS) {
      return 'ca-app-pub-3333333/222222';
    }
    return 'ca-app-pub-3333333/222222';
  }

  static String get interstitialAdUnitId {
    // return 'ca-app-pub-3940256099942544/1033173712';
    // TODO: Comment the previous line and UnComment the following in Production
    if (Platform.isIOS) {
      return 'ca-app-pub-3333333/222222';
    }
    return 'ca-app-pub-3333333/222222';
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
      onAdLoaded: (ad) => debugPrint('Ad Loaded'),
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        debugPrint('Ad Failed to load: $error');
      },
      onAdOpened: (ad) => debugPrint('Ad Opened'),
      onAdClosed: (ad) => debugPrint('Ad Closed'));
}
