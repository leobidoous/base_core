import '../enums/sorting_order_type_enum.dart';

class PaginationEntity {
  PaginationEntity({
    this.limit,
    this.offset,
    this.pageNumber,
    this.sortingOrder,
    this.sortingBy = '',
  });
  int? limit;
  int? offset;
  int? pageNumber;
  String sortingBy;
  SortingOrderType? sortingOrder;

  PaginationEntity copyWith({
    int? limit,
    int? offset,
    int? pageNumber,
    String? sortingBy,
    SortingOrderType? sortingOrder,
  }) {
    return PaginationEntity(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      sortingBy: sortingBy ?? this.sortingBy,
      pageNumber: pageNumber ?? this.pageNumber,
      sortingOrder: sortingOrder ?? this.sortingOrder,
    );
  }
}
