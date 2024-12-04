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
      debugPrint('>>> FirebaseAnalyticsDriver.createEvent: ${event.name} <<<');
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
      await Future.wait([
        instance.logLogin(loginMethod: loginMethod, parameters: params),
        instance.setUserId(id: value),
        setUserProperty(name: name, value: value),
      ]);
      debugPrint('FirebaseAnalyticsDriver login efetuado com sucesso.');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.login: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      await instance.setUserProperty(name: name, value: value);
      debugPrint('FirebaseAnalyticsDriver setUserProperty.');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.setUserProperty: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  AnalyticsEventItem _analyticsEventItem(Map<String, dynamic> i) {
    return AnalyticsEventItem(
      parameters: i['parameters'],
      coupon: i['coupon']?.toString(),
      itemId: i['itemId']?.toString(),
      currency: i['currency']?.toString(),
      itemName: i['itemName']?.toString(),
      itemBrand: i['itemBrand']?.toString(),
      itemListId: i['itemListId']?.toString(),
      locationId: i['locationId']?.toString(),
      affiliation: i['affiliation']?.toString(),
      index: int.tryParse(i['index'].toString()),
      price: num.tryParse(i['price'].toString()),
      promotionId: i['promotionId']?.toString(),
      itemVariant: i['itemVariant']?.toString(),
      creativeName: i['creativeName']?.toString(),
      creativeSlot: i['creativeSlot']?.toString(),
      itemCategory: i['itemCategory']?.toString(),
      itemListName: i['itemListName']?.toString(),
      itemCategory2: i['itemCategory2']?.toString(),
      itemCategory3: i['itemCategory3']?.toString(),
      itemCategory4: i['itemCategory4']?.toString(),
      itemCategory5: i['itemCategory5']?.toString(),
      promotionName: i['promotionName']?.toString(),
      discount: num.tryParse(i['discount'].toString()),
      quantity: int.tryParse(i['quantity'].toString()),
    );
  }

  @override
  Future<Either<Exception, Unit>> addToCart({
    required Map<String, dynamic> params,
  }) async {
    try {
      final items = ((params['items'] ?? []) as List<Map<String, dynamic>>)
          .map(_analyticsEventItem)
          .toList();
      await instance.logAddToCart(
        items: items,
        parameters: params['parameters'],
        currency: params['currency']?.toString() ?? 'BRL',
        value: double.tryParse(params['value'].toString()),
        callOptions: AnalyticsCallOptions(
          global: params['callOptions']?['global'] ?? false,
        ),
      );
      debugPrint('FirebaseAnalyticsDriver.addToCart');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.addToCart: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> beginCheckout({
    required Map<String, dynamic> params,
  }) async {
    try {
      final items = ((params['items'] ?? []) as List<Map<String, dynamic>>)
          .map(_analyticsEventItem)
          .toList();
      await instance.logBeginCheckout(
        items: items,
        parameters: params['parameters'],
        coupon: params['coupon']?.toString(),
        currency: params['currency']?.toString() ?? 'BRL',
        value: double.tryParse(params['value'].toString()),
        callOptions: AnalyticsCallOptions(
          global: params['callOptions']?['global'] ?? false,
        ),
      );
      debugPrint('FirebaseAnalyticsDriver.beginCheckout');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.beginCheckout: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> purchase({
    required Map<String, dynamic> params,
  }) async {
    try {
      final items = ((params['items'] ?? []) as List<Map<String, dynamic>>)
          .map(_analyticsEventItem)
          .toList();
      await instance.logPurchase(
        items: items,
        parameters: params['parameters'],
        coupon: params['coupon']?.toString(),
        currency: params['currency'] ?? 'BRL',
        affiliation: params['affiliation']?.toString(),
        tax: double.tryParse(params['tax'].toString()),
        value: double.tryParse(params['value'].toString()),
        transactionId: params['transactionId']?.toString(),
        shipping: double.tryParse(params['shipping'].toString()),
        callOptions: AnalyticsCallOptions(
          global: params['callOptions']?['global'] ?? false,
        ),
      );
      debugPrint('FirebaseAnalyticsDriver.logPurchase');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.logPurchase: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }
}
