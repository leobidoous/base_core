import '../../../domain/interfaces/either.dart';
import '../i_crash_log_driver.dart';

abstract class IFirebaseCrashlyticsDriver extends ICrashLogDriver {
  /// Define informações do usuário para rastreamento
  Future<Either<Exception, Unit>> setUserIdentifier({required String userId});

  /// Define atributos customizados do usuário
  Future<Either<Exception, Unit>> setCustomKey({
    required String key,
    required dynamic value,
  });

  /// Define múltiplos atributos customizados de uma vez
  Future<Either<Exception, Unit>> setCustomKeys({
    required Map<String, dynamic> keys,
  });

  /// Registra log customizado (breadcrumb)
  Future<Either<Exception, Unit>> log({required String message});

  /// Verifica se a coleta de crashlytics está habilitada
  Future<Either<Exception, bool>> isCrashlyticsCollectionEnabled();

  /// Habilita/desabilita coleta de crashlytics
  Future<Either<Exception, Unit>> setCrashlyticsCollectionEnabled({
    required bool enabled,
  });

  /// Envia crashes não enviados imediatamente
  Future<Either<Exception, Unit>> sendUnsentReports();

  /// Deleta crashes não enviados
  Future<Either<Exception, Unit>> deleteUnsentReports();

  /// Verifica se há crashes não enviados
  Future<Either<Exception, bool>> checkForUnsentReports();
}
