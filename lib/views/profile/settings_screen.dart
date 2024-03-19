import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_config.dart';
import '../../core/config/app_routes.dart';
import '../../core/config/translation_keys.dart';
import '../../providers/auth_provider.dart';
import '../../services/app_dialog.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/spaces.dart';
import 'widgets/settings_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();
    return CustomAppBar(
      title: S.profile.tr(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  auth.user?.profileImage ?? AppConfig.defaultAvatar),
              maxRadius: 18,
            ),
            VerticalSpace(2.0),
            Text('${auth.user?.name ?? AppConfig.defaultName}'),
            VerticalSpace(2.0),
            FullWidthDivider(),
            SettingsItem(
              title: S.deleteAccount.tr(),
              onTap: () => context.push(AppRoutes.deleteAccountScreen),
              icon: Icon(Icons.cancel),
            ),
            VerticalSpace(8.0),
            SettingsItem(
              title: S.logout.tr(),
              onTap: () => AppDialogs.twoButtonsDialog(context,
                  text: S.logoutHint.tr(),
                  onSubmit: () => context
                      .read<AuthProvider>()
                      .logout(onSuccess: () => context.safePop())),
              icon: Icon(Icons.login),
            ),
          ],
        ),
      ),
    );
  }
}
