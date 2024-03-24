import '../../domain/entities/received_notifications_entity.dart'
    show ReceivedNotificationEntity;
import '../../domain/interfaces/either.dart';
import '../../domain/services/i_local_notifications_service.dart'
    show ILocalNotificationsService;
import '../drivers/i_local_notifications_driver.dart'
    show ILocalNotificationsDriver;

class LocalNotificationsService extends ILocalNotificationsService {
  LocalNotificationsService({required this.localNotificationsDriver});
  final ILocalNotificationsDriver localNotificationsDriver;

  @override
  Future<Either<Exception, Unit>> init() {
    return localNotificationsDriver.init();
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
