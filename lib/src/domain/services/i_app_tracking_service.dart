import '../../domain/interfaces/either.dart';
import '../entities/log_event_entity.dart';

abstract class IAppTrackingService {
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params});
  Future<Either<Exception, Unit>> createEvent({
    required LogEventEntity event,
  });
}
