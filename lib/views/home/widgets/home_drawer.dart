import 'package:easy_localization/easy_localization.dart';
import 'package:favspot/core/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/config/app_assets.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/config/app_config.dart';
import '../../../core/config/app_routes.dart';
import '../../../core/config/text_styles.dart';
import '../../../core/config/translation_keys.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/package_info_provider.dart';
import '../../../services/app_dialog.dart';
import '../../widgets/spaces.dart';
import 'drawer_item.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 8.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                Spacer(),
                Image.asset(
                  AppAssets.logo,
                  height: 30,
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    EasyLoading.show();
                    Share.share('${S.shareHint.tr()}: ${AppConfig.siteUrl}');
                    EasyLoading.dismiss();
                  },
                  child: Icon(
                    Icons.share,
                    color: AppColors.iconsColor,
                  ),
                )
              ],
            ),
            VerticalSpace(24.0),
            Consumer<AuthProvider>(
              builder: (_, auth, __) {
                if (auth.user != null) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () =>
                              context.push(AppRoutes.accountSettingsScreen),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              auth.user?.profileImage ??
                                  AppConfig.defaultAvatar,
                            ),
                            maxRadius: 18,
                          ),
                        ),
                        HorizontalSpace(12.0),
                        Text('${auth.user?.name ?? AppConfig.defaultName}'),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      FullWidthDivider(),
                      DrawerItem(
                        title: S.login.tr(),
                        onTap: () => context.push(AppRoutes.login),
                        icon: Icon(Icons.login),
                      ),
                    ],
                  );
                }
              },
            ),
            FullWidthDivider(),
            DrawerItem(
              title: S.setLocation.tr(),
              onTap: () => AppDialogs.selectRegion(context),
              icon: Icon(Icons.my_location),
            ),
            VerticalSpace(8.0),
            DrawerItem(
              title: S.cities.tr(),
              onTap: () => context.push(AppRoutes.cities),
              icon: Icon(Icons.add_location_alt_sharp),
            ),
            FullWidthDivider(),
            DrawerItem(
              title: S.advertise.tr(),
              onTap: () => context.push(AppRoutes.advertise),
              icon: Icon(Icons.public),
            ),
            VerticalSpace(8.0),
            DrawerItem(
              title: S.contactUs.tr(),
              onTap: () => context.push(AppRoutes.contact),
              icon: Icon(Icons.contact_mail),
            ),
            VerticalSpace(8.0),
            DrawerItem(
              title: S.termsOfService.tr(),
              onTap: () => Helper.openUrl(AppConfig.termsOfServiceUrl),
              icon: Icon(Icons.assessment),
            ),
            VerticalSpace(8.0),
            DrawerItem(
              title: S.changeLanguage.tr(),
              onTap: () {
                final newLanguage =
                    context.locale.toString() == AppConfig.spanishLanguage
                        ? AppConfig.englishLanguage
                        : AppConfig.spanishLanguage;
                AppDialogs.twoButtonsDialog(context,
                    text:
                        'Show application in ${context.locale.toString() == AppConfig.spanishLanguage ? 'English' : 'Español'}?',
                    onSubmit: () => context.setLocale(Locale(newLanguage)));
              },
              icon: Icon(Icons.language),
            ),
            if (context.watch<AuthProvider>().user != null) ...[
              FullWidthDivider(),
              DrawerItem(
                title: S.logout.tr(),
                onTap: () => AppDialogs.twoButtonsDialog(context,
                    text: S.logoutHint.tr(),
                    onSubmit: () => context
                        .read<AuthProvider>()
                        .logout(onSuccess: () => context.safePop())),
                icon: Icon(Icons.logout),
              ),
            ],
            VerticalSpace(8.0),
            Text(
              'v${context.read<PackageInfoProvider>().version}(${context.read<PackageInfoProvider>().buildNumber})',
              style: TextStyles.label,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
