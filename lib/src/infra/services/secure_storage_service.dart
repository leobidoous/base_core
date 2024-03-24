import '../../domain/interfaces/either.dart';
import '../../domain/services/i_secure_storage_service.dart';
import '../drivers/i_secure_storage_driver.dart';

class SecureStorageService extends ISecureStorageService {
  SecureStorageService({required this.storageDriver});

  final ISecureStorageDriver storageDriver;

  @override
  Future<Either<Exception, String>> getStringByKey({required String key}) {
    return storageDriver.getStringByKey(key: key);
  }

  @override
  Future<Either<Exception, Unit>> removeStringByKey({required String key}) {
    return storageDriver.removeStringByKey(key: key);
  }

  @override
  Future<Either<Exception, Unit>> setStringByKey({
    required String key,
    required String value,
  }) {
    return storageDriver.setStringByKey(key: key, value: value);
  }

  @override
  Future<Either<Exception, Unit>> deleteAll() {
    return storageDriver.deleteAll();
  }

  @override
  Future<Either<Exception, Map<String, String>>> getAllValues() {
    return storageDriver.getAllValues();
  }
}
