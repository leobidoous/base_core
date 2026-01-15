import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/entities/log_event_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_analytics_driver.dart';

class FirebaseAnalyticsDriver extends IFirebaseAnalyticsDriver {
  FirebaseAnalyticsDriver({required this.crashLog});

  final CrashLog crashLog;

  FirebaseAnalytics get instance {
    try {
      return FirebaseAnalytics.instance;
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return throw (e);
    }
  }

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

  Map<String, Object>? _convertToMapStringObject(Map? params) {
    if (params == null) return null;
    return params.map((key, value) {
      if (value is String || value is num) {
        return MapEntry(key, value);
      } else {
        return MapEntry(
          key,
          value.toString().length > 100
              ? value.toString().substring(0, 100)
              : value.toString(),
        );
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
        parameters: _convertToMapStringObject(event.parameters),
      );
      debugPrint(
        '''>>> FirebaseAnalyticsDriver.createEvent [${event.name}] ${event.parameters} <<<''',
      );
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
        instance.setUserId(id: value),
        setUserProperty(name: name, value: value),
        instance.logLogin(loginMethod: loginMethod, parameters: params),
      ]);
      for (MapEntry<String, Object> item in params?.entries ?? []) {
        setUserProperty(name: item.key, value: item.value.toString());
      }
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
      coupon: i['coupon']?.toString(),
      itemId: i['itemId']?.toString(),
      currency: i['currency']?.toString(),
      itemName: i['itemName']?.toString(),
      itemBrand: i['itemBrand']?.toString(),
      itemListId: i['itemListId']?.toString(),
      locationId: i['locationId']?.toString(),
      affiliation: i['affiliation']?.toString(),
      promotionId: i['promotionId']?.toString(),
      itemVariant: i['itemVariant']?.toString(),
      index: int.tryParse(i['index'].toString()),
      price: num.tryParse(i['price'].toString()),
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
      parameters: _convertToMapStringObject(i['parameters']),
    );
  }

  @override
  Future<Either<Exception, Unit>> addToCart({
    required Map<String, dynamic> params,
  }) async {
    try {
      final items = List<Map<String, dynamic>>.from(
        (params['items'] ?? []),
      ).map(_analyticsEventItem).toList();
      await instance.logAddToCart(
        items: items,
        currency: params['currency']?.toString() ?? 'BRL',
        value: double.tryParse(params['value'].toString()),
        parameters: _convertToMapStringObject(params['parameters']),
        callOptions: AnalyticsCallOptions(
          global: params['callOptions']?['global'] ?? false,
        ),
      );
      debugPrint('FirebaseAnalyticsDriver.addToCart $params');
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
      final items = List<Map<String, dynamic>>.from(
        (params['items'] ?? []),
      ).map(_analyticsEventItem).toList();
      await instance.logBeginCheckout(
        items: items,
        coupon: params['coupon']?.toString(),
        currency: params['currency']?.toString() ?? 'BRL',
        value: double.tryParse(params['value'].toString()),
        parameters: _convertToMapStringObject(params['parameters']),
        callOptions: AnalyticsCallOptions(
          global: params['callOptions']?['global'] ?? false,
        ),
      );
      debugPrint('FirebaseAnalyticsDriver.beginCheckout $params');
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
      final items = List<Map<String, dynamic>>.from(
        (params['items'] ?? []),
      ).map(_analyticsEventItem).toList();
      await instance.logPurchase(
        items: items,
        coupon: params['coupon']?.toString(),
        currency: params['currency'] ?? 'BRL',
        affiliation: params['affiliation']?.toString(),
        tax: double.tryParse(params['tax'].toString()),
        value: double.tryParse(params['value'].toString()),
        transactionId: params['transactionId']?.toString(),
        shipping: double.tryParse(params['shipping'].toString()),
        parameters: _convertToMapStringObject(params['parameters']),
        callOptions: AnalyticsCallOptions(
          global: params['callOptions']?['global'] ?? false,
        ),
      );
      debugPrint('FirebaseAnalyticsDriver.logPurchase $params');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.logPurchase: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> logSelectItem({
    required Map<String, dynamic> params,
  }) async {
    try {
      final items = List<Map<String, dynamic>>.from(
        (params['items'] ?? []),
      ).map(_analyticsEventItem).toList();
      instance.logSelectItem(
        items: items,
        itemListId: params['itemListId']?.toString(),
        itemListName: params['itemListName']?.toString(),
        parameters: _convertToMapStringObject(params['parameters']),
        callOptions: AnalyticsCallOptions(
          global: params['callOptions']?['global'] ?? false,
        ),
      );
      debugPrint('FirebaseAnalyticsDriver.logSelectItem $params');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.logSelectItem: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> logViewItem({
    required Map<String, dynamic> params,
  }) async {
    try {
      final items = List<Map<String, dynamic>>.from(
        (params['items'] ?? []),
      ).map(_analyticsEventItem).toList();
      instance.logViewItem(
        items: items,
        currency: params['currency']?.toString() ?? 'BRL',
        value: double.tryParse(params['value'].toString()),
        parameters: _convertToMapStringObject(params['parameters']),
      );
      debugPrint('FirebaseAnalyticsDriver.logViewItem $params');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.logViewItem: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> logAddPaymentInfo({
    required Map<String, dynamic> params,
  }) async {
    try {
      final items = List<Map<String, dynamic>>.from(
        (params['items'] ?? []),
      ).map(_analyticsEventItem).toList();
      instance.logAddPaymentInfo(
        items: items,
        coupon: params['coupon']?.toString(),
        paymentType: params['paymentType']?.toString(),
        currency: params['currency']?.toString() ?? 'BRL',
        value: double.tryParse(params['value'].toString()),
        parameters: _convertToMapStringObject(params['parameters']),
        callOptions: AnalyticsCallOptions(
          global: params['callOptions']?['global'] ?? false,
        ),
      );
      debugPrint('FirebaseAnalyticsDriver.logAddPaymentInfo $params');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.logAddPaymentInfo: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> logAddShippingInfo({
    required Map<String, dynamic> params,
  }) async {
    try {
      final items = List<Map<String, dynamic>>.from(
        (params['items'] ?? []),
      ).map(_analyticsEventItem).toList();
      instance.logAddShippingInfo(
        items: items,
        coupon: params['coupon']?.toString(),
        shippingTier: params['shippingTier']?.toString(),
        currency: params['currency']?.toString() ?? 'BRL',
        value: double.tryParse(params['value'].toString()),
        parameters: _convertToMapStringObject(params['parameters']),
        callOptions: AnalyticsCallOptions(
          global: params['callOptions']?['global'] ?? false,
        ),
      );
      debugPrint('FirebaseAnalyticsDriver.logAddShippingInfo $params');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.logAddShippingInfo: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> logout({required String name}) async {
    try {
      await Future.wait([
        instance.setUserId(id: null),
        setUserProperty(name: name, value: ''),
      ]);
      debugPrint('FirebaseAnalyticsDriver logout efetuado com sucesso.');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.logout: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }
}
