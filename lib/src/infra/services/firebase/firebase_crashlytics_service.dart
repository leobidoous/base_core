import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/interfaces/either.dart';
import '../../../domain/services/firebase/i_firebase_crashlytics_service.dart';
import '../../drivers/i_crash_log_driver.dart';

class FirebaseCrashlyticsService extends IFirebaseCrashlyticsService {
  FirebaseCrashlyticsService({
    required this.instance,
    required this.firebaseCrashlyticsDriver,
  });

  final FirebaseCrashlytics instance;
  final ICrashLogDriver firebaseCrashlyticsDriver;

  @override
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params}) async {
    try {
      if (!kIsWeb) await instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = instance.recordFlutterError;
      debugPrint('FirebaseCrashlyticsService iniciado com sucesso.');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseCrashlyticsService.init: $exception');
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
