import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart' hide BiometricType;
import 'package:local_auth_android/local_auth_android.dart' hide BiometricType;
import 'package:local_auth_darwin/local_auth_darwin.dart' hide BiometricType;

import '../../domain/enums/biometric_type.dart';
import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_local_auth_driver.dart';

class LocalAuthDriver extends ILocalAuthDriver {
  LocalAuthDriver();

  final _auth = LocalAuthentication();

  @override
  Future<Either<Exception, bool>> authenticate({
    String localizedReason = '',
    bool useErrorDialogs = true,
    bool stickyAuth = false,
    bool sensitiveTransaction = true,
    bool biometricOnly = false,
  }) async {
    try {
      final response = await _auth.authenticate(
        options: AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
          sensitiveTransaction: sensitiveTransaction,
          biometricOnly: biometricOnly,
        ),
        localizedReason: localizedReason,
        authMessages: [
          const AndroidAuthMessages(),
          const IOSAuthMessages(),
        ],
      );
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<List<BiometricType>> availableBiometrics() async {
    try {
      final response = await _auth.getAvailableBiometrics();
      return response.map((e) => biometricTypeFromTyoe(e.name)).toList();
    } catch (e) {
      debugPrint('$e');
      return [];
    }
  }

  @override
  Future<Either<Exception, bool>> canCheckBiometrics() async {
    try {
      return Right(await _auth.canCheckBiometrics);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, bool>> isDeviceSupported() async {
    try {
      return Right(await _auth.isDeviceSupported());
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> stopAuthentication() async {
    try {
      await _auth.stopAuthentication();
      return Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
