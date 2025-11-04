import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart' show debugPrint;

import '../../../core/utils/crash_log.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_remote_config_driver.dart';

class FirebaseRemoteConfigDriver extends IFirebaseRemoteConfigDriver {
  FirebaseRemoteConfigDriver({required this.crashLog});

  final CrashLog crashLog;

  FirebaseRemoteConfig get instance {
    try {
      return FirebaseRemoteConfig.instance;
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return throw (e);
    }
  }

  @override
  Future<Either<Exception, Unit>> init() async {
    try {
      await instance.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 60),
          minimumFetchInterval: const Duration(minutes: 1),
        ),
      );
      await instance.fetchAndActivate();
      debugPrint('FirebaseRemoteConfigDriver iniciado com sucesso.');
      return Right(unit);
    } catch (e, s) {
      debugPrint('Erro ao iniciar FirebaseRemoteConfigDriver.');
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Either<Exception, Object> getAll() {
    try {
      return Right(instance.getAll());
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Either<Exception, double> getDouble({required String key}) {
    try {
      return Right(instance.getDouble(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Either<Exception, int> getInt({required String key}) {
    try {
      return Right(instance.getInt(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Either<Exception, String> getString({required String key}) {
    try {
      return Right(instance.getString(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Either<Exception, Object> getValue({required String key}) {
    try {
      return Right(instance.getValue(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Either<Exception, bool> getBool({required String key}) {
    try {
      return Right(instance.getBool(key));
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }
}
