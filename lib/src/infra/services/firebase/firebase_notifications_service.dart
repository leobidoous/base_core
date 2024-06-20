import '../../../domain/entities/received_notifications_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../domain/services/firebase/i_firebase_notifications_service.dart';
import '../../drivers/firebase/i_firebase_notifications_driver.dart';

class FirebaseNotificationsService extends IFirebaseNotificationsService {
  FirebaseNotificationsService({required this.firebaseNotificationsDriver});

  final IFirebaseNotificationsDriver firebaseNotificationsDriver;

  @override
  Future<Either<Exception, Unit>> configure({
    Function(ReceivedNotificationEntity)? onMessage,
    Function(ReceivedNotificationEntity)? onMessageOpenedApp,
    Function(ReceivedNotificationEntity)? onBackgroundMessage,
  }) {
    return firebaseNotificationsDriver.configure(
      onMessage: onMessage,
      onMessageOpenedApp: onMessageOpenedApp,
      onBackgroundMessage: onBackgroundMessage,
    );
  }

  @override
  Future<Either<Exception, String>> getToken() {
    return firebaseNotificationsDriver.getToken();
  }

  @override
  Future<Either<Exception, Unit>> subscribeToTopic({required String topic}) {
    return firebaseNotificationsDriver.subscribeToTopic(topic: topic);
  }

  @override
  Future<Either<Exception, Unit>> unsubscribeFromTopic({
    required String topic,
  }) {
    return firebaseNotificationsDriver.unsubscribeFromTopic(topic: topic);
  }

  @override
  Future<Either<Exception, Unit>> saveToken({required String userId}) {
    return firebaseNotificationsDriver.saveToken(userId: userId);
  }
}
