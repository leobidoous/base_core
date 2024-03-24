class LogEventEntity {
  LogEventEntity({required this.name, this.parameters});

  String name;
  Map<String, dynamic>? parameters;

  LogEventEntity copyWith({String? name, Map<String, dynamic>? parameters}) {
    return LogEventEntity(
      name: name ?? this.name,
      parameters: parameters ?? this.parameters,
    );
  }
}
