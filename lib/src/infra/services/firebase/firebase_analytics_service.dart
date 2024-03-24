import 'package:firebase_analytics/firebase_analytics.dart';

import '../../../domain/entities/log_event_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../domain/services/i_app_tracking_service.dart';
import '../../drivers/i_app_tracking_driver.dart';

class FirebaseAnalyticsService extends IAppTrackingService {
  FirebaseAnalyticsService({
    required this.analytics,
    required this.firebaseAnalyticsDriver,
  });

  final FirebaseAnalytics analytics;
  final IAppTrackingDriver firebaseAnalyticsDriver;

  @override
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params}) async {
    try {
      FirebaseAnalyticsObserver(analytics: analytics);
      return Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> createEvent({required LogEventEntity event}) {
    return firebaseAnalyticsDriver.createEvent(event: event);
  }
}
