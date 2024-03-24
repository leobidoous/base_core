class QuerySnapshotFiltersEntity {
  QuerySnapshotFiltersEntity({
    required this.collection,
    this.orderByField = '',
    this.orderDescending = false,
    this.limit,
    this.whereFieldIn,
    this.whereFieldNotIn,
    this.whereFieldIsEqualTo,
    this.whereFieldIsNotEqualTo,
    this.whereFieldIsLessThan,
    this.whereFieldIsGreaterThan,
    this.whereFieldIsLessThanOrEqualTo,
    this.whereFieldIsGreaterThanOrEqualTo,
  });
  int? limit;
  String collection;
  String orderByField;
  bool orderDescending;
  Map<String, List>? whereFieldIn;
  Map<String, List>? whereFieldNotIn;
  Map<String, dynamic>? whereFieldIsEqualTo;
  Map<String, dynamic>? whereFieldIsNotEqualTo;
  Map<String, dynamic>? whereFieldIsLessThan;
  Map<String, dynamic>? whereFieldIsGreaterThan;
  Map<String, dynamic>? whereFieldIsLessThanOrEqualTo;
  Map<String, dynamic>? whereFieldIsGreaterThanOrEqualTo;

  QuerySnapshotFiltersEntity copyWith({
    int? limit,
    String? collection,
    String? orderByField,
    bool? orderDescending,
    Map<String, List>? whereFieldIn,
    Map<String, List>? whereFieldNotIn,
    Map<String, dynamic>? whereFieldIsEqualTo,
    Map<String, dynamic>? whereFieldIsNotEqualTo,
    Map<String, dynamic>? whereFieldIsLessThan,
    Map<String, dynamic>? whereFieldIsGreaterThan,
    Map<String, dynamic>? whereFieldIsLessThanOrEqualTo,
    Map<String, dynamic>? whereFieldIsGreaterThanOrEqualTo,
  }) {
    return QuerySnapshotFiltersEntity(
      limit: limit ?? this.limit,
      collection: collection ?? this.collection,
      orderByField: orderByField ?? this.orderByField,
      orderDescending: orderDescending ?? this.orderDescending,
      whereFieldIn: whereFieldIn ?? this.whereFieldIn,
      whereFieldNotIn: whereFieldNotIn ?? this.whereFieldNotIn,
      whereFieldIsEqualTo: whereFieldIsEqualTo ?? this.whereFieldIsEqualTo,
      whereFieldIsNotEqualTo:
          whereFieldIsNotEqualTo ?? this.whereFieldIsNotEqualTo,
      whereFieldIsLessThan: whereFieldIsLessThan ?? this.whereFieldIsLessThan,
      whereFieldIsGreaterThan:
          whereFieldIsGreaterThan ?? this.whereFieldIsGreaterThan,
      whereFieldIsLessThanOrEqualTo:
          whereFieldIsLessThanOrEqualTo ?? this.whereFieldIsLessThanOrEqualTo,
      whereFieldIsGreaterThanOrEqualTo: whereFieldIsGreaterThanOrEqualTo ??
          this.whereFieldIsGreaterThanOrEqualTo,
    );
  }
}
