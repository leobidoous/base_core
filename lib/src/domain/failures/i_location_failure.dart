abstract class ILocationFailure implements Exception {
  ILocationFailure({this.message, this.detailError, this.stackTrace});
  final String? message;
  final String? detailError;
  final StackTrace? stackTrace;
}

class GPSNotActive extends ILocationFailure {
  GPSNotActive(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class CurrentLocationFailure extends ILocationFailure {
  CurrentLocationFailure(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class PermissionRestrictedError extends ILocationFailure {
  PermissionRestrictedError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class PermissionDeniedError extends ILocationFailure {
  PermissionDeniedError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class PermissionPermanentDeniedError extends ILocationFailure {
  PermissionPermanentDeniedError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}

class PermissionLimitedError extends ILocationFailure {
  PermissionLimitedError(this.error, {this.detailsMessage});
  final String error;
  final String? detailsMessage;

  @override
  String? get message => error;
}
