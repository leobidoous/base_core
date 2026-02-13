import '../../../domain/entities/firebase_add_to_cart_entity.dart';
import '../../../domain/entities/firebase_begin_checkout_entity.dart';
import '../../../domain/entities/firebase_purchase_entity.dart';
import '../../../domain/entities/log_event_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../domain/services/firebase/i_firebase_analytics_service.dart';
import '../../drivers/firebase/i_firebase_analytics_driver.dart';

class FirebaseAnalyticsService extends IFirebaseAnalyticsService {
  FirebaseAnalyticsService({required this.firebaseAnalyticsDriver});

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

  @override
  Future<Either<Exception, Unit>> login({
    String? loginMethod,
    required String name,
    required String value,
    Map<String, Object>? params,
  }) {
    return firebaseAnalyticsDriver.login(
      name: name,
      value: value,
      params: params,
      loginMethod: loginMethod,
    );
  }

  @override
  Future<Either<Exception, Unit>> setUserProperty({
    required String name,
    required String value,
  }) {
    return firebaseAnalyticsDriver.setUserProperty(name: name, value: value);
  }

  @override
  Future<Either<Exception, Unit>> addToCart({
    required FirebaseAddToCartEntity data,
    Map<String, Object>? parameters,
    bool global = false,
  }) {
    return firebaseAnalyticsDriver.addToCart(
      data: data,
      parameters: parameters,
      global: global,
    );
  }

  @override
  Future<Either<Exception, Unit>> beginCheckout({
    required FirebaseBeginCheckoutEntity data,
    Map<String, Object>? parameters,
    bool global = false,
  }) {
    return firebaseAnalyticsDriver.beginCheckout(
      data: data,
      parameters: parameters,
      global: global,
    );
  }

  @override
  Future<Either<Exception, Unit>> purchase({
    required FirebasePurchaseEntity data,
    Map<String, Object>? parameters,
    bool global = false,
  }) {
    return firebaseAnalyticsDriver.purchase(
      data: data,
      parameters: parameters,
      global: global,
    );
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
  }) {
    return firebaseAnalyticsDriver.logAddPaymentInfo(
      items: items,
      coupon: coupon,
      paymentType: paymentType,
      currency: currency,
      value: value,
      parameters: parameters,
      global: global,
    );
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
  }) {
    return firebaseAnalyticsDriver.logAddShippingInfo(
      items: items,
      coupon: coupon,
      shippingTier: shippingTier,
      currency: currency,
      value: value,
      parameters: parameters,
      global: global,
    );
  }

  @override
  Future<Either<Exception, Unit>> logSelectItem({
    required List<Map<String, dynamic>> items,
    String? itemListId,
    String? itemListName,
    Map<String, Object>? parameters,
    bool global = false,
  }) {
    return firebaseAnalyticsDriver.logSelectItem(
      items: items,
      itemListId: itemListId,
      itemListName: itemListName,
      parameters: parameters,
      global: global,
    );
  }

  @override
  Future<Either<Exception, Unit>> logViewItem({
    required List<Map<String, dynamic>> items,
    String? currency,
    double? value,
    Map<String, Object>? parameters,
  }) {
    return firebaseAnalyticsDriver.logViewItem(
      items: items,
      currency: currency,
      value: value,
      parameters: parameters,
    );
  }

  @override
  Future<Either<Exception, Unit>> logout({required String name}) {
    return firebaseAnalyticsDriver.logout(name: name);
  }
}
