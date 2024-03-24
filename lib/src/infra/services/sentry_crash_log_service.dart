import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../domain/interfaces/either.dart';
import '../../domain/services/i_sentry_crash_log_service.dart';
import '../drivers/i_sentry_crash_log_driver.dart';

class SentryCrashLogService extends ISentryCrashLogService {
  SentryCrashLogService({
    required this.dnsKey,
    required this.sentryCrashLogDriver,
  });

  final String dnsKey;
  final ISentryCrashLogDriver sentryCrashLogDriver;

  @override
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params}) async {
    try {
      await SentryFlutter.init(
        (options) {
          options.dsn = dnsKey;
          options.appHangTimeoutInterval = const Duration(seconds: 3);
          switch (params?['environment']) {
            case 'dev':
              options.tracesSampleRate = 1;
              options.environment =
                  '${params?['environment']}${kDebugMode ? '_debug' : ''}';
              break;
            case 'prod':
              options.tracesSampleRate = kDebugMode ? 1 : 0.2;
              options.environment =
                  '${params?['environment']}${kDebugMode ? '_debug' : ''}';
              break;
          }
        },
      );
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
  }) {
    return sentryCrashLogDriver.setError(
      exception: exception,
      stackTrace: stackTrace,
      fatal: fatal,
    );
  }

  @override
  Future<Either<Exception, Unit>> identify({
    required Map<String, dynamic> user,
  }) {
    return sentryCrashLogDriver.identify(user: user);
  }

  @override
  Future<Either<Exception, Unit>> unidentify() {
    return sentryCrashLogDriver.unidentify();
  }
}
