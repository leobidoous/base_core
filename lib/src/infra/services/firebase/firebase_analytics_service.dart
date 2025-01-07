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
    required Map<String, dynamic> params,
  }) {
    return firebaseAnalyticsDriver.addToCart(params: params);
  }

  @override
  Future<Either<Exception, Unit>> beginCheckout({
    required Map<String, dynamic> params,
  }) {
    return firebaseAnalyticsDriver.beginCheckout(params: params);
  }

  @override
  Future<Either<Exception, Unit>> purchase({
    required Map<String, dynamic> params,
  }) {
    return firebaseAnalyticsDriver.purchase(params: params);
  }

  @override
  Future<Either<Exception, Unit>> logAddPaymentInfo({
    required Map<String, dynamic> params,
  }) {
    return firebaseAnalyticsDriver.logAddPaymentInfo(params: params);
  }

  @override
  Future<Either<Exception, Unit>> logAddShippingInfo({
    required Map<String, dynamic> params,
  }) {
    return firebaseAnalyticsDriver.logAddShippingInfo(params: params);
  }

  @override
  Future<Either<Exception, Unit>> logSelectItem({
    required Map<String, dynamic> params,
  }) {
    return firebaseAnalyticsDriver.logSelectItem(params: params);
  }

  @override
  Future<Either<Exception, Unit>> logViewItem({
    required Map<String, dynamic> params,
  }) {
    return firebaseAnalyticsDriver.logViewItem(params: params);
  }

  @override
  Future<Either<Exception, Unit>> logout({required String name}) {
    return firebaseAnalyticsDriver.logout(name: name);
  }
}
