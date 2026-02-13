import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

/// Mixin para gerenciar CancelToken do Dio em páginas/widgets
///
/// Uso:
/// ```dart
/// class MyPage extends StatefulWidget {
///   @override
///   State<MyPage> createState() => _MyPageState();
/// }
///
/// class _MyPageState extends State<MyPage> with CancelTokenMixin {
///   @override
///   void initState() {
///     super.initState();
///     _fetchData();
///   }
///
///   Future<void> _fetchData() async {
///     final options = HttpDriverOptions(cancelToken: cancelToken);
///     await httpDriver.get('/api/data', options: options);
///   }
/// }
/// ```
mixin CancelTokenMixin<T extends StatefulWidget> on State<T> {
  CancelToken? _cancelToken;

  /// CancelToken para ser usado nas requisições HTTP
  CancelToken get cancelToken {
    _cancelToken ??= CancelToken();
    return _cancelToken!;
  }

  /// Cancela todas as requisições pendentes
  void cancelRequests([String? reason]) {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel(reason ?? 'Request cancelled by user');
    }
  }

  @override
  void dispose() {
    cancelRequests('Widget disposed');
    super.dispose();
  }
}
