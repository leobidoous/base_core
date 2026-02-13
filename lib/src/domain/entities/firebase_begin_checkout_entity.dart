import 'firebase_analytics_item_entity.dart';

class FirebaseBeginCheckoutEntity {
  const FirebaseBeginCheckoutEntity({
    required this.items,
    this.currency,
    this.value,
    this.coupon,
  });

  /// The items in the checkout.
  final List<FirebaseAnalyticsItemEntity> items;

  /// The currency of the items associated with the event,
  ///  in 3-letter ISO 4217 format (e.g. USD, BRL).
  final String? currency;

  /// The monetary value of the event.
  final num? value;

  /// Coupon code used for a purchase.
  final String? coupon;

  FirebaseBeginCheckoutEntity copyWith({
    List<FirebaseAnalyticsItemEntity>? items,
    String? currency,
    num? value,
    String? coupon,
  }) {
    return FirebaseBeginCheckoutEntity(
      items: items ?? this.items,
      currency: currency ?? this.currency,
      value: value ?? this.value,
      coupon: coupon ?? this.coupon,
    );
  }
}
