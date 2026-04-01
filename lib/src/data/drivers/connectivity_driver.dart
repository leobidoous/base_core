import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/enums/connectivity_status.dart';
import '../../infra/drivers/i_connectivity_driver.dart';

class ConnectivityDriver implements IConnectivityDriver {
  ConnectivityDriver({required this.connectivity});

  final Connectivity connectivity;

  @override
  Future<bool> get haveNetworkConnection async {
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
              case .bluetooth:
                return ConnectivityStatus.bluetooth;
              case .wifi:
                return ConnectivityStatus.wifi;
              case .ethernet:
                return ConnectivityStatus.ethernet;
              case .mobile:
                return ConnectivityStatus.mobile;
              case .none:
                return ConnectivityStatus.none;
              case .vpn:
                return ConnectivityStatus.vpn;
              case .other:
                return ConnectivityStatus.other;
              case .satellite:
                return ConnectivityStatus.satellite;
            }
          }).toList();
        })
        .listen((event) => event);
  }
}
