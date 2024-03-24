import '../../domain/interfaces/either.dart';
import '../../domain/services/i_preferences_storage_service.dart';
import '../drivers/i_preferences_storage_driver.dart';

class PreferencesStorageService extends IPreferencesStorageService {
  PreferencesStorageService({required this.prefStorageDriver});

  final IPreferencesStorageDriver prefStorageDriver;

  @override
  Future<Either<Exception, String>> getStringByKey({required String key}) {
    return prefStorageDriver.getStringByKey(key: key);
  }

  @override
  Future<Either<Exception, List<String>>> getStringListByKey({
    required String key,
  }) {
    return prefStorageDriver.getStringListByKey(key: key);
  }

  @override
  Future<Either<Exception, Unit>> removeStringByKey({required String key}) {
    return prefStorageDriver.removeStringByKey(key: key);
  }

  @override
  Future<Either<Exception, Unit>> setBoolByKey({
    required String key,
    required bool value,
  }) {
    return prefStorageDriver.setBoolByKey(key: key, value: value);
  }

  @override
  Future<Either<Exception, Unit>> setStringByKey({
    required String key,
    required String value,
  }) {
    return prefStorageDriver.setStringByKey(key: key, value: value);
  }

  @override
  Future<Either<Exception, Unit>> setStringListByKey({
    required String key,
    required List<String> value,
  }) {
    return prefStorageDriver.setStringListByKey(key: key, value: value);
  }
}
