import '../providers/admob_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/blog_provider.dart';
import '../providers/cache_provider.dart';
import '../providers/check_in_provider.dart';
import '../providers/contact_provider.dart';
import '../providers/maps_provider.dart';
import '../providers/package_info_provider.dart';
import '../providers/profile_provider.dart';
import '../providers/remote_config_provider.dart';
import 'di.dart';

void initProviders() {
  di.registerFactory(() => MapsProvider(
      getBeachesUseCase: di(),
      getRegionsUseCase: di(),
      getCitiesInRegionUseCase: di()));
  di.registerFactory(() => CacheProvider(
      readCacheUseCase: di(),
      writeCacheUseCase: di(),
      deleteFromCacheUseCase: di(),
      deleteAllCacheUseCase: di()));
  di.registerFactory(() => ContactProvider(sendEmailUseCase: di()));
  di.registerFactory(() => AuthProvider(
      authenticateUserUseCase: di(),
      loginAppleUseCase: di(),
      loginFacebookUseCase: di(),
      loginGoogleUseCase: di(),
      logoutUseCase: di(), removeDeleteAccountRequestUseCase: di()));
  di.registerFactory(() => CheckInProvider(
      getCitiesInRegionUseCase: di(),
      pickImageUseCase: di(),
      uploadCheckInPhotoUseCase: di(),
      createCheckInUseCase: di(),
      notifyAdminByEmailUseCase: di()));
  di.registerFactory(() => BlogProvider(getCheckInsUseCase: di()));
  di.registerFactory(() => AdmobProvider(
      createBannerAdUseCase: di(),
      createInterstitialAdUseCase: di(),
      getCustomAdsUseCase: di()));
  di.registerFactory(() => RemoteConfigProvider(getRemoteConfigUseCase: di()));
  di.registerFactory(() => PackageInfoProvider(getAppInfoUseCase: di()));
  di.registerFactory(
      () => ProfileProvider(createDeleteAccountRequestUseCase: di()));
}
