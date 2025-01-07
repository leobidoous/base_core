import '../../../domain/interfaces/either.dart';
import '../i_app_tracking_driver.dart';

abstract class IFirebaseAnalyticsDriver extends IAppTrackingDriver {
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params});
  Future<Either<Exception, Unit>> setUserProperty({
    required String name,
    required String value,
  });
  Future<Either<Exception, Unit>> login({
    String? loginMethod,
    required String name,
    required String value,
    Map<String, Object>? params,
  });
  Future<Either<Exception, Unit>> logout({
    required String name,
  });
  Future<Either<Exception, Unit>> addToCart({
    required Map<String, dynamic> params,
  });
  Future<Either<Exception, Unit>> beginCheckout({
    required Map<String, dynamic> params,
  });
  Future<Either<Exception, Unit>> purchase({
    required Map<String, dynamic> params,
  });
  Future<Either<Exception, Unit>> logSelectItem({
    required Map<String, dynamic> params,
  });
  Future<Either<Exception, Unit>> logViewItem({
    required Map<String, dynamic> params,
  });
  Future<Either<Exception, Unit>> logAddPaymentInfo({
    required Map<String, dynamic> params,
  });
  Future<Either<Exception, Unit>> logAddShippingInfo({
    required Map<String, dynamic> params,
  });
}
