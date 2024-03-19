import 'package:favspot/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/config/app_colors.dart';
import '../../widgets/spaces.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function onTap;
  const SettingsItem(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: context.appWidth * 0.6,
        decoration: BoxDecoration(
          color: AppColors.lightCard,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              icon,
              HorizontalSpace(16.0),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
