import 'package:flutter/foundation.dart';

import '../../domain/services/i_crash_log_service.dart';

class CrashLog {
  CrashLog({required this.firebase, required this.sentry});

  final ICrashLogService firebase;
  final ICrashLogService sentry;

  Future<void> capture({
    required exception,
    StackTrace? stackTrace,
    bool fatal = false,
  }) async {
    final error = stackTrace ?? StackTrace.current;
    debugPrint('---------------------------------');
    debugPrint('Exception: $exception');
    debugPrint('---------------------------------');
    await Future.wait([
      firebase.setError(exception: exception, stackTrace: error, fatal: false),
      sentry.setError(exception: exception, stackTrace: error),
    ]);
  }
}
