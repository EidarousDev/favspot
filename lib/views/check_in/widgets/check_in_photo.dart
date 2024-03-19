import 'dart:io';

import 'package:favspot/core/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/config/app_assets.dart';
import '../../../providers/check_in_provider.dart';

class CheckInPhoto extends StatelessWidget {
  const CheckInPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInProvider>(builder: (context, provider, child) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          width: context.appWidth,
          height: 180.sp,
          child: InkWell(
            onTap: () => provider.selectImage(),
            child: provider.image == null
                ? Image.asset(
                    AppAssets.uploadImage,
                    fit: BoxFit.fill,
                  )
                : Image.file(
                    File(provider.image!.path),
                    fit: BoxFit.fitWidth,
                  ),
          ),
        ),
      );
    });
  }
}
