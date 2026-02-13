import 'dart:async';

import 'package:dio/dio.dart' show CancelToken;
import 'package:flutter/foundation.dart' show ValueNotifier, debugPrint;

import '../../infra/context/request_context.dart';
import 'either.dart';

abstract class CustomController<E, S> extends ValueNotifier<S> {
  CustomController(super.value);

  bool _wasDisposed = false;
  CancelToken? _cancelToken;
  final ValueNotifier<E?> _error = ValueNotifier(null);
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  bool get wasDisposed => _wasDisposed;

  /// CancelToken para ser usado nas requisições HTTP
  /// Cria um novo token se necessário ou retorna o existente
  CancelToken get cancelToken {
    if (_cancelToken == null || _cancelToken!.isCancelled) {
      _cancelToken = CancelToken();
    }
    return _cancelToken!;
  }

  /// Cancela todas as requisições pendentes
  void cancelRequests([String? reason]) {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel(reason ?? 'Request cancelled by controller');
    }
  }

  E? get error => _error.value;
  bool get hasError => _error.value != null;
  void setError(E value) {
    if (!_wasDisposed) {
      _loading.value = false;
      _error.value = value;
      notifyListeners();
    }
  }

  void clearError({bool update = false}) {
    if (!_wasDisposed) {
      if (_error.value == null) return;
      _error.value = null;
      if (update) notifyListeners();
    }
  }

  bool get isLoading => _loading.value;
  void setLoading(bool value, {bool update = true}) {
    if (!_wasDisposed) {
      _loading.value = value;
      if (update) notifyListeners();
    }
  }

  S get state => value;
  void update(S state, {force = false}) {
    if (!_wasDisposed) {
      clearError();
      setLoading(false, update: false);
      if (value != state || force) {
        value = state;
        notifyListeners();
      }
    }
  }

  Future<Either<E, S>> execute(
    Future<Either<E, S>> Function() function, {
    force = false,
  }) async {
    clearError();
    setLoading(true);

    // Executa a função dentro de um contexto com o cancelToken
    // Isso permite que o DioClientDriver acesse o token automaticamente
    final response = await RequestContext.runWithCancelToken(
      cancelToken,
      () => function(),
    );

    response.fold(
      (l) {
        setError(l);
        return Left(l);
      },
      (r) {
        update(r, force: force);
        return Right(r);
      },
    );
    setLoading(false);
    return response;
  }

  @override
  void dispose() {
    try {
      if (_wasDisposed) {
        debugPrint('$runtimeType already disposed');
        return;
      }
      debugPrint('$runtimeType has been disposed');
      cancelRequests('Controller disposed');
      _error.dispose();
      _loading.dispose();
      _wasDisposed = true;
    } catch (exception) {
      debugPrint('$runtimeType already disposed');
    }
    super.dispose();
  }
}
