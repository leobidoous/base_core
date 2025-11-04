import 'package:flutter/foundation.dart';

import '../../domain/services/i_crash_log_service.dart';

class CrashLog {
  CrashLog({this.logs = const []});

  final List<ICrashLogService> logs;

  Future<void> capture({
    required dynamic exception,
    StackTrace? stackTrace,
    bool fatal = false,
  }) async {
    if (kIsWeb) return;

    final error = stackTrace ?? StackTrace.current;
    debugPrint('---------------------------------');
    debugPrint('Exception: $exception');
    debugPrint('---------------------------------');
    await Future.wait(
      logs.map(
        (log) =>
            log.setError(exception: exception, stackTrace: error, fatal: fatal),
      ),
    );
  }
}
