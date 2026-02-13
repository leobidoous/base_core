import 'firebase_analytics_item_entity.dart';

class FirebaseAddToCartEntity {
  const FirebaseAddToCartEntity({
    required this.items,
    this.currency,
    this.value,
  });

  /// The items added to the cart.
  final List<FirebaseAnalyticsItemEntity> items;

  /// The currency of the items associated with the event,
  ///  in 3-letter ISO 4217 format (e.g. USD, BRL).
  final String? currency;

  /// The monetary value of the event.
  final num? value;

  FirebaseAddToCartEntity copyWith({
    List<FirebaseAnalyticsItemEntity>? items,
    String? currency,
    num? value,
  }) {
    return FirebaseAddToCartEntity(
      items: items ?? this.items,
      currency: currency ?? this.currency,
      value: value ?? this.value,
    );
  }
}
