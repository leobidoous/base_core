abstract class ICustomFailure implements Exception {
  ICustomFailure({this.message = '', this.detailError = '', this.stackTrace});
  final String message;
  final String detailError;
  final StackTrace? stackTrace;
}
