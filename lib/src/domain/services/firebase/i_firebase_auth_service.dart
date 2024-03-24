import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/interfaces/either.dart';

abstract class IFirebaseAuthService {
  Future<Either<Exception, Unit>> logout();
  User? get getCurrentUser;
  Future<Either<Exception, ConfirmationResult>> signInWithPhoneNumber({
    required String phoneNumber,
  });
  Future<Either<Exception, UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Exception, Unit>> signInWithCustomToken({
    required String token,
  });
}
