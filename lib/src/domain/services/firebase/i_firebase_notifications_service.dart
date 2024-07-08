import '../../entities/received_notifications_entity.dart';
import '../../interfaces/either.dart';

abstract class IFirebaseNotificationsService {
  Future<Either<Exception, Unit>> configure({
    Function(ReceivedNotificationEntity)? onMessage,
    Function(ReceivedNotificationEntity)? onMessageOpenedApp,
  });
  Future<Either<Exception, Unit>> subscribeToTopic({
    required String topic,
  });
  Future<Either<Exception, Unit>> unsubscribeFromTopic({
    required String topic,
  });
  Future<Either<Exception, String>> getToken();
  Future<Either<Exception, Unit>> saveToken({required String userId});
}
