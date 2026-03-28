import 'dart:async';

import '../../domain/enums/connectivity_status.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/services/i_connectivity_service.dart';
import '../drivers/i_connectivity_driver.dart';

class ConnectivityService implements IConnectivityService {
  ConnectivityService({required this.driver});
  final IConnectivityDriver driver;

  @override
  Future<Either<Exception, Unit>> haveNetworkConnection() async {
    try {
      if (await driver.haveNetworkConnection) return Right(unit);

      throw Exception('Você está offline.');
    } catch (e) {
      return Left(Exception('Erro ao recuperar informação de conexão: $e'));
    }
  }

  @override
  StreamSubscription<List<ConnectivityStatus>> get onConnectivityChanged =>
      driver.onConnectivityChanged;
}
