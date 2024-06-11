import '../../../domain/interfaces/either.dart';
import '../../../domain/services/firebase/i_firebase_remote_service.dart';
import '../../drivers/firebase/i_firebase_remote_driver.dart';

class FirebaseRemoteService extends IFirebaseRemoteService {
  FirebaseRemoteService({required this.remoteDriver});

  final IFirebaseRemoteDriver remoteDriver;

  @override
  Future<Either<Exception, Object>> getAll() {
    return remoteDriver.getAll();
  }

  @override
  Future<Either<Exception, Object>> getDouble({required String key}) {
    return remoteDriver.getDouble(key: key);
  }

  @override
  Future<Either<Exception, Object>> getInt({required String key}) {
    return remoteDriver.getInt(key: key);
  }

  @override
  Future<Either<Exception, Object>> getString({required String key}) {
    return remoteDriver.getString(key: key);
  }

  @override
  Future<Either<Exception, Object>> getValue({required String key}) {
    return remoteDriver.getValue(key: key);
  }
}
