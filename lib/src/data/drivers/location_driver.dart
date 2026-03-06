import 'package:geolocator/geolocator.dart';

import '../../domain/entities/position_entity.dart';
import '../../domain/failures/i_location_failure.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/services/i_permission_service.dart';
import '../../infra/drivers/i_location_driver.dart';

class LocationDriver extends ILocationDriver {
  LocationDriver({required this.permissionService});

  final IPermissionService permissionService;

  @override
  Future<Either<ILocationFailure, PositionEntity>> getCurrentPosition() async {
    try {
      final statusResponse = await permissionService.getPermissionStatus(
        permission: .location,
      );
      return statusResponse.fold(
        (l) => Left(CurrentLocationFailure(l.toString())),
        (r) async {
          try {
            switch (r) {
              case .denied:
                return Left(PermissionDeniedError('Permission denied'));
              case .granted:
                final response = await Geolocator.getCurrentPosition();
                return Right(
                  PositionEntity(
                    latitude: response.latitude,
                    longitude: response.longitude,
                  ),
                );
              case .restricted:
                return Left(PermissionRestrictedError('Permission restricted'));
              case .limited:
                return Left(PermissionLimitedError('Permission limited'));
              case .permanentlyDenied:
                return Left(
                  PermissionPermanentDeniedError(
                    'Permission permanently denied',
                  ),
                );
            }
          } catch (e) {
            return Left(CurrentLocationFailure(e.toString()));
          }
        },
      );
    } catch (e) {
      return Left(CurrentLocationFailure(e.toString()));
    }
  }
}
