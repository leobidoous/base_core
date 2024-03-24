import '../../../domain/interfaces/either.dart';

abstract class IFirebaseCrashlyticsDriver {
  Future<Either<Exception, Unit>> setError({
    required dynamic exception,
    StackTrace? stackTrace,
  });
}
