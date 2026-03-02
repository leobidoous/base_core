import 'dart:convert' show jsonEncode;

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
    final id = map['id'] != null
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
      body: entity.body,
      title: entity.title,
      payload: entity.payload,
    );
  }

  String get toJson => jsonEncode({
    'id': id,
    'title': title,
    'body': body,
    'payload': payload,
    'senderId': senderId,
    'category': category,
    'collapseKey': collapseKey,
    'contentAvailable': contentAvailable,
    'from': from,
    'messageId': messageId,
    'messageType': messageType,
    'mutableContent': mutableContent,
    'sentTime': sentTime,
    'threadId': threadId,
    'ttl': ttl,
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
