class FirebaseAnalyticsItemEntity {
  const FirebaseAnalyticsItemEntity({
    this.affiliation,
    this.coupon,
    this.creativeName,
    this.creativeSlot,
    this.discount,
    this.index,
    this.itemBrand,
    this.itemCategory,
    this.itemCategory2,
    this.itemCategory3,
    this.itemCategory4,
    this.itemCategory5,
    this.itemId,
    this.itemListId,
    this.itemListName,
    this.itemName,
    this.itemVariant,
    this.locationId,
    this.price,
    this.promotionId,
    this.promotionName,
    this.quantity,
    this.currency,
    this.parameters,
  });

  /// The store or affiliation from which this transaction
  ///  occurred (e.g. Google Store).
  final String? affiliation;

  /// The coupon name/code associated with the item (e.g. SUMMER_FUN).
  final String? coupon;

  /// The name of a creative used in a promotional spot.
  final String? creativeName;

  /// The name of a creative slot (e.g. featured_app_1).
  final String? creativeSlot;

  /// The monetary discount value associated with the item.
  final num? discount;

  /// The index/position of the item in a list.
  final int? index;

  /// The brand of the item.
  final String? itemBrand;

  /// The category of the item. If used as part of a category
  ///  hierarchy or taxonomy then this will be the first category.
  final String? itemCategory;

  /// The second category hierarchy or additional taxonomy for the item.
  final String? itemCategory2;

  /// The third category hierarchy or additional taxonomy for the item.
  final String? itemCategory3;

  /// The fourth category hierarchy or additional taxonomy for the item.
  final String? itemCategory4;

  /// The fifth category hierarchy or additional taxonomy for the item.
  final String? itemCategory5;

  /// The ID of the item.
  final String? itemId;

  /// The ID of the list in which the item was presented to the user.
  final String? itemListId;

  /// The name of the list in which the item was presented to the user.
  final String? itemListName;

  /// The name of the item.
  final String? itemName;

  /// The item variant or unique code or description for additional item details/options.
  final String? itemVariant;

  /// The physical location associated with the item (e.g. the physical
  ///  store location). It's recommended to use the Google Place
  ///  ID that corresponds to the associated item. A custom location
  ///  ID can also be used.
  final String? locationId;

  /// The monetary price of the item, in units of the specified
  ///  currency parameter.
  final num? price;

  /// The ID of a product promotion.
  final String? promotionId;

  /// The name of a product promotion.
  final String? promotionName;

  /// Item quantity.
  final int? quantity;

  /// The currency of the item price, in 3-letter ISO 4217 format
  ///  (e.g. USD, BRL).
  final String? currency;

  /// Additional parameters for the item.
  final Map<String, Object>? parameters;

  FirebaseAnalyticsItemEntity copyWith({
    String? affiliation,
    String? coupon,
    String? creativeName,
    String? creativeSlot,
    num? discount,
    int? index,
    String? itemBrand,
    String? itemCategory,
    String? itemCategory2,
    String? itemCategory3,
    String? itemCategory4,
    String? itemCategory5,
    String? itemId,
    String? itemListId,
    String? itemListName,
    String? itemName,
    String? itemVariant,
    String? locationId,
    num? price,
    String? promotionId,
    String? promotionName,
    int? quantity,
    String? currency,
    Map<String, Object>? parameters,
  }) {
    return FirebaseAnalyticsItemEntity(
      affiliation: affiliation ?? this.affiliation,
      coupon: coupon ?? this.coupon,
      creativeName: creativeName ?? this.creativeName,
      creativeSlot: creativeSlot ?? this.creativeSlot,
      discount: discount ?? this.discount,
      index: index ?? this.index,
      itemBrand: itemBrand ?? this.itemBrand,
      itemCategory: itemCategory ?? this.itemCategory,
      itemCategory2: itemCategory2 ?? this.itemCategory2,
      itemCategory3: itemCategory3 ?? this.itemCategory3,
      itemCategory4: itemCategory4 ?? this.itemCategory4,
      itemCategory5: itemCategory5 ?? this.itemCategory5,
      itemId: itemId ?? this.itemId,
      itemListId: itemListId ?? this.itemListId,
      itemListName: itemListName ?? this.itemListName,
      itemName: itemName ?? this.itemName,
      itemVariant: itemVariant ?? this.itemVariant,
      locationId: locationId ?? this.locationId,
      price: price ?? this.price,
      promotionId: promotionId ?? this.promotionId,
      promotionName: promotionName ?? this.promotionName,
      quantity: quantity ?? this.quantity,
      currency: currency ?? this.currency,
      parameters: parameters ?? this.parameters,
    );
  }
}
