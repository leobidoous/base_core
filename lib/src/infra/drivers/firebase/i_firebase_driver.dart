import '../../../domain/interfaces/either.dart';

abstract class IFirebaseDriver {
  Future<Either<Exception, Unit>> init();
}
