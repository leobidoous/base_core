import 'package:firebase_analytics/firebase_analytics.dart';

import '../../../domain/entities/log_event_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../domain/services/i_app_tracking_service.dart';
import '../../drivers/firebase/i_firebase_analytics_driver.dart';

class FirebaseAnalyticsService extends IAppTrackingService {
  FirebaseAnalyticsService({
    required this.analytics,
    required this.firebaseAnalyticsDriver,
  });

  final FirebaseAnalytics analytics;
  final IFirebaseAnalyticsDriver firebaseAnalyticsDriver;

  @override
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params}) async {
    return firebaseAnalyticsDriver.init(params: params);
  }

  @override
  Future<Either<Exception, Unit>> createEvent({
    required LogEventEntity event,
    Object? params,
  }) {
    return firebaseAnalyticsDriver.createEvent(event: event, params: params);
  }
}
