import 'package:equatable/equatable.dart';

abstract class ICrashLogFailure extends Equatable implements Exception {
  const ICrashLogFailure({
    this.path,
    this.params,
    this.exception,
    this.stackTrace,
  });

  final String? path;
  final dynamic exception;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? params;

  @override
  String toString() {
    return '''*PATH: $path\n*PARAMS: $params\n*EXCEPTION: $exception\n*STACKTRACE: $stackTrace''';
  }

  @override
  List<Object?> get props => [path, params, exception, stackTrace];

  @override
  bool? get stringify => true;
}
