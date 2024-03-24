import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/i_crash_log_driver.dart';

class FirebaseCrashlyticsDriver extends ICrashLogDriver {
  FirebaseCrashlyticsDriver({required this.instance});

  final FirebaseCrashlytics instance;

  @override
  Future<Either<Exception, Unit>> setError({
    required exception,
    StackTrace? stackTrace,
    bool fatal = false,
  }) async {
    try {
      await instance.recordError(
        exception,
        stackTrace,
        printDetails: false,
        fatal: fatal,
      );
      return Right(unit);
    } catch (exception) {
      debugPrint('Error in recordError FirebaseCrashlyticsDriver.');
      return Left(Exception(exception));
    }
  }
}
