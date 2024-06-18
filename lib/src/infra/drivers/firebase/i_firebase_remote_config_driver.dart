
import '../../../domain/interfaces/either.dart';

abstract class IFirebaseRemoteConfigDriver {
  Future<Either<Exception, Object>> getAll();
  Future<Either<Exception, double>> getDouble({required String key});
  Future<Either<Exception, int>> getInt({required String key});
  Future<Either<Exception, String>> getString({required String key});
  Future<Either<Exception, bool>> getBool({required String key});
  Future<Either<Exception, Object>> getValue({required String key});
}
