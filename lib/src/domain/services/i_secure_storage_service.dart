import '../../domain/interfaces/either.dart';

abstract class ISecureStorageService {
  Future<Either<Exception, Unit>> setStringByKey({
    required String key,
    required String value,
  });
  Future<Either<Exception, Map<String, String>>> getAllValues();
  Future<Either<Exception, Unit>> removeStringByKey({
    required String key,
  });
  Future<Either<Exception, String>> getStringByKey({
    required String key,
  });
  Future<Either<Exception, Unit>> deleteAll();
}
