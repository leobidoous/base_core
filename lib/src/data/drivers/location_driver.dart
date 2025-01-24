import 'package:geolocator/geolocator.dart';

import '../../domain/entities/position_entity.dart';
import '../../domain/enums/permission_status_type_enum.dart';
import '../../domain/enums/permission_type_enum.dart';
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
        permission: PermissionType.location,
      );
      return statusResponse.fold(
        (l) => Left(CurrentLocationFailure(l.toString())),
        (r) async {
          switch (r) {
            case PermissionStatusType.denied:
              return Left(PermissionDeniedError('Permission denied'));
            case PermissionStatusType.granted:
              final response = await Geolocator.getCurrentPosition();
              return Right(
                PositionEntity(
                  latitude: response.latitude,
                  longitude: response.longitude,
                ),
              );
            case PermissionStatusType.restricted:
              return Left(PermissionRestrictedError('Permission restricted'));
            case PermissionStatusType.limited:
              return Left(PermissionLimitedError('Permission limited'));
            case PermissionStatusType.permanentlyDenied:
              return Left(
                PermissionPermanentDeniedError('Permission permanently denied'),
              );
          }
        },
      );
    } catch (e) {
      return Left(CurrentLocationFailure(e.toString()));
    }
  }
}
