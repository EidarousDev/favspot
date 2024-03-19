import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_assets.dart';
import '../../core/config/app_colors.dart';
import '../../core/config/app_config.dart';
import '../../core/config/text_styles.dart';
import '../../core/config/translation_keys.dart';
import '../../core/utils/helper_functions.dart';
import '../../providers/auth_provider.dart';
import '../../services/app_dialog.dart';
import '../widgets/buttons.dart';
import '../widgets/spaces.dart';
import 'widgets/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32.0, 64.0, 32.0, 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackBtn(),
              const VerticalSpace(24.0),
              Center(
                child: Image.asset(
                  AppAssets.logo,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
              const VerticalSpace(24.0),
              Text(
                '${S.login.tr()}',
                style: TextStyles.h2,
                textAlign: TextAlign.start,
              ),
              const VerticalSpace(16.0),
              Text(
                S.loginHint.tr(),
                style: TextStyles.label,
              ),
              const VerticalSpace(24.0),
              if (Platform.isIOS) ...[
                AppleSignInBtn(
                    onPressed: () => context
                        .read<AuthProvider>()
                        .signInWithApple(onSuccess: () => context.safePop())),
                const VerticalSpace(16.0)
              ],
              GoogleSignInBtn(
                onPressed: () => context
                    .read<AuthProvider>()
                    .signInWithGoogle(onSuccess: () => context.safePop(), onFailure: (errorMessage) => AppDialogs.oneButtonDialog(context, text: errorMessage, onSubmit: (){}, error: true)),
              ),
              // Platform.isIOS ? const SizedBox() : const VerticalSpace(16.0),
              // Platform.isIOS
              //     ? const SizedBox()
              //     : FacebookSignInBtn(
              //         onPressed: () => context
              //             .read<AuthProvider>()
              //             .signInWithFacebook(
              //                 onSuccess: () => context.safePop())),
              const VerticalSpace(64.0),
              Center(
                child: Text(
                  S.agreementHint.tr(),
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: S.termsOfService.tr(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Helper.openUrl(AppConfig.termsOfServiceUrl);
                          }),
                    TextSpan(
                      text: S.and.tr(),
                      style: TextStyle(color: AppColors.darkText),
                    ),
                    TextSpan(
                        text: S.privacyPolicy.tr(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Helper.openUrl(AppConfig.privacyPolicyUrl);
                          }),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
