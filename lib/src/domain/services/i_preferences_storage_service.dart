import '../../domain/interfaces/either.dart';

abstract class IPreferencesStorageService {
  Future<Either<Exception, Unit>> setStringByKey({
    required String key,
    required String value,
  });
  Future<Either<Exception, Unit>> setBoolByKey({
    required String key,
    required bool value,
  });
  Future<Either<Exception, Unit>> setStringListByKey({
    required String key,
    required List<String> value,
  });
  Future<Either<Exception, Unit>> removeStringByKey({required String key});
  Future<Either<Exception, String>> getStringByKey({required String key});
  Future<Either<Exception, List<String>>> getStringListByKey({
    required String key,
  });
}
