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
        case PermissionType.location:
          response = await Permission.location.status;
          break;
        case PermissionType.locationAlways:
          response = await Permission.locationAlways.status;
          break;
        case PermissionType.locationWhenInUse:
          response = await Permission.locationWhenInUse.status;
          break;
        case PermissionType.accessMediaLocation:
          response = await Permission.accessMediaLocation.status;
          break;
        case PermissionType.camera:
          response = await Permission.camera.status;
          break;
        case PermissionType.mediaLibrary:
          response = await Permission.mediaLibrary.status;
          break;
        case PermissionType.photos:
          response = await Permission.photos.status;
          break;
        case PermissionType.microphone:
          response = await Permission.microphone.status;
          break;
        case PermissionType.audio:
          response = await Permission.audio.status;
          break;
        case PermissionType.notification:
          response = await Permission.notification.status;
          break;
        case PermissionType.storage:
          response = await Permission.storage.status;
          break;
        case PermissionType.manageExternalStorage:
          response = await Permission.manageExternalStorage.status;
          break;
        case PermissionType.appTrackingTransparency:
          response = await Permission.appTrackingTransparency.status;
          break;
        case PermissionType.contacts:
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
        case PermissionType.notification:
          response = await Permission.notification.request();
          break;
        case PermissionType.accessNotificationPolicy:
          response = await Permission.accessMediaLocation.request();
          break;
        case PermissionType.location:
          response = await Permission.location.request();
          break;
        case PermissionType.calendar:
          response = await Permission.calendarFullAccess.request();
          break;
        case PermissionType.mediaLibrary:
          response = await Permission.mediaLibrary.request();
          break;
        case PermissionType.accessMediaLocation:
          response = await Permission.accessMediaLocation.request();
          break;
        case PermissionType.camera:
          response = await Permission.camera.request();
          break;
        case PermissionType.locationAlways:
          response = await Permission.locationAlways.request();
          break;
        case PermissionType.locationWhenInUse:
          response = await Permission.locationWhenInUse.request();
          break;
        case PermissionType.storage:
          response = await Permission.storage.request();
          break;
        case PermissionType.manageExternalStorage:
          response = await Permission.manageExternalStorage.request();
          break;
        case PermissionType.appTrackingTransparency:
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
}
