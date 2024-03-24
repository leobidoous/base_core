import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/interfaces/either.dart';
import '../../../domain/services/i_crash_log_service.dart';
import '../../drivers/i_crash_log_driver.dart';

class FirebaseCrashlyticsService extends ICrashLogService {
  FirebaseCrashlyticsService({
    required this.instance,
    required this.firebaseCrashlyticsDriver,
  });

  final FirebaseCrashlytics instance;
  final ICrashLogDriver firebaseCrashlyticsDriver;

  @override
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params}) async {
    try {
      await instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = instance.recordFlutterError;
      return Right(unit);
    } catch (exception, stackTrace) {
      return setError(exception: exception, stackTrace: stackTrace);
    }
  }

  @override
  Future<Either<Exception, Unit>> setError({
    required exception,
    StackTrace? stackTrace,
    bool fatal = false,
  }) async {
    return firebaseCrashlyticsDriver.setError(
      exception: exception,
      stackTrace: stackTrace,
      fatal: fatal,
    );
  }
}
