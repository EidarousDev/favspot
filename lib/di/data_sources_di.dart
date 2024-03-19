import '../data/data_sources/admob_data_source.dart';
import '../data/data_sources/advertise_data_source.dart';
import '../data/data_sources/auth_data_source.dart';
import '../data/data_sources/blog_data_source.dart';
import '../data/data_sources/cache_data_source.dart';
import '../data/data_sources/check_in_data_source.dart';
import '../data/data_sources/file_system_data_source.dart';
import '../data/data_sources/maps_data_source.dart';
import '../data/data_sources/profile_data_source.dart';
import '../data/data_sources/remote_config_data_source.dart';
import 'di.dart';

void initDataSources() {
  di.registerLazySingleton<MapsDataSource>(() => MapsDataSourceImpl());
  di.registerLazySingleton<FileSystemDataSource>(
      () => FileSystemDataSourceImpl(di()));
  di.registerLazySingleton<CacheDataSource>(() => CacheDataSourceImpl(di()));
  di.registerLazySingleton<CheckInDataSource>(() => CheckInDataSourceImpl());
  di.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  di.registerLazySingleton<AdvertiseDataSource>(
      () => AdvertiseDataSourceImpl());
  di.registerLazySingleton<BlogDataSource>(() => BlogDataSourceImpl());
  di.registerLazySingleton<AdmobDataSource>(() => AdmobDataSourceImpl());
  di.registerLazySingleton<ProfileDataSource>(() => ProfileDataSourceImpl());
  di.registerLazySingleton<RemoteConfigDataSource>(
      () => RemoteConfigDataSourceImpl(firebaseRemoteConfig: di()));
}
