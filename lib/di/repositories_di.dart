import '../data/repositories/admob_repo_impl.dart';
import '../data/repositories/advertise_repo_impl.dart';
import '../data/repositories/auth_repo_impl.dart';
import '../data/repositories/blog_repo_impl.dart';
import '../data/repositories/cache_repo_impl.dart';
import '../data/repositories/check_in_repo_impl.dart';
import '../data/repositories/file_system_repo_impl.dart';
import '../data/repositories/maps_repo_impl.dart';
import '../data/repositories/package_info_repo_impl.dart';
import '../data/repositories/profile_repo_impl.dart';
import '../data/repositories/remote_config_repository_impl.dart';
import '../data/repositories/url_launcher_impl.dart';
import '../domain/repositories/admob_repo.dart';
import '../domain/repositories/advertise_repo.dart';
import '../domain/repositories/auth_repo.dart';
import '../domain/repositories/blog_repo.dart';
import '../domain/repositories/cache_repo.dart';
import '../domain/repositories/check_in_repo.dart';
import '../domain/repositories/file_system_repo.dart';
import '../domain/repositories/maps_repo.dart';
import '../domain/repositories/package_info_repo.dart';
import '../domain/repositories/profile_repo.dart';
import '../domain/repositories/remote_config_repository.dart';
import '../domain/repositories/url_launcher_repo.dart';
import 'di.dart';

void initRepositories() {
  di.registerLazySingleton<MapsRepo>(() => MapsRepoImpl(di()));
  di.registerLazySingleton<CacheRepo>(() => CacheRepoImpl(di()));
  di.registerLazySingleton<AdvertiseRepo>(() => AdvertiseRepoImpl(di()));
  di.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(di()));
  di.registerLazySingleton<FileSystemRepo>(() => FileSystemRepoImpl(di()));
  di.registerLazySingleton<CheckInRepo>(() => CheckInRepoImpl(di()));
  di.registerLazySingleton<BlogRepo>(() => BlogRepoImpl(di()));
  di.registerLazySingleton<AdmobRepo>(() => AdmobRepoImpl(di()));
  di.registerLazySingleton<UrlLauncherRepo>(() => UrlLauncherRepoImpl());
  di.registerLazySingleton<RemoteConfigRepository>(
      () => RemoteConfigRepositoryImpl(di()));
  di.registerLazySingleton<PackageInfoRepo>(() => PackageInfoRepoImpl());
  di.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(di()));
}
