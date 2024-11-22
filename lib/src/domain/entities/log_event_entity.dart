class LogEventEntity {
  LogEventEntity({required this.name, this.parameters});

  final String name;
  final Map<String, dynamic>? parameters;

  LogEventEntity copyWith({String? name, Map<String, dynamic>? parameters}) {
    return LogEventEntity(
      name: name ?? this.name,
      parameters: parameters ?? this.parameters,
    );
  }
}
