import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_sentry_crash_log_driver.dart';

class SentryCrashlyticsDriver extends ISentryCrashLogDriver {
  SentryCrashlyticsDriver();

  @override
  Future<Either<Exception, Unit>> setError({
    required exception,
    StackTrace? stackTrace,
    bool fatal = false,
  }) async {
    try {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return Right(unit);
    } catch (exception) {
      debugPrint('Error on captureException SentryCrashlyticsDriver.');
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> identify({
    required Map<String, dynamic> user,
  }) async {
    try {
      await Sentry.configureScope(
        (scope) => scope.setUser(
          SentryUser(
            id: user['customer']?['id'] ?? '',
            email: user['customer']?['email'] ?? '',
            name: user['customer']?['name'] ?? '',
            username: user['customer']?['phone'] ?? '',
          ),
        ),
      );
      debugPrint('SentryCrashlyticsDriver identificado com sucesso.');
      return Right(unit);
    } catch (exception) {
      debugPrint('Error on captureException SentryCrashlyticsDriver.');
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> unidentify() async {
    try {
      await Sentry.configureScope((scope) => scope.setUser(null));
      debugPrint('SentryCrashlyticsDriver resetado com sucesso.');
      return Right(unit);
    } catch (exception) {
      debugPrint('Error on captureException SentryCrashlyticsDriver.');
      return Left(Exception(exception));
    }
  }
}
