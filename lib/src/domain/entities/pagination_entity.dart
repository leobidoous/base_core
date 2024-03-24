import '../enums/sorting_order_type_enum.dart';

class PaginationEntity {
  PaginationEntity({
    this.pageNumber = 1,
    this.limit = 10,
    this.offset = 0,
    this.sortingOrder = SortingOrderType.desc,
    this.sortingBy = '',
  });
  int pageNumber;
  int? limit;
  int? offset;
  SortingOrderType sortingOrder;
  String sortingBy;

  PaginationEntity copyWith({
    int? pageNumber,
    int? limit,
    int? offset,
    SortingOrderType? sortingOrder,
    String? sortingBy,
  }) {
    return PaginationEntity(
      pageNumber: pageNumber ?? this.pageNumber,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      sortingOrder: sortingOrder ?? this.sortingOrder,
      sortingBy: sortingBy ?? this.sortingBy,
    );
  }
}
