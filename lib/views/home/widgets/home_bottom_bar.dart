import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/mediaquery_extension.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/config/app_routes.dart';
import '../../../core/config/translation_keys.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../domain/entities/ad_entity.dart';
import '../../../providers/admob_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/app_dialog.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AdmobProvider>(builder: (context, ads, child) {
      AdEntity? ad;
      if (ads.customAds.isNotEmpty) {
        ad = ads.customAds[Random().nextInt(ads.customAds.length)];
      }
      return Column(
        children: [
          if (ad != null) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              height: 60,
              child: InkWell(
                onTap: () {
                  if (ad!.url != null) {
                    Helper.openUrl(ad.url!);
                  }
                },
                child: CachedNetworkImage(
                  imageUrl: ad.imageUrl,
                  height: 60,
                ),
              ),
            )
          ] else if (ads.bannerAd != null) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              height: 60,
              child: AdWidget(ad: context.read<AdmobProvider>().bannerAd!),
            )
          ] else ...[
            SizedBox()
          ],
          Container(
            width: context.appWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () => AppDialogs.selectCity(context),
                    child: Icon(Icons.location_on)),
                Consumer<AuthProvider>(builder: (context, auth, child) {
                  return InkWell(
                      onTap: () {
                        if (auth.user == null) {
                          AppDialogs.twoButtonsDialog(context,
                              text: S.requestLogIn.tr(),
                              onSubmit: () => context.push(AppRoutes.login));
                        } else {
                          context.push(AppRoutes.checkIn);
                        }
                      },
                      child: Text(S.checkIn.tr()));
                }),
                InkWell(
                    onTap: () => context.push(AppRoutes.blog),
                    child: Icon(Icons.article)),
              ]
                  .map((widget) => Container(
                        decoration: BoxDecoration(
                          color: AppColors.iconsBackground,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey, //New
                                blurRadius: 25.0,
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: widget,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      );
    });
  }
}
