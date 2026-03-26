enum SortingOrderType { asc, desc }

extension SortingOrderTypeExt on SortingOrderType {
  String get toJson {
    switch (this) {
      case .asc:
        return 'asc';
      case .desc:
        return 'desc';
    }
  }
}

SortingOrderType? sortingOrderTypeFromJson(String? type) {
  switch (type) {
    case 'asc':
      return .asc;
    case 'desc':
      return .desc;
    default:
      return null;
  }
}
