import '../../domain/entities/log_event_entity.dart';
import '../../domain/services/i_app_tracking_service.dart';

class EventLog {
  EventLog({this.firebaseAnalytics});

  final IAppTrackingService? firebaseAnalytics;

  Future<void> createEvent({required LogEventEntity event}) async {
    await Future.wait([
      if (firebaseAnalytics != null)
        firebaseAnalytics!.createEvent(event: event),
    ]);
  }
}
