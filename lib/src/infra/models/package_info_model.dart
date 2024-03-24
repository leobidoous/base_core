import 'package:equatable/equatable.dart';

import '../../domain/entities/package_info_entity.dart';

class PackageInfoModel extends PackageInfoEntity with EquatableMixin {
  PackageInfoModel({
    required super.appName,
    required super.name,
    required super.version,
    required super.forceUpdate,
    required super.buildNumber,
    required super.buildSignature,
  });

  factory PackageInfoModel.fromMap(Map<String, dynamic> map) {
    return PackageInfoModel(
      appName: map['appName'] ?? '',
      forceUpdate: map['forceUpdate'] ?? false,
      name: map['name'] ?? '',
      version: map['versionNumber'] ?? '',
      buildNumber: map['buildNumber'] ?? 0,
      buildSignature: map['buildSignature'] ?? '',
    );
  }

  factory PackageInfoModel.fromEntity(PackageInfoEntity entity) {
    return PackageInfoModel(
      appName: entity.appName,
      forceUpdate: entity.forceUpdate,
      name: entity.name,
      version: entity.version,
      buildNumber: entity.buildNumber,
      buildSignature: entity.buildSignature,
    );
  }

  PackageInfoEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'appName': appName,
      'forceUpdate': forceUpdate,
      'name': name,
      'versionNumber': version,
      'buildNumber': buildNumber,
      'buildSignature': buildSignature,
    };
  }

  @override
  List<Object?> get props => [
        appName,
        name,
        forceUpdate,
        version,
        buildNumber,
        buildSignature,
      ];

  @override
  bool? get stringify => true;
}
