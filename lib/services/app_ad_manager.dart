import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Widget AppAdManager() {
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-9582319681474991/3031311618',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  myBanner.load();

  final AdWidget adWidget = AdWidget(ad: myBanner);

  return Container(
    alignment: Alignment.bottomCenter,
    child: adWidget,
    width: myBanner.size.width.toDouble(),
    height: myBanner.size.height.toDouble(),
  );
}
