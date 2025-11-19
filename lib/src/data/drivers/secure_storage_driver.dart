import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_secure_storage_driver.dart';

class SecureStorageDriver extends ISecureStorageDriver {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  @override
  Future<Either<Exception, Unit>> removeStringByKey({
    required String key,
  }) async {
    try {
      await _storage.delete(key: key);
      return Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> setStringByKey({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(key: key, value: value);
      return Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, String>> getStringByKey({
    required String key,
  }) async {
    try {
      final response = await _storage.read(key: key);
      if (response == null) {
        return Left(Exception('Erro ao obter $key'));
      }
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Map<String, String>>> getAllValues() async {
    try {
      return Right(await _storage.readAll());
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> deleteAll() async {
    try {
      await _storage.deleteAll();
      return Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
