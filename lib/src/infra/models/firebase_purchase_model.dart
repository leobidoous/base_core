import '../../domain/entities/firebase_purchase_entity.dart';
import 'firebase_analytics_item_model.dart';

class FirebasePurchaseModel extends FirebasePurchaseEntity {
  const FirebasePurchaseModel({
    required super.items,
    super.currency,
    super.value,
    super.transactionId,
    super.tax,
    super.shipping,
    super.coupon,
    super.affiliation,
  });

  factory FirebasePurchaseModel.fromEntity(FirebasePurchaseEntity entity) {
    return FirebasePurchaseModel(
      items: entity.items,
      currency: entity.currency,
      value: entity.value,
      transactionId: entity.transactionId,
      tax: entity.tax,
      shipping: entity.shipping,
      coupon: entity.coupon,
      affiliation: entity.affiliation,
    );
  }

  Map<String, dynamic> get toMap {
    return {
      'items': items
          .map((item) => FirebaseAnalyticsItemModel.fromEntity(item).toMap)
          .toList(),
      if (currency != null) 'currency': currency,
      if (value != null) 'value': value,
      if (transactionId != null) 'transaction_id': transactionId,
      if (tax != null) 'tax': tax,
      if (shipping != null) 'shipping': shipping,
      if (coupon != null) 'coupon': coupon,
      if (affiliation != null) 'affiliation': affiliation,
    };
  }
}
