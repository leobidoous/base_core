import 'package:equatable/equatable.dart';

import '../../domain/entities/log_event_entity.dart';

class LogEventModel extends LogEventEntity with EquatableMixin {
  LogEventModel({required super.name, super.parameters});

  factory LogEventModel.fromMap(Map<String, dynamic> map) {
    return LogEventModel(
      name: map['name'] ?? {},
      parameters: map['parameters'] ?? {},
    );
  }

  factory LogEventModel.fromEntity(LogEventEntity entity) {
    return LogEventModel(
      name: entity.name,
      parameters: entity.parameters,
    );
  }

  LogEventEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'name': name,
      'customer': parameters,
    };
  }

  @override
  List<Object?> get props => [
        name,
        parameters,
      ];

  @override
  bool? get stringify => true;
}
