import '../../domain/interfaces/either.dart';

abstract class ICrashLogService {
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params});
  Future<Either<Exception, Unit>> setError({
    required dynamic exception,
    StackTrace? stackTrace,
    bool fatal = false,
  });
}
