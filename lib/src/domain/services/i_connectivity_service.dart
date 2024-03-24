import 'dart:async';

import '../enums/connectivity_status.dart';
import '../interfaces/either.dart';

abstract class IConnectivityService {
  Future<Either<Exception, Unit>> isOnline();
  StreamSubscription<ConnectivityStatus> get onConnectivityChanged;
}
