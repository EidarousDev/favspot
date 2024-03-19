import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_config.dart';
import '../../core/config/app_routes.dart';
import '../../core/config/text_styles.dart';
import '../../core/config/translation_keys.dart';
import '../../providers/contact_provider.dart';
import '../../services/app_dialog.dart';
import '../widgets/buttons.dart';
import '../widgets/spaces.dart';
import '../widgets/text_input_field.dart';

class AdvertiseScreen extends StatelessWidget {
  const AdvertiseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(S.advertise.tr()),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 13),
                    child: Text(
                      S.advertiseHint.tr(),
                      style: TextStyles.h2,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  VerticalSpace(12.0),
                  TextInputField(
                    label: S.name.tr(),
                    hint: AppConfig.defaultName,
                    onTextChanged: (val) {
                      provider.setName(val);
                      debugPrint('$val');
                    },
                  ),
                  VerticalSpace(16.0),
                  TextInputField(
                    label: S.email.tr(),
                    hint: AppConfig.defaultEmail,
                    onTextChanged: (val) {
                      debugPrint('$val');
                      provider.setEmail(val);
                    },
                  ),
                  VerticalSpace(16.0),
                  TextInputField(
                    label: S.message.tr(),
                    multiLine: true,
                    hint: '',
                    onTextChanged: (val) {
                      provider.setMessage(val);
                      debugPrint('$val');
                    },
                  ),
                  VerticalSpace(16.0),
                  SubmitBtn(
                    onTap: () {
                      debugPrint('Submitted!');
                      provider.validateForm(
                          isAdvertise: true,
                          onSuccess: () {
                            debugPrint('Email Sent!');
                            AppDialogs.oneButtonDialog(context,
                                text: S.adEmailSent.tr(), onSubmit: () {
                              context.popAllThenPush(AppRoutes.home);
                            });
                          },
                          onError: () {
                            AppDialogs.oneButtonDialog(context,
                                text: provider.error,
                                onSubmit: () {},
                                error: true);
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
    );
  }
}
