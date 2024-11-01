import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_remote_config_driver.dart';

class FirebaseRemoteConfigDriver extends IFirebaseRemoteConfigDriver {
  FirebaseRemoteConfigDriver({required this.instance, required this.crashLog});

  final FirebaseRemoteConfig instance;
  final CrashLog crashLog;

  @override
  Future<Either<Exception, Unit>> init() async {
    try {
      await instance.setConfigSettings(
        RemoteConfigSettings(
          minimumFetchInterval:  Duration.zero,
          fetchTimeout: const Duration(seconds: 60),
        ),
      );
      await instance.ensureInitialized();
      await instance.activate();
      await instance.fetchAndActivate();
      return Right(unit);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

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
  Future<Either<Exception, double>> getDouble({required String key}) async {
    try {
      return Right(instance.getDouble(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, int>> getInt({required String key}) async {
    try {
      return Right(instance.getInt(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, String>> getString({required String key}) async {
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

  @override
  Future<Either<Exception, bool>> getBool({required String key}) async {
    try {
      return Right(instance.getBool(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }
}
