import '../../domain/enums/biometric_type.dart';
import '../../domain/interfaces/either.dart';

abstract class ILocalAuthDriver {
  Future<Either<Exception, bool>> authenticate({
    String localizedReason = '',
    bool stickyAuth = false,
    bool sensitiveTransaction = true,
    bool biometricOnly = false,
  });
  Future<Either<Exception, bool>> canCheckBiometrics();
  Future<Either<Exception, bool>> isDeviceSupported();
  Future<Either<Exception, Unit>> stopAuthentication();
  Future<List<BiometricType>> availableBiometrics();
}
