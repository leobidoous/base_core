class LogEventEntity {
  LogEventEntity({required this.name, this.parameters});

  final String name;
  final Map<String, dynamic>? parameters;

  /// Remove entries com valor null, string vazia, lista vazia ou map vazio.
  Map<String, dynamic> get sanitizedParameters {
    if (parameters == null) return {};
    return Map.fromEntries(
      parameters!.entries.where((e) {
        final v = e.value;
        if (v == null) return false;
        if (v is String && v.isEmpty) return false;
        if (v is List && v.isEmpty) return false;
        if (v is Map && v.isEmpty) return false;
        return true;
      }),
    );
  }

  LogEventEntity get sanitized =>
      LogEventEntity(name: name, parameters: sanitizedParameters);

  LogEventEntity copyWith({String? name, Map<String, dynamic>? parameters}) {
    return LogEventEntity(
      name: name ?? this.name,
      parameters: parameters ?? this.parameters,
    );
  }
}
