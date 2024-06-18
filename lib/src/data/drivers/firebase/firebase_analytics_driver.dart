import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/entities/log_event_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_analytics_driver.dart';

class FirebaseAnalyticsDriver extends IFirebaseAnalyticsDriver {
  FirebaseAnalyticsDriver({required this.analytics, required this.crashLog});

  final FirebaseAnalytics analytics;
  final CrashLog crashLog;

  @override
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params}) async {
    try {
      FirebaseAnalyticsObserver(analytics: analytics);
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.init: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

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
      debugPrint('FirebaseAnalyticsDriver.createEvent: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }
}
