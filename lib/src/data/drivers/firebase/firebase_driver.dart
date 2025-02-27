import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseOptions;
import 'package:flutter/foundation.dart';

import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_driver.dart'
    show IFirebaseDriver;

class FirebaseDriver extends IFirebaseDriver {
  @override
  Future<Either<Exception, Unit>> init({
    Map<String, String?> config = const {},
  }) async {
    try {
      FirebaseOptions? options;

      final appId = config['appId'] ?? '';
      final apiKey = config['apiKey'] ?? '';
      final trackingId = config['trackingId'];
      final authDomain = config['authDomain'];
      final appGroupId = config['appGroupId'];
      final iosBundleId = config['iosBundleId'];
      final iosClientId = config['iosClientId'];
      final databaseURL = config['databaseURL'];
      final projectId = config['projectId'] ?? '';
      final storageBucket = config['storageBucket'];
      final measurementId = config['measurementId'];
      final androidClientId = config['androidClientId'];
      final deepLinkURLScheme = config['deepLinkURLScheme'];
      final messagingSenderId = config['messagingSenderId'] ?? '';

      if (apiKey.isNotEmpty &&
          appId.isNotEmpty &&
          messagingSenderId.isNotEmpty &&
          projectId.isNotEmpty) {
        options = FirebaseOptions(
          appId: appId,
          apiKey: apiKey,
          projectId: projectId,
          authDomain: authDomain,
          trackingId: trackingId,
          appGroupId: appGroupId,
          iosBundleId: iosBundleId,
          iosClientId: iosClientId,
          databaseURL: databaseURL,
          storageBucket: storageBucket,
          measurementId: measurementId,
          androidClientId: androidClientId,
          deepLinkURLScheme: deepLinkURLScheme,
          messagingSenderId: messagingSenderId,
        );
      }
      await Firebase.initializeApp(
        name: config['name'],
        options: options,
        demoProjectId: config['demoProjectId'],
      );
      debugPrint('FirebaseDriver iniciado com sucesso.');
      return Right(unit);
    } catch (e) {
      debugPrint('Erro ao iniciar FirebaseDriver.');
      return Left(Exception(e));
    }
  }
}
