import '../../domain/entities/log_event_entity.dart';
import '../../domain/interfaces/either.dart';

abstract class IAppTrackingDriver {
  Future<Either<Exception, Unit>> createEvent({
    required LogEventEntity event,
    Object? params,
  });
}
