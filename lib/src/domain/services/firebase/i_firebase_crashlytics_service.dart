import '../../../domain/interfaces/either.dart';
import '../i_crash_log_service.dart';

abstract class IFirebaseCrashlyticsService extends ICrashLogService {
  /// Define informações do usuário logado
  Future<Either<Exception, Unit>> setUserInfo({
    required String userId,
    String? email,
    String? name,
    Map<String, dynamic>? customAttributes,
  });

  /// Limpa informações do usuário (útil no logout)
  Future<Either<Exception, Unit>> clearUserInfo();

  /// Registra breadcrumb (log de navegação/ações do usuário)
  Future<Either<Exception, Unit>> logBreadcrumb({
    required String message,
    Map<String, dynamic>? data,
  });

  /// Define contexto da sessão (útil para rastrear estado do app)
  Future<Either<Exception, Unit>> setSessionContext({
    required Map<String, dynamic> context,
  });

  /// Registra evento de navegação
  Future<Either<Exception, Unit>> logNavigation({
    required String from,
    required String to,
  });

  /// Registra evento de API call
  Future<Either<Exception, Unit>> logApiCall({
    required String method,
    required String endpoint,
    int? statusCode,
    String? error,
  });

  /// Registra evento de ação do usuário
  Future<Either<Exception, Unit>> logUserAction({
    required String action,
    Map<String, dynamic>? metadata,
  });

  /// Envia crashes não enviados imediatamente
  Future<Either<Exception, Unit>> sendUnsentReports();

  /// Verifica se há crashes não enviados
  Future<Either<Exception, bool>> checkForUnsentReports();
}
