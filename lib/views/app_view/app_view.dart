import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_colors.dart';
import '../../core/config/app_config.dart';
import '../../core/config/app_routes.dart';
import '../../core/config/themes.dart';
import '../../di/di.dart';
import '../../providers/admob_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cache_provider.dart';
import '../../providers/check_in_provider.dart';
import '../../providers/maps_provider.dart';
import '../../providers/package_info_provider.dart';
import '../../providers/remote_config_provider.dart';
import '../../services/navigation_service.dart';
import 'splash_screen.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    di<MobileAds>().initialize();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PackageInfoProvider>(
            create: (_) => di<PackageInfoProvider>()),
        ChangeNotifierProvider<MapsProvider>(create: (_) => di<MapsProvider>()),
        ChangeNotifierProvider<CheckInProvider>(
            create: (_) => di<CheckInProvider>()),
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => di<AuthProvider>()..checkAuth()),
        ChangeNotifierProvider<CacheProvider>(
            create: (_) => di<CacheProvider>()),
        ChangeNotifierProvider<AdmobProvider>(
            create: (_) => di<AdmobProvider>()),
        ChangeNotifierProvider<RemoteConfigProvider>(
            create: (_) => di<RemoteConfigProvider>()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: AppConfig.appName,
              color: AppColors.primaryColor,
              navigatorKey: di<NavigationService>().navigatorKey,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRoutes.generateRoute,
              theme: Themes.buildLightTheme(context),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: SplashScreen(),
              builder: EasyLoading.init(),
            );
          }),
    );
  }
}
