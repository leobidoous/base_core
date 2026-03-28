import 'dart:async';

import '../../domain/enums/connectivity_status.dart';

abstract class IConnectivityDriver {
  Future<bool> get haveNetworkConnection;
  StreamSubscription<List<ConnectivityStatus>> get onConnectivityChanged;
}
