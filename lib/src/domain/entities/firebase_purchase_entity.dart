import 'firebase_analytics_item_entity.dart';

class FirebasePurchaseEntity {
  const FirebasePurchaseEntity({
    required this.items,
    this.currency,
    this.value,
    this.transactionId,
    this.tax,
    this.shipping,
    this.coupon,
    this.affiliation,
  });

  /// The items purchased in the transaction.
  final List<FirebaseAnalyticsItemEntity> items;

  /// The currency of the purchase or items associated with the event,
  ///  in 3-letter ISO 4217 format (e.g. USD, BRL).
  final String? currency;

  /// The monetary value of the event.
  final num? value;

  /// The unique identifier of a transaction.
  final String? transactionId;

  /// Tax amount.
  final num? tax;

  /// Shipping cost.
  final num? shipping;

  /// Coupon code used for a purchase.
  final String? coupon;

  /// A product affiliation to designate a supplying company or
  ///  brick and mortar store location.
  final String? affiliation;

  FirebasePurchaseEntity copyWith({
    List<FirebaseAnalyticsItemEntity>? items,
    String? currency,
    num? value,
    String? transactionId,
    num? tax,
    num? shipping,
    String? coupon,
    String? affiliation,
  }) {
    return FirebasePurchaseEntity(
      items: items ?? this.items,
      currency: currency ?? this.currency,
      value: value ?? this.value,
      transactionId: transactionId ?? this.transactionId,
      tax: tax ?? this.tax,
      shipping: shipping ?? this.shipping,
      coupon: coupon ?? this.coupon,
      affiliation: affiliation ?? this.affiliation,
    );
  }
}
