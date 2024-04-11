import 'dart:convert' show json;

import 'package:equatable/equatable.dart';

import '../../domain/entities/received_notifications_entity.dart';

class ReceivedNotificationModel extends ReceivedNotificationEntity
    with EquatableMixin {
  ReceivedNotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.payload,
  });

  factory ReceivedNotificationModel.fromMap(Map<String, dynamic> map) {
    return ReceivedNotificationModel(
      title: map['title'],
      body: map['body'],
      payload: map['payload'],
      id: int.tryParse(map['id'].toString()) ?? 0,
    );
  }

  factory ReceivedNotificationModel.fromEntity(
    ReceivedNotificationEntity entity,
  ) {
    return ReceivedNotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      payload: entity.payload,
    );
  }

  String get toJson => json.encode({
        'id': id,
        'title': title,
        'body': body,
        'payload': payload,
      });
  ReceivedNotificationEntity get toEntity => this;

  @override
  List<Object?> get props => [id, title, body, payload];

  @override
  bool? get stringify => true;
}
