import '../../domain/entities/package_info_entity.dart';

class PackageInfoModel extends PackageInfoEntity {
  PackageInfoModel({
    required super.name,
    required super.version,
    required super.appName,
    required super.forceUpdate,
    required super.buildNumber,
    required super.buildSignature,
  });

  factory PackageInfoModel.fromMap(Map<String, dynamic> map) {
    return PackageInfoModel(
      name: map['name'] ?? '',
      appName: map['app-name'] ?? '',
      version: map['version-number'] ?? '',
      buildNumber: map['build-number'] ?? 0,
      forceUpdate: map['force-update'] == true,
      buildSignature: map['build-signature'] ?? '',
    );
  }

  factory PackageInfoModel.fromEntity(PackageInfoEntity entity) {
    return PackageInfoModel(
      name: entity.name,
      appName: entity.appName,
      version: entity.version,
      buildNumber: entity.buildNumber,
      forceUpdate: entity.forceUpdate,
      buildSignature: entity.buildSignature,
    );
  }
}
