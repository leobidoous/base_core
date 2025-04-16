import '../../domain/failures/i_crash_log_failure.dart';
import '../../domain/interfaces/either.dart';

/// Indicates which transformation should be applied to the response data.
enum ResponseType { json, stream, plain, bytes }

class HttpDriverResponse {
  HttpDriverResponse({
    required this.data,
    this.statusCode,
    this.statusMessage,
  });
  final int? statusCode;
  String? statusMessage;
  final dynamic data;
}

class HttpDriverOptions {
  HttpDriverOptions({
    this.apiKey,
    this.baseUrl,
    this.tenantId,
    this.channelId,
    this.customerId,
    this.contentType,
    this.accessToken,
    this.responseType,
    this.extraHeaders,
    this.apiMapKey = 'apiKey',
    this.accessTokenType = 'Bearer',
  });
  final String? apiKey;
  final String? tenantId;
  final String? apiMapKey;
  final String? channelId;
  final String? contentType;
  final HttpBaseUrl? baseUrl;
  final String accessTokenType;
  final ResponseType? responseType;
  final HttpAccessToken? accessToken;

  final HttpCustomerId? customerId;
  final Map<String, dynamic>? extraHeaders;
}

class HttpFailure extends ICrashLogFailure {
  const HttpFailure({
    super.path,
    super.params,
    super.exception,
    super.stackTrace,
  });
}

typedef HttpDriverProgressCallback = void Function(int count, int total);
typedef HttpAccessToken = String;
typedef HttpCustomerId = String Function();
typedef HttpBaseUrl = String Function();
typedef HttpCallbackType<T> = T Function();

abstract class IHttpDriver {
  Future<Either<HttpDriverResponse, HttpDriverResponse>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<Either<HttpDriverResponse, HttpDriverResponse>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<Either<HttpDriverResponse, HttpDriverResponse>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<Either<HttpDriverResponse, HttpDriverResponse>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<Either<HttpDriverResponse, HttpDriverResponse>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  });

  Future<Either<HttpDriverResponse, HttpDriverResponse>> sendFile<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
    HttpDriverProgressCallback? onSendProgress,
  });

  Future<Either<HttpDriverResponse, HttpDriverResponse>> getFile<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  });

  IHttpDriver copyWith();

  void resetContentType();

  Future<dynamic> interceptRequests(Future request);

  Map<String, String>? get getHeaders;
}
