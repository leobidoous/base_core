import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/interfaces/either.dart';
import '../../../domain/services/firebase/i_firebase_auth_service.dart';
import '../../drivers/firebase/i_firebase_auth_driver.dart';

class FirebaseAuthService extends IFirebaseAuthService {
  FirebaseAuthService({required this.firebaseAuthDriver});

  final IFirebaseAuthDriver firebaseAuthDriver;

  @override
  Future<Either<Exception, Unit>> logout() {
    return firebaseAuthDriver.logout();
  }

  @override
  Future<Either<Exception, Unit>> signInWithCustomToken({
    required String token,
  }) {
    return firebaseAuthDriver.signInWithCustomToken(token: token);
  }

  @override
  Future<Either<Exception, UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return firebaseAuthDriver.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<Either<Exception, ConfirmationResult>> signInWithPhoneNumber({
    required String phoneNumber,
  }) {
    return firebaseAuthDriver.signInWithPhoneNumber(phoneNumber: phoneNumber);
  }
  
  @override
  User? get getCurrentUser => firebaseAuthDriver.getCurrentUser;
}
