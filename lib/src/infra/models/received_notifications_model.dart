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
    // Gerar um ID único baseado no timestamp se não houver ID no map
    final id =
        map['id'] != null
            ? int.tryParse(map['id'].toString()) ??
                DateTime.now().millisecondsSinceEpoch.remainder(100000)
            : DateTime.now().millisecondsSinceEpoch.remainder(100000);

    return ReceivedNotificationModel(
      id: id,
      body: map['body']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      payload: map['payload']?.toString() ?? '',
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
