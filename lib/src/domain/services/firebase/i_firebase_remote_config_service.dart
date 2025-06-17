import '../../../domain/interfaces/either.dart';

abstract class IFirebaseRemoteConfigService {
  Future<Either<Exception, Unit>> init();
  Either<Exception, Object> getAll();
  Either<Exception, double> getDouble({required String key});
  Either<Exception, int> getInt({required String key});
  Either<Exception, String> getString({required String key});
  Either<Exception, bool> getBool({required String key});
  Either<Exception, Object> getValue({required String key});
}
