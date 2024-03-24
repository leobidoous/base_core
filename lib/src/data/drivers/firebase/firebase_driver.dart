import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/foundation.dart';

import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_driver.dart'
    show IFirebaseDriver;

class FirebaseDriver extends IFirebaseDriver {
  @override
  Future<Either<Exception, Unit>> init() async {
    try {
      await Firebase.initializeApp();
      debugPrint('FirebaseDriver iniciado com sucesso.');
      return Right(unit);
    } catch (e) {
      debugPrint('Erro ao iniciar FirebaseDriver.');
      return Left(Exception(e));
    }
  }
}
