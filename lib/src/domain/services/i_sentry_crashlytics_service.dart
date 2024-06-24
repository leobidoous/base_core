import '../interfaces/either.dart';
import 'i_crash_log_service.dart';

abstract class ISentryCrashlyticsService extends ICrashLogService {
  Future<Either<Exception, Unit>> identify({
    required Map<String, dynamic> user,
  });
  Future<Either<Exception, Unit>> unidentify();
}
