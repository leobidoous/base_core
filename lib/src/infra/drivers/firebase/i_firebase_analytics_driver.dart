import '../../../domain/entities/firebase_add_to_cart_entity.dart';
import '../../../domain/entities/firebase_begin_checkout_entity.dart';
import '../../../domain/entities/firebase_purchase_entity.dart';
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

  Future<Either<Exception, Unit>> logout({required String name});

  Future<Either<Exception, Unit>> addToCart({
    required FirebaseAddToCartEntity data,
    Map<String, Object>? parameters,
    bool global,
  });

  Future<Either<Exception, Unit>> beginCheckout({
    required FirebaseBeginCheckoutEntity data,
    Map<String, Object>? parameters,
    bool global,
  });

  Future<Either<Exception, Unit>> purchase({
    required FirebasePurchaseEntity data,
    Map<String, Object>? parameters,
    bool global,
  });

  Future<Either<Exception, Unit>> logSelectItem({
    required List<Map<String, dynamic>> items,
    String? itemListId,
    String? itemListName,
    Map<String, Object>? parameters,
    bool global,
  });

  Future<Either<Exception, Unit>> logViewItem({
    required List<Map<String, dynamic>> items,
    String? currency,
    double? value,
    Map<String, Object>? parameters,
  });

  Future<Either<Exception, Unit>> logAddPaymentInfo({
    required List<Map<String, dynamic>> items,
    String? coupon,
    String? paymentType,
    String? currency,
    double? value,
    Map<String, Object>? parameters,
    bool global,
  });

  Future<Either<Exception, Unit>> logAddShippingInfo({
    required List<Map<String, dynamic>> items,
    String? coupon,
    String? shippingTier,
    String? currency,
    double? value,
    Map<String, Object>? parameters,
    bool global,
  });
}
