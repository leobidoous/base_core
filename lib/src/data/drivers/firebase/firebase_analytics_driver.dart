import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/entities/log_event_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/i_app_tracking_driver.dart';

class FirebaseAnalyticsDriver extends IAppTrackingDriver {
  FirebaseAnalyticsDriver({required this.analytics, required this.crashLog});

  final FirebaseAnalytics analytics;
  final CrashLog crashLog;

  @override
  Future<Either<Exception, Unit>> createEvent({
    required LogEventEntity event,
    Object? params,
  }) async {
    try {
      await analytics.logEvent(
        name: event.name,
        callOptions: AnalyticsCallOptions(global: true),
        parameters: {'json': jsonEncode(event.parameters)},
      );
      debugPrint('>>> Analytics Event: ${event.name} <<<');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('Error dispatching event on firebase.');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }
}
