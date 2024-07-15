import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/entities/log_event_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_analytics_driver.dart';

class FirebaseAnalyticsDriver extends IFirebaseAnalyticsDriver {
  FirebaseAnalyticsDriver({required this.instance, required this.crashLog});

  final FirebaseAnalytics instance;
  final CrashLog crashLog;

  @override
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params}) async {
    try {
      FirebaseAnalyticsObserver(analytics: instance);
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.init: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  Map<String, Object> _convertToMapStringObject(Map params) {
    return params.map((key, value) {
      if (value is String || value is num) {
        return MapEntry(key, value);
      } else {
        return MapEntry(key, value.toString());
      }
    });
  }

  @override
  Future<Either<Exception, Unit>> createEvent({
    required LogEventEntity event,
    Object? params,
  }) async {
    try {
      await instance.logEvent(
        name: event.name,
        callOptions: AnalyticsCallOptions(global: true),
        parameters: _convertToMapStringObject(event.parameters ?? {}),
      );
      debugPrint('>>> Analytics Event: ${event.name} <<<');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.createEvent: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> login({
    String? loginMethod,
    required String name,
    required String value,
    Map<String, Object>? params,
  }) async {
    try {
      await instance.logLogin(loginMethod: loginMethod, parameters: params);
      await instance.setUserProperty(name: name, value: value);
      debugPrint('FirebaseAnalyticsDriver login efetuado com sucesso.');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.login: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }
}
