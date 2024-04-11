import '../../domain/entities/pagination_entity.dart' show PaginationEntity;
import '../../domain/enums/sorting_order_type_enum.dart';

class PaginationModel extends PaginationEntity {
  PaginationModel({
    super.limit,
    super.offset,
    super.sortingBy,
    super.pageNumber,
    super.sortingOrder,
  });

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      sortingBy: map['sortingBy'] ?? '',
      limit: int.tryParse(map['limit'].toString()),
      offset: int.tryParse(map['offset'].toString()),
      pageNumber: int.tryParse(map['page'].toString()),
      sortingOrder: sortingOrderTypeFromJson(map['sortingOrder']),
    );
  }

  factory PaginationModel.fromEntity(PaginationEntity entity) {
    return PaginationModel(
      sortingOrder: entity.sortingOrder,
      pageNumber: entity.pageNumber,
      sortingBy: entity.sortingBy,
      offset: entity.offset,
      limit: entity.limit,
    );
  }

  Map<String, dynamic> get toMap {
    return {
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (pageNumber != null) 'page': pageNumber,
      if (sortingBy.isNotEmpty) 'sortingBy': sortingBy,
      if (sortingOrder != null) 'sortingOrder': sortingOrder!.toJson,
    };
  }
}
