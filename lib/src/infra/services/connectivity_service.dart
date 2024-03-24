import 'dart:async';

import '../../domain/enums/connectivity_status.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/services/i_connectivity_service.dart'
    show IConnectivityService;
import '../drivers/i_connectivity_driver.dart' show IConnectivityDriver;

class ConnectivityService implements IConnectivityService {
  ConnectivityService({required this.driver});
  final IConnectivityDriver driver;

  @override
  Future<Either<Exception, Unit>> isOnline() async {
    try {
      if (await driver.isOnline) return Right(unit);

      throw Exception('Você está offline.');
    } catch (e) {
      return Left(Exception('Erro ao recuperar informação de conexão: $e'));
    }
  }

  @override
  StreamSubscription<ConnectivityStatus> get onConnectivityChanged =>
      driver.onConnectivityChanged;
}
