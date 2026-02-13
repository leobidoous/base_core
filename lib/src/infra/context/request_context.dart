import 'dart:async';

import 'package:dio/dio.dart' show CancelToken;

/// Contexto global para armazenar o CancelToken do controller ativo
/// Permite que o DioClientDriver acesse automaticamente o
/// token sem propagação manual
class RequestContext {
  RequestContext._();

  static const _cancelTokenKey = #requestCancelToken;

  /// Obtém o CancelToken do contexto atual (se existir)
  static CancelToken? get current {
    return Zone.current[_cancelTokenKey] as CancelToken?;
  }

  /// Executa uma função dentro de um contexto com CancelToken
  /// Usado internamente pelo CustomController
  static R runWithCancelToken<R>(CancelToken cancelToken, R Function() body) {
    return runZoned(body, zoneValues: {_cancelTokenKey: cancelToken});
  }
}
