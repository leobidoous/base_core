
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_remote_driver.dart';

class FirebaseRemoteConfigDriver extends IFirebaseRemoteDriver {
  FirebaseRemoteConfigDriver({required this.instance, required this.crashLog});

  final FirebaseRemoteConfig instance;
  final CrashLog crashLog;

  @override
  Future<Either<Exception, Object>> getAll() async {
    try {
      return Right(instance.getAll());
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Object>> getDouble({required String key}) async {
    try {
      return Right(instance.getDouble(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Object>> getInt({required String key}) async {
    try {
      return Right(instance.getInt(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Object>> getString({required String key}) async {
    try {
      return Right(instance.getString(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Object>> getValue({required String key}) async {
    try {
      return Right(instance.getValue(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }
}
