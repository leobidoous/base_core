import '../../domain/interfaces/either.dart';

abstract class ICrashLogDriver {
  Future<Either<Exception, Unit>> setError({
    required dynamic exception,
    StackTrace? stackTrace,
    bool fatal = false,
  });
}
