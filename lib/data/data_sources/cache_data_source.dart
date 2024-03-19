import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class CacheDataSource {
  Future<String?> read(String key);
  Future<void> write({required String key, required String value});
  Future<void> delete(String key);
  Future<void> deleteAll();
}

class CacheDataSourceImpl implements CacheDataSource {
  CacheDataSourceImpl(this.storage);

  final FlutterSecureStorage storage;
  @override
  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  @override
  Future<String?> read(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }
}
