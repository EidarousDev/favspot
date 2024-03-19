import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_config.dart';
import '../../core/config/translation_keys.dart';
import '../../providers/auth_provider.dart';
import '../../providers/check_in_provider.dart';
import '../../services/app_dialog.dart';
import '../widgets/buttons.dart';
import '../widgets/common_text_widgets.dart';
import '../widgets/spaces.dart';
import 'widgets/beach_drop_down.dart';
import 'widgets/check_in_photo.dart';
import 'widgets/city_drop_down.dart';
import 'widgets/region_drop_down.dart';
import 'widgets/status_drop_down.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(S.checkIn.tr()),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Label(text: S.region.tr()),
                    RegionDropdown(),
                    Label(text: S.city.tr()),
                    CityDropdown(),
                    Label(text: S.beach.tr()),
                    BeachDropdown(),
                    Label(text: S.status.tr()),
                    StatusDropdown(),
                    Label(text: S.includePhoto.tr()),
                    CheckInPhoto(),
                    VerticalSpace(16.0),
                    SubmitBtn(
                      onTap: () {
                        context.read<CheckInProvider>().formValidation(
                            userName: context.read<AuthProvider>().user?.name ??
                                AppConfig.defaultName,
                            onSuccess: () {
                              AppDialogs.oneButtonDialog(context,
                                  text: S.checkInSuccess.tr(), onSubmit: () {
                                // Reset CheckInProvider
                                context.read<CheckInProvider>().reset();
                                context.safePop();
                              });
                            },
                            onError: () {
                              AppDialogs.oneButtonDialog(context,
                                  text: context.read<CheckInProvider>().error,
                                  error: true,
                                  onSubmit: () {});
                            });
                      },
                      text: S.send.tr(),
                      icon: Icons.send,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
