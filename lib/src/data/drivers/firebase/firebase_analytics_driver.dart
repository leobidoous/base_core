import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/entities/firebase_add_to_cart_entity.dart';
import '../../../domain/entities/firebase_analytics_item_entity.dart';
import '../../../domain/entities/firebase_begin_checkout_entity.dart';
import '../../../domain/entities/firebase_purchase_entity.dart';
import '../../../domain/entities/log_event_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_analytics_driver.dart';
import '../../../infra/models/firebase_add_to_cart_model.dart';
import '../../../infra/models/firebase_begin_checkout_model.dart';
import '../../../infra/models/firebase_purchase_model.dart';

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

  /// Converts FirebaseAnalyticsItemEntity to AnalyticsEventItem
  AnalyticsEventItem _toAnalyticsEventItem(FirebaseAnalyticsItemEntity item) {
    return AnalyticsEventItem(
      affiliation: item.affiliation,
      coupon: item.coupon,
      creativeName: item.creativeName,
      creativeSlot: item.creativeSlot,
      discount: item.discount,
      index: item.index,
      itemBrand: item.itemBrand,
      itemCategory: item.itemCategory,
      itemCategory2: item.itemCategory2,
      itemCategory3: item.itemCategory3,
      itemCategory4: item.itemCategory4,
      itemCategory5: item.itemCategory5,
      itemId: item.itemId,
      itemListId: item.itemListId,
      itemListName: item.itemListName,
      itemName: item.itemName,
      itemVariant: item.itemVariant,
      locationId: item.locationId,
      price: item.price,
      promotionId: item.promotionId,
      promotionName: item.promotionName,
      quantity: item.quantity,
      currency: item.currency,
      parameters: item.parameters,
    );
  }

  @override
  Future<Either<Exception, Unit>> addToCart({
    required FirebaseAddToCartEntity data,
    Map<String, Object>? parameters,
    bool global = false,
  }) async {
    try {
      final items = data.items.map(_toAnalyticsEventItem).toList();
      await instance.logAddToCart(
        items: items,
        currency: data.currency ?? 'BRL',
        value: data.value?.toDouble(),
        parameters: _convertToMapStringObject(parameters),
        callOptions: AnalyticsCallOptions(global: global),
      );
      debugPrint(
        '''FirebaseAnalyticsDriver.addToCart ${FirebaseAddToCartModel.fromEntity(data).toMap}''',
      );
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.addToCart: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> beginCheckout({
    required FirebaseBeginCheckoutEntity data,
    Map<String, Object>? parameters,
    bool global = false,
  }) async {
    try {
      final items = data.items.map(_toAnalyticsEventItem).toList();
      await instance.logBeginCheckout(
        items: items,
        coupon: data.coupon,
        currency: data.currency ?? 'BRL',
        value: data.value?.toDouble(),
        parameters: _convertToMapStringObject(parameters),
        callOptions: AnalyticsCallOptions(global: global),
      );
      debugPrint(
        '''FirebaseAnalyticsDriver.beginCheckout ${FirebaseBeginCheckoutModel.fromEntity(data).toMap}''',
      );
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.beginCheckout: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> purchase({
    required FirebasePurchaseEntity data,
    Map<String, Object>? parameters,
    bool global = false,
  }) async {
    try {
      final items = data.items.map(_toAnalyticsEventItem).toList();
      await instance.logPurchase(
        items: items,
        coupon: data.coupon,
        currency: data.currency ?? 'BRL',
        affiliation: data.affiliation,
        tax: data.tax?.toDouble(),
        value: data.value?.toDouble(),
        transactionId: data.transactionId,
        shipping: data.shipping?.toDouble(),
        parameters: _convertToMapStringObject(parameters),
        callOptions: AnalyticsCallOptions(global: global),
      );
      debugPrint(
        '''FirebaseAnalyticsDriver.logPurchase ${FirebasePurchaseModel.fromEntity(data).toMap}''',
      );
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.logPurchase: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  AnalyticsEventItem _analyticsEventItemFromMap(Map<String, dynamic> i) {
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
  Future<Either<Exception, Unit>> logSelectItem({
    required List<Map<String, dynamic>> items,
    String? itemListId,
    String? itemListName,
    Map<String, Object>? parameters,
    bool global = false,
  }) async {
    try {
      final analyticsItems = items.map(_analyticsEventItemFromMap).toList();
      instance.logSelectItem(
        items: analyticsItems,
        itemListId: itemListId,
        itemListName: itemListName,
        parameters: _convertToMapStringObject(parameters),
        callOptions: AnalyticsCallOptions(global: global),
      );
      debugPrint('FirebaseAnalyticsDriver.logSelectItem $items');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.logSelectItem: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> logViewItem({
    required List<Map<String, dynamic>> items,
    String? currency,
    double? value,
    Map<String, Object>? parameters,
  }) async {
    try {
      final analyticsItems = items.map(_analyticsEventItemFromMap).toList();
      instance.logViewItem(
        items: analyticsItems,
        currency: currency ?? 'BRL',
        value: value,
        parameters: _convertToMapStringObject(parameters),
      );
      debugPrint('FirebaseAnalyticsDriver.logViewItem $items');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.logViewItem: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> logAddPaymentInfo({
    required List<Map<String, dynamic>> items,
    String? coupon,
    String? paymentType,
    String? currency,
    double? value,
    Map<String, Object>? parameters,
    bool global = false,
  }) async {
    try {
      final analyticsItems = items.map(_analyticsEventItemFromMap).toList();
      instance.logAddPaymentInfo(
        items: analyticsItems,
        coupon: coupon,
        paymentType: paymentType,
        currency: currency ?? 'BRL',
        value: value,
        parameters: _convertToMapStringObject(parameters),
        callOptions: AnalyticsCallOptions(global: global),
      );
      debugPrint('FirebaseAnalyticsDriver.logAddPaymentInfo $items');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseAnalyticsDriver.logAddPaymentInfo: $exception');
      crashLog.capture(exception: exception, stackTrace: stackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> logAddShippingInfo({
    required List<Map<String, dynamic>> items,
    String? coupon,
    String? shippingTier,
    String? currency,
    double? value,
    Map<String, Object>? parameters,
    bool global = false,
  }) async {
    try {
      final analyticsItems = items.map(_analyticsEventItemFromMap).toList();
      instance.logAddShippingInfo(
        items: analyticsItems,
        coupon: coupon,
        shippingTier: shippingTier,
        currency: currency ?? 'BRL',
        value: value,
        parameters: _convertToMapStringObject(parameters),
        callOptions: AnalyticsCallOptions(global: global),
      );
      debugPrint('FirebaseAnalyticsDriver.logAddShippingInfo $items');
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
