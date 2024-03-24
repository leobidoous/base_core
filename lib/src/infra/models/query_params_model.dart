import 'dart:convert' show json;

import 'package:equatable/equatable.dart';

import '../../domain/entities/query_params_entity.dart';

class QueryParamsModel extends QueryParamsEntity with EquatableMixin {
  QueryParamsModel({
    super.pageNumber,
    super.pageSize,
  });

  factory QueryParamsModel.fromMap(Map<String, dynamic> map) {
    return QueryParamsModel(
      pageNumber: map['PageNumber']?.toInt() ?? 1,
      pageSize: map['PageSize']?.toInt() ?? 10,
    );
  }

  factory QueryParamsModel.fromEntity(QueryParamsEntity entity) {
    return QueryParamsModel(
      pageNumber: entity.pageNumber,
      pageSize: entity.pageSize,
    );
  }

  factory QueryParamsModel.fromJson(String source) =>
      QueryParamsModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  Map<String, dynamic> get toMap {
    return {
      'PageNumber': pageNumber,
      'PageSize': pageSize,
    };
  }

  QueryParamsEntity get toEntity => this;

  @override
  List<Object?> get props => [
        pageNumber,
        pageSize,
      ];

  @override
  bool? get stringify => true;
}
