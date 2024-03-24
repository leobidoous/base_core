import '../../../core.dart' show Either, ILocationFailure, PositionEntity;

import '../../domain/services/i_location_service.dart';
import '../drivers/i_location_driver.dart';

class LocationService extends ILocationService {
  LocationService({required this.locationDriver});
  final ILocationDriver locationDriver;

  @override
  Future<Either<ILocationFailure, PositionEntity>> getCurrentPosition() {
    return locationDriver.getCurrentPosition();
  }
}
