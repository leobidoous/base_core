import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/interfaces/either.dart';
import '../../../domain/services/firebase/i_firebase_crashlytics_service.dart';
import '../../drivers/firebase/i_firebase_crashlytics_driver.dart';

class FirebaseCrashlyticsService extends IFirebaseCrashlyticsService {
  FirebaseCrashlyticsService({required this.firebaseCrashlyticsDriver});

  final IFirebaseCrashlyticsDriver firebaseCrashlyticsDriver;

  FirebaseCrashlytics get instance {
    try {
      return FirebaseCrashlytics.instance;
    } catch (e) {
      return throw (e);
    }
  }

  @override
  Future<Either<Exception, Unit>> init({Map<String, dynamic>? params}) async {
    try {
      // Habilitar coleta de crashlytics, exceto no WEB
      if (!kIsWeb) {
        await instance.setCrashlyticsCollectionEnabled(true);
      }

      // Capturar erros do Flutter framework
      FlutterError.onError = (FlutterErrorDetails details) {
        instance.recordFlutterError(details);
      };

      // Capturar erros assíncronos não tratados (PlatformDispatcher)
      PlatformDispatcher.instance.onError = (error, stack) {
        instance.recordError(error, stack, fatal: true);
        return true;
      };

      // Configurar informações iniciais do app (se fornecidas)
      if (params != null) {
        final keys = <String, dynamic>{};
        if (params.containsKey('appVersion')) {
          keys['app_version'] = params['appVersion'];
        }
        if (params.containsKey('buildNumber')) {
          keys['build_number'] = params['buildNumber'];
        }
        if (params.containsKey('flavor')) {
          keys['flavor'] = params['flavor'];
        }
        if (params.containsKey('environment')) {
          keys['environment'] = params['environment'];
        }

        if (keys.isNotEmpty) {
          await firebaseCrashlyticsDriver.setCustomKeys(keys: keys);
        }
      }

      debugPrint('FirebaseCrashlyticsService iniciado com sucesso.');
      return Right(unit);
    } catch (exception, stackTrace) {
      debugPrint('FirebaseCrashlyticsService.init: $exception');
      return setError(exception: exception, stackTrace: stackTrace);
    }
  }

  @override
  Future<Either<Exception, Unit>> setError({
    required exception,
    StackTrace? stackTrace,
    bool fatal = false,
  }) async {
    return firebaseCrashlyticsDriver.setError(
      exception: exception,
      stackTrace: stackTrace,
      fatal: fatal,
    );
  }

  /// Define informações do usuário logado
  @override
  Future<Either<Exception, Unit>> setUserInfo({
    required String userId,
    String? email,
    String? name,
    Map<String, dynamic>? customAttributes,
  }) async {
    try {
      // Define ID do usuário via driver
      final userIdResult = await firebaseCrashlyticsDriver.setUserIdentifier(
        userId: userId,
      );

      // Se falhou ao definir userId, retorna o erro
      return userIdResult.fold((error) => Left(error), (_) async {
        // Define atributos customizados do usuário
        final attributes = <String, dynamic>{
          if (email != null) 'user_email': email,
          if (name != null) 'user_name': name,
          if (customAttributes != null) ...customAttributes,
        };

        if (attributes.isNotEmpty) {
          return firebaseCrashlyticsDriver.setCustomKeys(keys: attributes);
        }

        return Right(unit);
      });
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsService.setUserInfo: $exception');
      return Left(Exception(exception));
    }
  }

  /// Limpa informações do usuário (útil no logout)
  @override
  Future<Either<Exception, Unit>> clearUserInfo() async {
    try {
      await firebaseCrashlyticsDriver.setUserIdentifier(userId: '');
      await firebaseCrashlyticsDriver.setCustomKeys(
        keys: {'user_email': '', 'user_name': ''},
      );
      return Right(unit);
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsService.clearUserInfo: $exception');
      return Left(Exception(exception));
    }
  }

  /// Registra breadcrumb (log de navegação/ações do usuário)
  @override
  Future<Either<Exception, Unit>> logBreadcrumb({
    required String message,
    Map<String, dynamic>? data,
  }) async {
    try {
      final logMessage = data != null
          ? '''$message | Data: ${data.entries.map((e) => '${e.key}=${e.value}').join(', ')}'''
          : message;

      return firebaseCrashlyticsDriver.log(message: logMessage);
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsService.logBreadcrumb: $exception');
      return Left(Exception(exception));
    }
  }

  /// Define contexto da sessão (útil para rastrear estado do app)
  @override
  Future<Either<Exception, Unit>> setSessionContext({
    required Map<String, dynamic> context,
  }) async {
    try {
      return firebaseCrashlyticsDriver.setCustomKeys(keys: context);
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsService.setSessionContext: $exception');
      return Left(Exception(exception));
    }
  }

  /// Registra evento de navegação
  @override
  Future<Either<Exception, Unit>> logNavigation({
    required String from,
    required String to,
  }) async {
    return logBreadcrumb(
      message: 'Navigation: $from → $to',
      data: {'from': from, 'to': to},
    );
  }

  /// Registra evento de API call
  @override
  Future<Either<Exception, Unit>> logApiCall({
    required String method,
    required String endpoint,
    int? statusCode,
    String? error,
  }) async {
    return logBreadcrumb(
      message: 'API Call: $method $endpoint',
      data: {
        'method': method,
        'endpoint': endpoint,
        if (statusCode != null) 'status_code': statusCode,
        if (error != null) 'error': error,
      },
    );
  }

  /// Registra evento de ação do usuário
  @override
  Future<Either<Exception, Unit>> logUserAction({
    required String action,
    Map<String, dynamic>? metadata,
  }) async {
    return logBreadcrumb(message: 'User Action: $action', data: metadata);
  }

  /// Envia crashes não enviados imediatamente
  @override
  Future<Either<Exception, Unit>> sendUnsentReports() async {
    try {
      return firebaseCrashlyticsDriver.sendUnsentReports();
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsService.sendUnsentReports: $exception');
      return Left(Exception(exception));
    }
  }

  /// Verifica se há crashes não enviados
  @override
  Future<Either<Exception, bool>> checkForUnsentReports() async {
    try {
      return firebaseCrashlyticsDriver.checkForUnsentReports();
    } catch (exception) {
      debugPrint(
        'FirebaseCrashlyticsService.checkForUnsentReports: $exception',
      );
      return Left(Exception(exception));
    }
  }
}
