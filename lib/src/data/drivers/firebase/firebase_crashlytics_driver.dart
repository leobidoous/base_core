import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_crashlytics_driver.dart';

class FirebaseCrashlyticsDriver extends IFirebaseCrashlyticsDriver {
  FirebaseCrashlyticsDriver();

  FirebaseCrashlytics get instance {
    try {
      return FirebaseCrashlytics.instance;
    } catch (e) {
      return throw (e);
    }
  }

  @override
  Future<Either<Exception, Unit>> setError({
    required exception,
    StackTrace? stackTrace,
    bool fatal = false,
  }) async {
    try {
      await instance.recordError(
        exception,
        stackTrace,
        printDetails: false,
        fatal: fatal,
      );
      return Right(unit);
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsDriver.setError: $exception');
      return Left(Exception(exception));
    }
  }

  /// Define informações do usuário para rastreamento
  @override
  Future<Either<Exception, Unit>> setUserIdentifier({
    required String userId,
  }) async {
    try {
      await instance.setUserIdentifier(userId);
      return Right(unit);
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsDriver.setUserIdentifier: $exception');
      return Left(Exception(exception));
    }
  }

  /// Define atributos customizados do usuário
  @override
  Future<Either<Exception, Unit>> setCustomKey({
    required String key,
    required dynamic value,
  }) async {
    try {
      await instance.setCustomKey(key, value);
      return Right(unit);
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsDriver.setCustomKey: $exception');
      return Left(Exception(exception));
    }
  }

  /// Define múltiplos atributos customizados de uma vez
  @override
  Future<Either<Exception, Unit>> setCustomKeys({
    required Map<String, dynamic> keys,
  }) async {
    try {
      for (final entry in keys.entries) {
        await instance.setCustomKey(entry.key, entry.value);
      }
      return Right(unit);
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsDriver.setCustomKeys: $exception');
      return Left(Exception(exception));
    }
  }

  /// Registra log customizado (breadcrumb)
  @override
  Future<Either<Exception, Unit>> log({required String message}) async {
    try {
      await instance.log(message);
      return Right(unit);
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsDriver.log: $exception');
      return Left(Exception(exception));
    }
  }

  /// Verifica se a coleta de crashlytics está habilitada
  @override
  Future<Either<Exception, bool>> isCrashlyticsCollectionEnabled() async {
    try {
      final isEnabled = instance.isCrashlyticsCollectionEnabled;
      return Right(isEnabled);
    } catch (exception) {
      debugPrint(
        'FirebaseCrashlyticsDriver.isCrashlyticsCollectionEnabled: $exception',
      );
      return Left(Exception(exception));
    }
  }

  /// Habilita/desabilita coleta de crashlytics
  @override
  Future<Either<Exception, Unit>> setCrashlyticsCollectionEnabled({
    required bool enabled,
  }) async {
    try {
      await instance.setCrashlyticsCollectionEnabled(enabled);
      return Right(unit);
    } catch (exception) {
      debugPrint(
        'FirebaseCrashlyticsDriver.setCrashlyticsCollectionEnabled: $exception',
      );
      return Left(Exception(exception));
    }
  }

  /// Envia crashes não enviados imediatamente
  @override
  Future<Either<Exception, Unit>> sendUnsentReports() async {
    try {
      await instance.sendUnsentReports();
      return Right(unit);
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsDriver.sendUnsentReports: $exception');
      return Left(Exception(exception));
    }
  }

  /// Deleta crashes não enviados
  @override
  Future<Either<Exception, Unit>> deleteUnsentReports() async {
    try {
      await instance.deleteUnsentReports();
      return Right(unit);
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsDriver.deleteUnsentReports: $exception');
      return Left(Exception(exception));
    }
  }

  /// Verifica se há crashes não enviados
  @override
  Future<Either<Exception, bool>> checkForUnsentReports() async {
    try {
      final hasUnsent = await instance.checkForUnsentReports();
      return Right(hasUnsent);
    } catch (exception) {
      debugPrint('FirebaseCrashlyticsDriver.checkForUnsentReports: $exception');
      return Left(Exception(exception));
    }
  }

  /// Define se deve processar crashes automaticamente
  Future<Either<Exception, Unit>> setCrashlyticsProcessingEnabled({
    required bool enabled,
  }) async {
    try {
      // Disponível apenas em algumas plataformas
      if (!kIsWeb) {
        await instance.setCrashlyticsCollectionEnabled(enabled);
      }
      return Right(unit);
    } catch (exception) {
      debugPrint(
        'FirebaseCrashlyticsDriver.setCrashlyticsProcessingEnabled: $exception',
      );
      return Left(Exception(exception));
    }
  }
}
