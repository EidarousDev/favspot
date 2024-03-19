import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/config/app_assets.dart';
import '../../../core/config/text_styles.dart';
import '../../../core/config/translation_keys.dart';

class GoogleSignInBtn extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double height;
  const GoogleSignInBtn(
      {Key? key,
      required this.onPressed,
      this.height = 45,
      this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
          backgroundColor: Colors.white,
          minimumSize: Size(width, height)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppAssets.googleLogo,
            height: height / 2,
          ),
          Expanded(
            child: Text(
              S.signInWithGoogle.tr(),
              style: TextStyles.label,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class AppleSignInBtn extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double height;
  const AppleSignInBtn(
      {Key? key,
      required this.onPressed,
      this.height = 45,
      this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
          backgroundColor: Colors.black,
          minimumSize: Size(width, height)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppAssets.appleLogo,
            height: height / 2,
          ),
          Expanded(
            child: Text(
              S.signInWithApple.tr(),
              style: TextStyles.bold,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class FacebookSignInBtn extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double height;
  const FacebookSignInBtn(
      {Key? key,
      required this.onPressed,
      this.height = 45,
      this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
          backgroundColor: const Color(0xff3a5897),
          minimumSize: Size(width, height)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppAssets.facebookLogo,
            height: height / 2,
          ),
          Expanded(
            child: Text(
              S.continueWithFacebook.tr(),
              style: TextStyles.bold,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
