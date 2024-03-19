import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

import '../../core/config/app_assets.dart';
import '../../core/config/app_config.dart';
import '../../core/config/text_styles.dart';
import '../../core/config/translation_keys.dart';
import '../../core/utils/helper_functions.dart';
import '../widgets/buttons.dart';
import '../widgets/spaces.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.logo,
              width: context.appWidth * 0.3,
            ),
            VerticalSpace(8.0),
            Image.asset(
              AppAssets.updateVector,
              height: context.appHeight * 0.4,
            ),
            VerticalSpace(32.0),
            Text(
              S.updateText.tr(),
              style: TextStyles.h2,
            ),
            VerticalSpace(16.0),
            Text(
              S.updateHint.tr(),
              style: TextStyles.label,
            ),
            VerticalSpace(24.0),
            SubmitBtn(
              text: S.updateApp.tr(),
              onTap: () {
                // Open App Link on the store
                Helper.openUrl(Platform.isAndroid
                    ? AppConfig.playStoreUrl
                    : AppConfig.appleStoreUrl);
              },
              width: context.appWidth * 0.4,
            ),
          ],
        ),
      )),
    );
  }
}
