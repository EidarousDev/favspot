import 'package:flutter/material.dart';

import '../../core/config/app_colors.dart';

class VerticalSpace extends StatelessWidget {
  final double height;
  const VerticalSpace(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class HorizontalSpace extends StatelessWidget {
  final double width;
  const HorizontalSpace(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class FullWidthDivider extends StatelessWidget {
  final double? thickness;
  const FullWidthDivider({Key? key, this.thickness = 2.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: AppColors.divider,
    );
  }
}
