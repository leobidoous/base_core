import '../../../domain/interfaces/either.dart';

abstract class IFirebaseDriver {
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
  });
}
