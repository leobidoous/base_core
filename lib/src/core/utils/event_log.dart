import '../../domain/entities/log_event_entity.dart';
import '../../domain/services/i_app_tracking_service.dart';

class EventLog {
  EventLog({this.logs = const []});

  final List<IAppTrackingService> logs;

  Future<void> createEvent({required LogEventEntity event}) async {
    await Future.wait(logs.map((log) => log.createEvent(event: event)));
  }
}
