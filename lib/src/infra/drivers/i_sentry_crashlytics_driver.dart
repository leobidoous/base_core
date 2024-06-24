import '../../domain/interfaces/either.dart';
import 'i_crash_log_driver.dart';

abstract class ISentryCrashlyticsDriver extends ICrashLogDriver {
  Future<Either<Exception, Unit>> identify({
    required Map<String, dynamic> user,
  });
  Future<Either<Exception, Unit>> unidentify();
}
