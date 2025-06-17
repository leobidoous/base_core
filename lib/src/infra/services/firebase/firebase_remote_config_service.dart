import '../../../domain/interfaces/either.dart';
import '../../../domain/services/firebase/i_firebase_remote_config_service.dart';
import '../../drivers/firebase/i_firebase_remote_config_driver.dart';

class FirebaseRemoteConfigService extends IFirebaseRemoteConfigService {
  FirebaseRemoteConfigService({required this.firebaseRemoteConfigDriver});

  final IFirebaseRemoteConfigDriver firebaseRemoteConfigDriver;

  @override
  Future<Either<Exception, Unit>> init() {
    return firebaseRemoteConfigDriver.init();
  }

  @override
  Either<Exception, Object> getAll() {
    return firebaseRemoteConfigDriver.getAll();
  }

  @override
  Either<Exception, double> getDouble({required String key}) {
    return firebaseRemoteConfigDriver.getDouble(key: key);
  }

  @override
  Either<Exception, int> getInt({required String key}) {
    return firebaseRemoteConfigDriver.getInt(key: key);
  }

  @override
  Either<Exception, String> getString({required String key}) {
    return firebaseRemoteConfigDriver.getString(key: key);
  }

  @override
  Either<Exception, Object> getValue({required String key}) {
    return firebaseRemoteConfigDriver.getValue(key: key);
  }

  @override
  Either<Exception, bool> getBool({required String key}) {
    return firebaseRemoteConfigDriver.getBool(key: key);
  }
}
