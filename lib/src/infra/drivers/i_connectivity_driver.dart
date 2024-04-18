import 'dart:async';

import '../../domain/enums/connectivity_status.dart';

abstract class IConnectivityDriver {
  Future<bool> get isOnline;
  StreamSubscription<List<ConnectivityStatus>> get onConnectivityChanged;
}
