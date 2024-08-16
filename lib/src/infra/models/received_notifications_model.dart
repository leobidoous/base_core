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
    super.senderId,
    super.category,
    super.collapseKey,
    super.contentAvailable,
    super.from,
    super.messageId,
    super.messageType,
    super.mutableContent,
    super.sentTime,
    super.threadId,
    super.ttl,
  });

  factory ReceivedNotificationModel.fromMap(Map<String, dynamic> map) {
    return ReceivedNotificationModel(
      id: int.tryParse(map['id'].toString()) ?? 0,
      title: map['title'],
      body: map['body'],
      payload: map['payload'],
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
        id,
        title,
        body,
        payload,
        senderId,
        category,
        collapseKey,
        contentAvailable,
        from,
        messageId,
        messageType,
        mutableContent,
        sentTime,
        threadId,
        ttl,
      });

  ReceivedNotificationEntity get toEntity => this;

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        payload,
        senderId,
        category,
        collapseKey,
        contentAvailable,
        from,
        messageId,
        messageType,
        mutableContent,
        sentTime,
        threadId,
        ttl,
      ];

  @override
  bool? get stringify => true;
}
