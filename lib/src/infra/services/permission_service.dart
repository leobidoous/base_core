import 'package:permission_handler/permission_handler.dart';

import '../../domain/enums/permission_status_type_enum.dart';
import '../../domain/enums/permission_type_enum.dart';
import '../../domain/interfaces/either.dart';
import '../../domain/services/i_permission_service.dart';

class PermissionService extends IPermissionService {
  @override
  Future<Either<Exception, PermissionStatusType>> getPermissionStatus({
    required PermissionType permission,
  }) async {
    try {
      PermissionStatus? response;
      switch (permission) {
        case .location:
          response = await Permission.location.status;
          break;
        case .locationAlways:
          response = await Permission.locationAlways.status;
          break;
        case .locationWhenInUse:
          response = await Permission.locationWhenInUse.status;
          break;
        case .accessMediaLocation:
          response = await Permission.accessMediaLocation.status;
          break;
        case .camera:
          response = await Permission.camera.status;
          break;
        case .mediaLibrary:
          response = await Permission.mediaLibrary.status;
          break;
        case .photos:
          response = await Permission.photos.status;
          break;
        case .microphone:
          response = await Permission.microphone.status;
          break;
        case .audio:
          response = await Permission.audio.status;
          break;
        case .notification:
          response = await Permission.notification.status;
          break;
        case .storage:
          response = await Permission.storage.status;
          break;
        case .manageExternalStorage:
          response = await Permission.manageExternalStorage.status;
          break;
        case .appTrackingTransparency:
          response = await Permission.appTrackingTransparency.status;
          break;
        case .contacts:
          response = await Permission.contacts.status;
          break;
        default:
          break;
      }
      return Right(permissionStatusFromType(response?.name));
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, PermissionStatusType>> requestPermission({
    required PermissionType permission,
  }) async {
    try {
      PermissionStatus? response;
      switch (permission) {
        case .notification:
          response = await Permission.notification.request();
          break;
        case .accessNotificationPolicy:
          response = await Permission.accessMediaLocation.request();
          break;
        case .location:
          response = await Permission.location.request();
          break;
        case .calendar:
          response = await Permission.calendarFullAccess.request();
          break;
        case .mediaLibrary:
          response = await Permission.mediaLibrary.request();
          break;
        case .accessMediaLocation:
          response = await Permission.accessMediaLocation.request();
          break;
        case .camera:
          response = await Permission.camera.request();
          break;
        case .locationAlways:
          response = await Permission.locationAlways.request();
          break;
        case .locationWhenInUse:
          response = await Permission.locationWhenInUse.request();
          break;
        case .storage:
          response = await Permission.storage.request();
          break;
        case .manageExternalStorage:
          response = await Permission.manageExternalStorage.request();
          break;
        case .appTrackingTransparency:
          response = await Permission.appTrackingTransparency.request();
          break;
        default:
          break;
      }
      return Right(permissionStatusFromType(response?.name));
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, bool>> openAppPermissionSettings() async {
    try {
      return Right(await openAppSettings());
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
