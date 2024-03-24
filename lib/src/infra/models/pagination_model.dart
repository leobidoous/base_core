import '../../domain/entities/pagination_entity.dart' show PaginationEntity;
import '../../domain/enums/sorting_order_type_enum.dart';

class PaginationModel extends PaginationEntity {
  PaginationModel({
    super.pageNumber,
    super.limit,
    super.offset,
    super.sortingBy,
    super.sortingOrder,
  });

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      pageNumber: map['page']?.toInt() ?? 1,
      offset: map['offset']?.toInt() ?? 10,
      limit: map['limit']?.toInt() ?? 10,
      sortingBy: map['sortingBy'] ?? '',
      sortingOrder: sortingOrderTypeFromJson(map['sortingOrder']),
    );
  }

  factory PaginationModel.fromEntity(PaginationEntity entity) {
    return PaginationModel(
      sortingOrder: entity.sortingOrder,
      sortingBy: entity.sortingBy,
      pageNumber: entity.pageNumber,
      offset: entity.offset,
      limit: entity.limit,
    );
  }

  Map<String, dynamic> get toMap {
    return {
      'page': pageNumber,
      'offset': offset,
      'limit': limit,
      'sortingOrder': sortingOrder.toJson,
      if (sortingBy.isNotEmpty) 'sortingBy': sortingBy,
    };
  }
}
