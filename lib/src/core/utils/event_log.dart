import '../../domain/entities/log_event_entity.dart';
import '../../domain/services/i_app_tracking_service.dart';

class EventLog {
  EventLog({required this.analytics});

  final IAppTrackingService analytics;

  Future<void> createEvent({required LogEventEntity event}) async {
    await Future.wait([
      analytics.createEvent(event: event),
    ]);
  }
}
