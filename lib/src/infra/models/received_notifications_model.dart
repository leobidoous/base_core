import 'dart:convert' show jsonEncode;

import 'package:equatable/equatable.dart';

import '../../domain/entities/received_notifications_entity.dart';

class ReceivedNotificationModel extends ReceivedNotificationEntity
    with Equatable {
  ReceivedNotificationModel({
    required super.id,
    required super.body,
    required super.title,
    required super.payload,
    super.ttl,
    super.from,
    super.senderId,
    super.category,
    super.sentTime,
    super.threadId,
    super.messageId,
    super.messageType,
    super.collapseKey,
    super.mutableContent,
    super.contentAvailable,
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
    'ttl': ttl,
    'body': body,
    'from': from,
    'title': title,
    'payload': payload,
    'senderId': senderId,
    'category': category,
    'sentTime': sentTime,
    'threadId': threadId,
    'messageId': messageId,
    'messageType': messageType,
    'collapseKey': collapseKey,
    'mutableContent': mutableContent,
    'contentAvailable': contentAvailable,
  });

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'ttl': ttl,
      'body': body,
      'from': from,
      'title': title,
      'payload': payload,
      'senderId': senderId,
      'category': category,
      'sentTime': sentTime,
      'threadId': threadId,
      'messageId': messageId,
      'messageType': messageType,
      'collapseKey': collapseKey,
      'mutableContent': mutableContent,
      'contentAvailable': contentAvailable,
    };
  }

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
