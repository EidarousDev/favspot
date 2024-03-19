import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_colors.dart';
import '../../core/config/app_config.dart';
import '../../core/config/text_styles.dart';
import '../../core/config/translation_keys.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';
import '../../services/app_dialog.dart';
import '../widgets/buttons.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/spaces.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    return CustomAppBar(
      title: S.deleteAccount.tr(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VerticalSpace(12.0),
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  auth.user?.profileImage ?? AppConfig.defaultAvatar),
              maxRadius: 18,
            ),
            VerticalSpace(8.0),
            Text('${auth.user?.name ?? AppConfig.defaultName}'),
            VerticalSpace(12.0),
            Text(S.deleteAccountHint.tr()),
            Spacer(),
            SubmitBtn(
              text: S.delete.tr(),
              buttonColor: AppColors.errorColor,
              onTap: () => AppDialogs.twoButtonsDialog(context,
                  text: S.deleteAccountConfirmation.tr(), onSubmit: () {
                context.read<ProfileProvider>().createDeleteAccountRequest();
                Future.delayed(Duration(milliseconds: 600));
                auth.logout(onSuccess: () {
                  context.safePop();
                  context.safePop();
                });
              }),
            ),
            VerticalSpace(12.0),
            InkWell(
                onTap: () => context.safePop(),
                child: Text(
                  S.cancel.tr(),
                  style: TextStyles.h3,
                )),
          ],
        ),
      ),
    );
  }
}
