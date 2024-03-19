import '../domain/use_cases/admob/create_banner_ad_use_case.dart';
import '../domain/use_cases/admob/create_interstitial_ad_use_case.dart';
import '../domain/use_cases/admob/get_custom_ads_use_case.dart';
import '../domain/use_cases/advertise/send_email_use_case.dart';
import '../domain/use_cases/auth/authenticate_user_use_case.dart';
import '../domain/use_cases/auth/login_apple_use_case.dart';
import '../domain/use_cases/auth/login_facebook_use_case.dart';
import '../domain/use_cases/auth/login_google_use_case.dart';
import '../domain/use_cases/auth/logout_use_case.dart';
import '../domain/use_cases/blog/get_check_ins_use_case.dart';
import '../domain/use_cases/cache/delete_all_cache_use_case.dart';
import '../domain/use_cases/cache/delete_from_cache_use_case.dart';
import '../domain/use_cases/cache/read_cache_use_case.dart';
import '../domain/use_cases/cache/write_cache_use_case.dart';
import '../domain/use_cases/check_in/create_check_in_use_case.dart';
import '../domain/use_cases/check_in/notify_admin_by_email_use_case.dart';
import '../domain/use_cases/file_system/download_file_use_case.dart';
import '../domain/use_cases/file_system/pick_image_use_case.dart';
import '../domain/use_cases/file_system/pick_images_use_case.dart';
import '../domain/use_cases/file_system/pick_video_use_case.dart';
import '../domain/use_cases/file_system/upload_check_in_photo_use_case.dart';
import '../domain/use_cases/maps/get_beaches_use_case.dart';
import '../domain/use_cases/maps/get_cities_in_region_use_case.dart';
import '../domain/use_cases/maps/get_regions_use_case.dart';
import '../domain/use_cases/package_info/get_app_info_use_case.dart';
import '../domain/use_cases/profile/create_delete_account_use_case.dart';
import '../domain/use_cases/profile/remove_delete_request_use_case.dart';
import '../domain/use_cases/remote_config/get_remote_config_use_case.dart';
import '../domain/use_cases/url_launcher/launch_url_use_case.dart';
import '../domain/use_cases/url_launcher/send_email_use_case.dart';
import 'di.dart';

void initUseCases() {
  // Maps UseCases
  di.registerLazySingleton(() => GetBeachesUseCase(di()));
  di.registerLazySingleton(() => GetRegionsUseCase(di()));
  di.registerLazySingleton(() => GetCitiesInRegionUseCase(di()));
  // Cache UseCases
  di.registerLazySingleton(() => ReadCacheUseCase(di()));
  di.registerLazySingleton(() => WriteCacheUseCase(di()));
  di.registerLazySingleton(() => DeleteFromCacheUseCase(di()));
  di.registerLazySingleton(() => DeleteAllCacheUseCase(di()));
  // Advertise UseCases
  di.registerLazySingleton(() => SendEmailUseCase(di()));
  // Auth UseCases
  di.registerLazySingleton(() => AuthenticateUserUseCase(di()));
  di.registerLazySingleton(() => LoginAppleUseCase(di()));
  di.registerLazySingleton(() => LoginFacebookUseCase(di()));
  di.registerLazySingleton(() => LoginGoogleUseCase(di()));
  di.registerLazySingleton(() => LogoutUseCase(di()));
  // File System UseCases
  di.registerLazySingleton(() => PickImageUseCase(di()));
  di.registerLazySingleton(() => PickImagesUseCase(di()));
  di.registerLazySingleton(() => PickVideoUseCase(di()));
  di.registerLazySingleton(() => DownloadFileUseCase(di()));
  di.registerLazySingleton(() => UploadCheckInPhotoUseCase(di()));
  // Check-In UseCases
  di.registerLazySingleton(() => CreateCheckInUseCase(di()));
  di.registerLazySingleton(() => NotifyAdminByEmailUseCase(di()));
  // Blog UseCases
  di.registerLazySingleton(() => GetCheckInsUseCase(di()));
  // Google AdMob UseCases
  di.registerLazySingleton(() => CreateInterstitialAdUseCase(di()));
  di.registerLazySingleton(() => CreateBannerAdUseCase(di()));
  di.registerLazySingleton(() => GetCustomAdsUseCase(di()));
  // URL Launcher UseCases
  di.registerLazySingleton(() => LaunchUrlUseCase(di()));
  di.registerLazySingleton(() => OpenEmailUseCase(di()));
  // Remote Config UseCases
  di.registerLazySingleton(() => GetRemoteConfigUseCase(di()));
  // Package Info UseCases
  di.registerLazySingleton(() => GetAppInfoUseCase(di()));
  // Profile UseCases
  di.registerLazySingleton(() => CreateDeleteAccountRequestUseCase(di()));
  di.registerLazySingleton(() => RemoveDeleteAccountRequestUseCase(di()));
}
