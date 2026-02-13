import '../../domain/entities/firebase_begin_checkout_entity.dart';
import 'firebase_analytics_item_model.dart';

class FirebaseBeginCheckoutModel extends FirebaseBeginCheckoutEntity {
  const FirebaseBeginCheckoutModel({
    required super.items,
    super.currency,
    super.value,
    super.coupon,
  });

  factory FirebaseBeginCheckoutModel.fromEntity(
    FirebaseBeginCheckoutEntity entity,
  ) {
    return FirebaseBeginCheckoutModel(
      items: entity.items,
      currency: entity.currency,
      value: entity.value,
      coupon: entity.coupon,
    );
  }

  Map<String, dynamic> get toMap {
    return {
      'items': items
          .map((item) => FirebaseAnalyticsItemModel.fromEntity(item).toMap)
          .toList(),
      if (currency != null) 'currency': currency,
      if (value != null) 'value': value,
      if (coupon != null) 'coupon': coupon,
    };
  }
}
