import '../../domain/entities/firebase_add_to_cart_entity.dart';
import 'firebase_analytics_item_model.dart';

class FirebaseAddToCartModel extends FirebaseAddToCartEntity {
  const FirebaseAddToCartModel({
    required super.items,
    super.currency,
    super.value,
  });

  factory FirebaseAddToCartModel.fromEntity(FirebaseAddToCartEntity entity) {
    return FirebaseAddToCartModel(
      items: entity.items,
      currency: entity.currency,
      value: entity.value,
    );
  }

  Map<String, dynamic> get toMap {
    return {
      'items': items
          .map((item) => FirebaseAnalyticsItemModel.fromEntity(item).toMap)
          .toList(),
      if (currency != null) 'currency': currency,
      if (value != null) 'value': value,
    };
  }
}
