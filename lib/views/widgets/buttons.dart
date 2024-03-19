import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';

import '../../core/config/app_colors.dart';
import '../../core/config/sizes.dart';
import '../../core/config/text_styles.dart';
import 'spaces.dart';

class SubmitBtn extends StatelessWidget {
  const SubmitBtn(
      {Key? key,
      required this.onTap,
      required this.text,
      this.height = 45,
      this.width = double.infinity,
      this.isInActiveButton = false,
      this.buttonColor,
      this.icon})
      : super(key: key);
  final Function onTap;
  final double height;
  final double width;
  final String text;
  final bool isInActiveButton;
  final Color? buttonColor;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (isInActiveButton) {
            return;
          }
          onTap();
        },
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: !isInActiveButton
                ? buttonColor ?? AppColors.primaryColor
                : AppColors.hintColor,
            minimumSize: Size(width, height)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: Colors.white,
                size: Sizes.regularFontSize,
              ),
              const HorizontalSpace(8.0),
            ],
            Text(
              text,
              style: TextStyles.h3.copyWith(color: AppColors.lightText),
            ),
          ],
        ));
  }
}

class BackBtn extends StatelessWidget {
  const BackBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.safePop(),
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.iconsBackground,
              border: Border.all(color: Colors.grey.shade50, width: 0.5),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, //New
                    blurRadius: 80.0,
                    offset: Offset(0, 1))
              ],
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back),
          )),
    );
  }
}
