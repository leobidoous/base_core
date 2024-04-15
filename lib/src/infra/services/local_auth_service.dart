import '../../domain/enums/biometric_type.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/services/i_local_auth_service.dart';
import '../drivers/i_local_auth_driver.dart';

class LocalAuthService extends ILocalAuthService {
  LocalAuthService({required this.localAuthDriver});

  final ILocalAuthDriver localAuthDriver;

  @override
  Future<Either<Exception, bool>> authenticate({
    String localizedReason = '',
    bool useErrorDialogs = true,
    bool stickyAuth = false,
    bool sensitiveTransaction = true,
    bool biometricOnly = false,
  }) {
    return localAuthDriver.authenticate(
      localizedReason: localizedReason,
      useErrorDialogs: useErrorDialogs,
      stickyAuth: stickyAuth,
      sensitiveTransaction: sensitiveTransaction,
      biometricOnly: biometricOnly,
    );
  }

  @override
  Future<List<BiometricType>> availableBiometrics() {
    return localAuthDriver.availableBiometrics();
  }

  @override
  Future<Either<Exception, bool>> canCheckBiometrics() {
    return localAuthDriver.canCheckBiometrics();
  }

  @override
  Future<Either<Exception, bool>> isDeviceSupported() {
    return localAuthDriver.isDeviceSupported();
  }

  @override
  Future<Either<Exception, Unit>> stopAuthentication() {
    return localAuthDriver.stopAuthentication();
  }
}
