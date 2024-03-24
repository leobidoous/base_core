import 'package:equatable/equatable.dart';

import '../../domain/entities/position_entity.dart';

class PositionModel extends PositionEntity with EquatableMixin {
  PositionModel({required super.latitude, required super.longitude});

  factory PositionModel.fromMap(Map<String, dynamic> map) {
    return PositionModel(
      latitude: map['latitude'] ?? 0,
      longitude: map['longitude'] ?? 0,
    );
  }

  factory PositionModel.fromEntity(PositionEntity entity) {
    return PositionModel(
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }

  PositionEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];

  @override
  bool? get stringify => true;
}
