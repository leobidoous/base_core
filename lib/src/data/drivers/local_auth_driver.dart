import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart' hide BiometricType;

import '../../domain/enums/biometric_type.dart';
import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_local_auth_driver.dart';

class LocalAuthDriver extends ILocalAuthDriver {
  LocalAuthDriver();

  final _auth = LocalAuthentication();

  @override
  Future<Either<Exception, bool>> authenticate({
    String localizedReason = '',
  }) async {
    try {
      final response = await _auth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return Right(response);
    } on PlatformException catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<List<BiometricType>> availableBiometrics() async {
    try {
      final response = await _auth.getAvailableBiometrics();
      return response.map((e) => biometricTypeFromTyoe(e.name)).toList();
    } on PlatformException catch (e) {
      debugPrint('$e');
      return [];
    }
  }

  @override
  Future<Either<Exception, bool>> canCheckBiometrics() async {
    try {
      return Right(await _auth.canCheckBiometrics);
    } on PlatformException catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, bool>> isDeviceSupported() async {
    try {
      return Right(await _auth.isDeviceSupported());
    } on PlatformException catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> stopAuthentication() async {
    try {
      await _auth.stopAuthentication();
      return Right(unit);
    } on PlatformException catch (e) {
      return Left(Exception(e));
    }
  }
}
