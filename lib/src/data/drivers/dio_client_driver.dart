import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:path_provider/path_provider.dart';

import '../../core/utils/crash_log.dart';
import '../../domain/interfaces/disposable.dart';
import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_http_driver.dart';

class DioClientDriver extends IHttpDriver with Disposable {
  DioClientDriver({required this.client, this.crashLog});

  final dio.Dio client;
  final CrashLog? crashLog;

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
          statusMessage = '${e.message}\n$data';
          break;
      }

      crashLog?.capture(
        exception: HttpFailure(
          exception: e,
          stackTrace: StackTrace.current,
          path: e.requestOptions.baseUrl + e.requestOptions.path,
          params: e.requestOptions.data ?? e.requestOptions.queryParameters,
        ),
        stackTrace: s,
      );

      return HttpDriverResponse(
        data: e.response?.data,
        statusMessage: statusMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (e, s) {
      crashLog?.capture(exception: e, stackTrace: s);

      return HttpDriverResponse(
        data: e,
        statusCode: -1,
        statusMessage: '',
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
          'Authorization': '${options.accessTokenType} ${options.accessToken}',
        if (options != null && options.apiKey != null)
          '${options.apiMapKey}': '${options.apiKey}',
        ...?options?.extraHeaders,
      },
    );
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
      final response = await client.delete(
        path,
        queryParameters: queryParameters,
        options: _options(options),
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
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: _options(options),
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

      final response = await client.download(
        path,
        tempPath,
        options: _options(options),
        queryParameters: queryParameters,
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
      final response = await client.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(options),
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
      final response = await client.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(options),
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
      final response = await client.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _options(options),
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
  Map<String, String>? get getHeaders => throw UnimplementedError();

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
      client: client
        ..options = client.options.copyWith(
          method: method ?? client.options.method,
          baseUrl: baseUrl ?? client.options.baseUrl,
          queryParameters: queryParameters ?? client.options.queryParameters,
          connectTimeout: connectTimeout ?? client.options.connectTimeout,
          receiveTimeout: receiveTimeout ?? client.options.receiveTimeout,
          sendTimeout: sendTimeout ?? client.options.sendTimeout,
          extra: extra ?? client.options.extra,
          headers: headers ?? client.options.headers,
          responseType: responseType ?? client.options.responseType,
          contentType: contentType ?? client.options.contentType,
          validateStatus: validateStatus ?? client.options.validateStatus,
          receiveDataWhenStatusError: receiveDataWhenStatusError ??
              client.options.receiveDataWhenStatusError,
          followRedirects: followRedirects ?? client.options.followRedirects,
          maxRedirects: maxRedirects ?? client.options.maxRedirects,
          persistentConnection:
              persistentConnection ?? client.options.persistentConnection,
          requestEncoder: requestEncoder ?? client.options.requestEncoder,
          responseDecoder: responseDecoder ?? client.options.responseDecoder,
          listFormat: listFormat ?? client.options.listFormat,
        ),
      crashLog: crashLog,
    );
  }

  @override
  void dispose() {
    client.close();
  }
}
