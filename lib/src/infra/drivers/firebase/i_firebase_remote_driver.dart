import '../../../../base_core.dart';

abstract class IFirebaseRemoteDriver {
  Future<Either<Exception, Object>> getAll();
Future<Either<Exception, Object>> getDouble({required String key});
Future<Either<Exception, Object>> getInt({required String key});
Future<Either<Exception, Object>> getString({required String key});
Future<Either<Exception, Object>> getValue({required String key});
}