class QueryParamsEntity {
  QueryParamsEntity({this.pageNumber = 1, this.pageSize = 10});

  final int pageNumber;
  final int pageSize;

  QueryParamsEntity copyWith({int? pageNumber, int? pageSize}) {
    return QueryParamsEntity(
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
