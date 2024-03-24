enum PermissionStatusType {
  /// The user denied access to the requested feature,
  /// permission needs to be asked first.
  denied,

  /// The user granted access to the requested feature.
  granted,

  /// The OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  /// *Only supported on iOS.*
  restricted,

  ///User has authorized this application for limited access.
  /// *Only supported on iOS (iOS14+).*
  limited,

  /// Permission to the requested feature is permanently denied, the permission
  /// dialog will not be shown when requesting this permission. The user may
  /// still change the permission status in the settings.
  permanentlyDenied,
}

extension PermissionStatusTypeExt on PermissionStatusType {}

PermissionStatusType permissionStatusFromType(String? status) {
  switch (status) {
    case 'denied':
      return PermissionStatusType.denied;
    case 'granted':
      return PermissionStatusType.granted;
    case 'restricted':
      return PermissionStatusType.restricted;
    case 'limited':
      return PermissionStatusType.limited;
    case 'permanentlyDenied':
      return PermissionStatusType.permanentlyDenied;
    default:
      return PermissionStatusType.denied;
  }
}
