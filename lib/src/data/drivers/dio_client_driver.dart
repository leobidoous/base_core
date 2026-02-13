import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:path_provider/path_provider.dart';

import '../../core/utils/crash_log.dart';
import '../../domain/interfaces/disposable.dart';
import '../../domain/interfaces/either.dart';
import '../../infra/context/request_context.dart';
import '../../infra/drivers/i_http_driver.dart';

class DioClientDriver extends IHttpDriver with Disposable {
  DioClientDriver({required this.client, required this.crashLog});

  final dio.Dio client;
  final CrashLog crashLog;

  dio.Dio _client([HttpDriverOptions? options]) => options == null
      ? client
      : client.clone(
          options: client.options.copyWith(baseUrl: options.baseUrl?.call()),
        );

  HttpDriverResponse _responseError(dio.DioException e, {StackTrace? s}) {
    try {
      late String statusMessage;
      final String data = json.encode(e.response?.data);

      switch (e.response?.statusCode) {
        case 400:
          statusMessage = '${e.message}\n';
          try {
            (e.response?.data as Map?)?.forEach((key, value) {
              statusMessage += '$key: $value';
              if (key != (e.response?.data as Map?)?.keys.last) {
                statusMessage += '\n';
              }
            });
          } catch (err) {
            statusMessage = '${e.message}\n$data\n$err';
          }
          break;
        default:
          statusMessage = '[${e.response?.statusCode}] ${e.message}\n$data';
          break;
      }

      crashLog.capture(
        exception: HttpFailure(
          exception: e,
          stackTrace: StackTrace.current,
          path: e.requestOptions.baseUrl + e.requestOptions.path,
          params: e.requestOptions.data is Map<String, dynamic>
              ? {
                  ...e.requestOptions.data,
                  ...e.requestOptions.queryParameters,
                  if (e.response?.data is Map<String, dynamic>)
                    ...e.response?.data,
                }
              : {
                  ...{'requestBodyData': e.requestOptions.data.toString()},
                  ...{'responseBodyData': e.response?.data.toString()},
                  ...e.requestOptions.queryParameters,
                },
        ),
        stackTrace: s,
      );

      return HttpDriverResponse(
        data: e.response?.data,
        statusMessage: statusMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (exception, stackTrace) {
      crashLog.capture(exception: e, stackTrace: stackTrace);

      return HttpDriverResponse(
        data: exception,
        statusMessage: stackTrace.toString(),
        statusCode: e.response?.statusCode ?? -1,
      );
    }
  }

  dio.Options _options(HttpDriverOptions? options) {
    return dio.Options(
      responseType: switch (options?.responseType) {
        ResponseType.bytes => dio.ResponseType.bytes,
        ResponseType.stream => dio.ResponseType.stream,
        ResponseType.plain => dio.ResponseType.plain,
        ResponseType.json => dio.ResponseType.json,
        null => null,
      },
      contentType: options?.contentType,
      headers: {
        if (options != null && options.accessToken != null)
          'Authorization': '${options.accessTokenType} ${options.accessToken}'
              .trim(),
        if (options != null && options.apiKey != null)
          '${options.apiMapKey}': '${options.apiKey}',
        ...?options?.extraHeaders,
      },
    );
  }

  dio.CancelToken? _cancelToken(HttpDriverOptions? options) {
    // Prioridade: 1) options.cancelToken, 2) RequestContext.current
    final optionToken = options?.cancelToken as dio.CancelToken?;
    if (optionToken != null) return optionToken;

    // Tenta obter do contexto global (definido pelo CustomController)
    return RequestContext.current;
  }

  HttpDriverResponse _responseSuccess<T>(dio.Response<T> response) {
    return HttpDriverResponse(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  }) async {
    try {
      final response = await _client(options).delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(options),
        cancelToken: _cancelToken(options),
      );
      return Right(_responseSuccess(response));
    } on dio.DioException catch (e, s) {
      return Left(_responseError(e, s: s));
    } catch (e) {
      return Left(HttpDriverResponse(data: {'error': e}));
    }
  }

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> get(
    String path, {
    HttpDriverOptions? options,
    Map<String, dynamic>? queryParameters,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _client(options).get(
        path,
        queryParameters: queryParameters,
        options: _options(options),
        cancelToken: _cancelToken(options),
      );
      return Right(_responseSuccess(response));
    } on dio.DioException catch (e, s) {
      return Left(_responseError(e, s: s));
    } catch (e) {
      return Left(HttpDriverResponse(data: {'error': e}));
    }
  }

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> getFile<T>(
    String path, {
    HttpDriverOptions? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      await tempDir.create(recursive: true);
      final filename = options?.extraHeaders?['filename'] ?? '';
      final String tempPath = '${tempDir.path}/$filename';

      final response = await _client(options).download(
        path,
        tempPath,
        options: _options(options),
        queryParameters: queryParameters,
        cancelToken: _cancelToken(options),
      );

      return Right(_responseSuccess(response));
    } on dio.DioException catch (e, s) {
      return Left(_responseError(e, s: s));
    } catch (e) {
      return Left(HttpDriverResponse(data: {'error': e}));
    }
  }

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> patch(
    String path, {
    data,
    HttpDriverOptions? options,
    Map<String, dynamic>? queryParameters,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _client(options).patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(options),
        cancelToken: _cancelToken(options),
      );
      return Right(_responseSuccess(response));
    } on dio.DioException catch (e, s) {
      return Left(_responseError(e, s: s));
    } catch (e) {
      return Left(HttpDriverResponse(data: {'error': e}));
    }
  }

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> post(
    String path, {
    data,
    HttpDriverOptions? options,
    Map<String, dynamic>? queryParameters,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _client(options).post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(options),
        cancelToken: _cancelToken(options),
      );
      return Right(_responseSuccess(response));
    } on dio.DioException catch (e, s) {
      return Left(_responseError(e, s: s));
    } catch (e) {
      return Left(HttpDriverResponse(data: {'error': e}));
    }
  }

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> put(
    String path, {
    data,
    HttpDriverOptions? options,
    Map<String, dynamic>? queryParameters,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _client(options).put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(options),
        cancelToken: _cancelToken(options),
      );
      return Right(_responseSuccess(response));
    } on dio.DioException catch (e, s) {
      return Left(_responseError(e, s: s));
    } catch (e) {
      return Left(HttpDriverResponse(data: {'error': e}));
    }
  }

  @override
  void resetContentType() {}

  @override
  Future<Either<HttpDriverResponse, HttpDriverResponse>> sendFile<T>(
    String path, {
    data,
    HttpDriverOptions? options,
    Map<String, dynamic>? queryParameters,
    HttpDriverProgressCallback? onSendProgress,
    HttpDriverProgressCallback? onReceiveProgress,
  }) {
    throw UnimplementedError();
  }

  @override
  Map<String, String>? get getHeaders => _client().options.headers.map(
    (key, value) => MapEntry(key, value.toString()),
  );

  @override
  Future interceptRequests(Future request) {
    throw UnimplementedError();
  }

  @override
  IHttpDriver copyWith({
    String? method,
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Map<String, Object?>? extra,
    Map<String, Object?>? headers,
    dio.ResponseType? responseType,
    String? contentType,
    dio.ValidateStatus? validateStatus,
    bool? receiveDataWhenStatusError,
    bool? followRedirects,
    int? maxRedirects,
    bool? persistentConnection,
    dio.RequestEncoder? requestEncoder,
    dio.ResponseDecoder? responseDecoder,
    dio.ListFormat? listFormat,
  }) {
    return DioClientDriver(
      client: _client()
        ..options = _client().options.copyWith(
          method: method ?? _client().options.method,
          baseUrl: baseUrl ?? _client().options.baseUrl,
          queryParameters: queryParameters ?? _client().options.queryParameters,
          connectTimeout: connectTimeout ?? _client().options.connectTimeout,
          receiveTimeout: receiveTimeout ?? _client().options.receiveTimeout,
          sendTimeout: sendTimeout ?? _client().options.sendTimeout,
          extra: extra ?? _client().options.extra,
          headers: headers ?? _client().options.headers,
          responseType: responseType ?? _client().options.responseType,
          contentType: contentType ?? _client().options.contentType,
          validateStatus: validateStatus ?? _client().options.validateStatus,
          receiveDataWhenStatusError:
              receiveDataWhenStatusError ??
              _client().options.receiveDataWhenStatusError,
          followRedirects: followRedirects ?? _client().options.followRedirects,
          maxRedirects: maxRedirects ?? _client().options.maxRedirects,
          persistentConnection:
              persistentConnection ?? _client().options.persistentConnection,
          requestEncoder: requestEncoder ?? _client().options.requestEncoder,
          responseDecoder: responseDecoder ?? _client().options.responseDecoder,
          listFormat: listFormat ?? _client().options.listFormat,
        ),
      crashLog: crashLog,
    );
  }

  @override
  void dispose() {
    _client().close();
  }
}
