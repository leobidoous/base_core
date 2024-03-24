import '../../domain/interfaces/either.dart';
import 'i_crash_log_driver.dart';

abstract class ISentryCrashLogDriver extends ICrashLogDriver {
  Future<Either<Exception, Unit>> identify({
    required Map<String, dynamic> user,
  });
  Future<Either<Exception, Unit>> unidentify();
}
