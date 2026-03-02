import '../../domain/entities/received_notifications_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/services/i_local_notifications_service.dart';
import '../drivers/i_local_notifications_driver.dart';

class LocalNotificationsService extends ILocalNotificationsService {
  LocalNotificationsService({required this.localNotificationsDriver});
  final ILocalNotificationsDriver localNotificationsDriver;

  @override
  Future<Either<Exception, Unit>> init({
    Function(ReceivedNotificationEntity message)? onMessageOpenedApp,
  }) {
    return localNotificationsDriver.init(
      onMessageOpenedApp: onMessageOpenedApp,
    );
  }

  @override
  Future<Either<Exception, Unit>> requestPermissions() {
    return localNotificationsDriver.requestPermissions();
  }

  @override
  Future<Either<Exception, Unit>> scheduleNotification() {
    return localNotificationsDriver.scheduleNotification();
  }

  @override
  Future<Either<Exception, Unit>> showNotification({
    required ReceivedNotificationEntity notification,
  }) {
    return localNotificationsDriver.showNotification(
      notification: notification,
    );
  }
}
