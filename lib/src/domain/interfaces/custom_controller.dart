import 'dart:async';

import 'package:equatable/equatable.dart' show EquatableMixin;
import 'package:flutter/foundation.dart' show ValueNotifier, debugPrint;

import 'either.dart';

abstract class CustomController<E, S> extends ValueNotifier<S>
    with EquatableMixin {
  CustomController(super.value);

  bool _wasDisposed = false;
  final ValueNotifier<E?> _error = ValueNotifier(null);
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  bool get wasDisposed => _wasDisposed;

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
    _error.value = null;
    if (update) {
      notifyListeners();
    }
  }

  bool get isLoading => _loading.value;
  void setLoading(bool value) {
    if (!_wasDisposed) {
      _loading.value = value;
      notifyListeners();
    }
  }

  S get state => value;
  void update(S state, {force = false}) {
    if (!_wasDisposed) {
      clearError();
      setLoading(false);
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
    final response = await function();
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
  List<Object?> get props {
    try {
      return [
        value,
        error,
        hashCode,
        isLoading,
        wasDisposed,
      ];
    } catch (exception) {
      try {
        return [
          value,
          error,
          isLoading,
          wasDisposed,
        ];
      } catch (exception) {
        throw Exception(
          '''You are probably trying to compare $S after changing your value.''',
        );
      }
    }
  }

  @override
  bool? get stringify => true;

  @override
  void dispose() {
    try {
      if (_wasDisposed) {
        debugPrint('$runtimeType already disposed');
        return;
      }
      debugPrint('$runtimeType has been disposed');
      _error.dispose();
      _loading.dispose();
      _wasDisposed = true;
    } catch (exception) {
      debugPrint('$runtimeType already disposed');
    }
    super.dispose();
  }
}
