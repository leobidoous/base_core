enum SortingOrderType { asc, desc }

extension SortingOrderTypeExt on SortingOrderType {
  String get toJson {
    switch (this) {
      case SortingOrderType.asc:
        return 'ASC';
      case SortingOrderType.desc:
        return 'DESC';
    }
  }
}

SortingOrderType sortingOrderTypeFromJson(String? type) {
  switch (type) {
    case 'ASC':
      return SortingOrderType.asc;
    case 'DESC':
      return SortingOrderType.desc;
    default:
      return SortingOrderType.asc;
  }
}
