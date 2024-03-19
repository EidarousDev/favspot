import 'package:flutter/material.dart';

import '../core/use_case.dart';
import '../domain/use_cases/cache/delete_all_cache_use_case.dart';
import '../domain/use_cases/cache/delete_from_cache_use_case.dart';
import '../domain/use_cases/cache/read_cache_use_case.dart';
import '../domain/use_cases/cache/write_cache_use_case.dart';

class CacheProvider extends ChangeNotifier {
  final ReadCacheUseCase readCacheUseCase;
  final WriteCacheUseCase writeCacheUseCase;
  final DeleteFromCacheUseCase deleteFromCacheUseCase;
  final DeleteAllCacheUseCase deleteAllCacheUseCase;

  CacheProvider(
      {required this.readCacheUseCase,
      required this.writeCacheUseCase,
      required this.deleteFromCacheUseCase,
      required this.deleteAllCacheUseCase});

  Future<String?> readFromCache(String key) async {
    String? value;
    final result = await readCacheUseCase(CacheParams(key: key));
    result.fold((l) => debugPrint('Failed to read from cache'), (val) {
      debugPrint('Cache = $val');
      value = val;
    });
    return value;
  }

  Future<bool> writeToCache(
      {required String key, required String value}) async {
    bool success = false;
    final result = await writeCacheUseCase(CacheParams(key: key, value: value));
    result.fold((l) => debugPrint('Failed to write to cache'), (done) {
      success = true;
    });
    return success;
  }

  Future<bool> deleteFromCache(
      {required String key, required dynamic value}) async {
    bool success = false;
    final result = await deleteFromCacheUseCase(CacheParams(key: key));
    result.fold((l) => debugPrint('Failed to delete from cache'), (done) {
      success = true;
    });
    return success;
  }

  Future<bool> deleteAllCache(
      {required String key, required dynamic value}) async {
    bool success = false;
    final result = await deleteAllCacheUseCase(NoParams());
    result.fold((l) => debugPrint('Failed to flush cache'), (done) {
      success = true;
    });
    return success;
  }
}
