import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_auth_driver.dart';

class FirebaseAuthDriver extends IFirebaseAuthDriver {
  FirebaseAuthDriver({required this.instance, required this.crashLog});

  final FirebaseAuth instance;
  final CrashLog crashLog;

  @override
  Future<Either<Exception, Unit>> logout() async {
    try {
      await instance.signOut();
      return Right(unit);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, Unit>> signInWithCustomToken({
    required String token,
  }) async {
    try {
      await instance.signInWithCustomToken(token);
      return Right(unit);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(response);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  Future<Either<Exception, ConfirmationResult>> signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    try {
      final response = await instance.signInWithPhoneNumber(
        phoneNumber,
      );
      return Right(response);
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return Left(Exception('$e $s'));
    }
  }

  @override
  User? get getCurrentUser => instance.currentUser;
}
