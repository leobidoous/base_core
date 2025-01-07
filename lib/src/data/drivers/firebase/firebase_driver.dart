import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseOptions;
import 'package:flutter/foundation.dart';

import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_driver.dart'
    show IFirebaseDriver;

class FirebaseDriver extends IFirebaseDriver {
  @override
  Future<Either<Exception, Unit>> init({
    String apiKey = '',
    String appId = '',
    String messagingSenderId = '',
    String projectId = '',
    String? authDomain,
    String? databaseURL,
    String? storageBucket,
    String? measurementId,
    String? trackingId,
    String? deepLinkURLScheme,
    String? androidClientId,
    String? iosClientId,
    String? iosBundleId,
    String? appGroupId,
  }) async {
    try {
      FirebaseOptions? options;
      if (apiKey.isNotEmpty &&
          appId.isNotEmpty &&
          messagingSenderId.isNotEmpty &&
          projectId.isNotEmpty) {
        options = FirebaseOptions(
          apiKey: apiKey,
          appId: appId,
          messagingSenderId: messagingSenderId,
          projectId: projectId,
          authDomain: authDomain,
          databaseURL: databaseURL,
          storageBucket: storageBucket,
          measurementId: measurementId,
          trackingId: trackingId,
          deepLinkURLScheme: deepLinkURLScheme,
          androidClientId: androidClientId,
          iosClientId: iosClientId,
          iosBundleId: iosBundleId,
          appGroupId: appGroupId,
        );
      }
      await Firebase.initializeApp(options: options);
      debugPrint('FirebaseDriver iniciado com sucesso.');
      return Right(unit);
    } catch (e) {
      debugPrint('Erro ao iniciar FirebaseDriver.');
      return Left(Exception(e));
    }
  }
}
