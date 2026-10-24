import '../../entities/received_notifications_entity.dart';
import '../../interfaces/either.dart';

abstract class IFirebaseNotificationsService {
  Future<Either<Exception, Unit>> configure({
    bool setForegroundMessageAlert = true,
    Function(ReceivedNotificationEntity)? onMessage,
    Function(ReceivedNotificationEntity)? onMessageOpenedApp,
  });
  Future<Either<Exception, ReceivedNotificationEntity?>>
  getInitialNotification();
  Future<Either<Exception, Unit>> subscribeToTopic({required String topic});
  Future<Either<Exception, Unit>> unsubscribeFromTopic({required String topic});

  /// Token FCM. Ainda necessário para o backend atual e para SDKs de
  /// terceiros (ex.: Facebook), que não aceitam o FID.
  Future<Either<Exception, String>> getToken();

  /// Firebase Installation ID (FID), alvo do envio direto do FCM que
  /// substitui o token. Fica em cache após o primeiro registro.
  Future<Either<Exception, String>> getInstallationId({
    Duration timeout = const Duration(seconds: 10),
  });
  Future<Either<Exception, Unit>> saveToken({
    required String userId,
    String collection,
  });
}
