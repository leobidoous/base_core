import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;

import '../../domain/enums/connectivity_status.dart';
import '../../infra/drivers/i_connectivity_driver.dart'
    show IConnectivityDriver;

class ConnectivityDriver implements IConnectivityDriver {
  ConnectivityDriver({required this.connectivity});
  final Connectivity connectivity;

  @override
  Future<bool> get isOnline async {
    final result = await connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet) ||
        result.contains(ConnectivityResult.mobile);
  }

  @override
  StreamSubscription<List<ConnectivityStatus>> get onConnectivityChanged {
    return connectivity.onConnectivityChanged
        .map((event) {
          return event.map((status) {
            switch (status) {
              case ConnectivityResult.bluetooth:
                return ConnectivityStatus.bluetooth;
              case ConnectivityResult.wifi:
                return ConnectivityStatus.wifi;
              case ConnectivityResult.ethernet:
                return ConnectivityStatus.ethernet;
              case ConnectivityResult.mobile:
                return ConnectivityStatus.mobile;
              case ConnectivityResult.none:
                return ConnectivityStatus.none;
              case ConnectivityResult.vpn:
                return ConnectivityStatus.vpn;
              case ConnectivityResult.other:
                return ConnectivityStatus.other;
            }
          }).toList();
        })
        .listen((event) => event);
  }
}
