import 'dart:io';

import 'package:favspot/views/contact/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../di/di.dart';
import '../../providers/admob_provider.dart';
import '../../providers/blog_provider.dart';
import '../../providers/cache_provider.dart';
import '../../providers/check_in_provider.dart';
import '../../providers/contact_provider.dart';
import '../../providers/maps_provider.dart';
import '../../providers/profile_provider.dart';
import '../../services/app_dialog.dart';
import '../../views/advertise/advertise_screen.dart';
import '../../views/app_view/splash_screen.dart';
import '../../views/app_view/update_screen.dart';
import '../../views/beaches/beach_details_screen.dart';
import '../../views/beaches/beaches_screen.dart';
import '../../views/blog/blog_screen.dart';
import '../../views/check_in/check_in_screen.dart';
import '../../views/cities/cities_screen.dart';
import '../../views/home/home_screen.dart';
import '../../views/login/login_screen.dart';
import '../../views/profile/delete_account_screen.dart';
import '../../views/profile/settings_screen.dart';
import '../../views/widgets/hero_photo_viewer.dart';
import 'cache_keys.dart';
import 'navigation_keys.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login-screen';
  static const String advertise = '/advertise-screen';
  static const String contact = '/contact-screen';
  static const String checkIn = '/check-in-screen';
  static const String blog = '/blog-screen';
  static const String photoViewer = '/photo-viewer-screen';
  static const String cities = '/cities-screen';
  static const String beaches = '/beaches-screen';
  static const String beachDetails = '/beach-details-screen';
  static const String updateScreen = '/update-screen';
  static const String deleteAccountScreen = '/delete-account-screen';
  static const String accountSettingsScreen =
      '/account-settings-account-screen';

  static String? _currentRoute;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map? args;
    _currentRoute = settings.name;
    if (settings.arguments != null) {
      args = settings.arguments as Map;
    }

    switch (_currentRoute) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.updateScreen:
        return MaterialPageRoute(builder: (_) => const UpdateScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (context) {
          final maps = Provider.of<MapsProvider>(context, listen: false);
          final cache = context.read<CacheProvider>();
          maps.getRegions();
          Future.microtask(() async {
            context.read<AdmobProvider>().loadCustomAds();
            context.read<AdmobProvider>().showBannerAd();
            String? lat = await cache.readFromCache(CacheKeys.latitude);
            String? long = await cache.readFromCache(CacheKeys.longitude);
            String? regionName = await cache.readFromCache(CacheKeys.region);
            Future.delayed(Duration(milliseconds: 1500), () {
              if (lat != null &&
                  lat != 'null' &&
                  long != null &&
                  long != 'null') {
                maps.setLatLng(double.parse(lat), double.parse(long));
                maps.setSelectedRegion(maps.regions
                    .firstWhere((region) => region.region == regionName));
                maps.animateMapsCamera();
                maps.getCitiesInRegion();
              } else {
                AppDialogs.selectRegion(context);
              }
            });
          });
          return HomeScreen();
        });
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.advertise:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => di<ContactProvider>(),
                child: const AdvertiseScreen()));
      case AppRoutes.contact:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => di<ContactProvider>(),
                child: const ContactScreen()));
      case AppRoutes.checkIn:
        return MaterialPageRoute(builder: (context) {
          final maps = context.read<MapsProvider>();
          final checkIn = context.read<CheckInProvider>();
          Future.microtask(() {
            checkIn.setRegions(maps.regions);
            checkIn.setCachedBeaches(maps.cachedBeaches);
          });
          return CheckInScreen();
        });
      case AppRoutes.blog:
        return MaterialPageRoute(builder: (context) {
          if(!Platform.isIOS) {
            Future.microtask(
                    () => context.read<AdmobProvider>().showInterstitialAd());
          }
          return ChangeNotifierProvider(
            create: (_) => di<BlogProvider>()
              ..initScrollController()
              ..getCheckIns(),
            child: const BlogScreen(),
          );
        });
      case AppRoutes.photoViewer:
        if (args == null ||
            args[NavigationKeys.imageProvider] == null ||
            args[NavigationKeys.heroTag] == null) {
          return _errorRoute();
        }
        return MaterialPageRoute(
            builder: (_) => PhotoViewer(
                  imageProvider: args![NavigationKeys.imageProvider],
                  heroTag: args[NavigationKeys.heroTag],
                  url: args[NavigationKeys.url],
                ));
      case AppRoutes.cities:
        return MaterialPageRoute(builder: (context) {
          Future.microtask(() async {
            context.read<MapsProvider>().getCitiesInRegion();
          });
          return const CitiesScreen();
        });
      case AppRoutes.beaches:
        return MaterialPageRoute(
            builder: (_) => BeachesScreen(
                  city: args![NavigationKeys.city],
                ));
      case AppRoutes.beachDetails:
        return MaterialPageRoute(
            builder: (_) => BeachDetailsScreen(
                  beach: args![NavigationKeys.beachEntity],
                ));
      case AppRoutes.accountSettingsScreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case AppRoutes.deleteAccountScreen:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<ProfileProvider>(
                create: (_) => di<ProfileProvider>(),
                child: DeleteAccountScreen()));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

  static bool isCurrent(String newRoute) {
    return newRoute == _currentRoute;
  }

  static void setCurrent(String newRoute) {
    _currentRoute = newRoute;
  }
}
