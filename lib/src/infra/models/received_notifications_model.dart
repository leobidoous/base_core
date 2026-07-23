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
    super.android,
    super.apple,
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
      payload: map['payload'] is Map ? map['payload'] : {},
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
      ttl: entity.ttl,
      from: entity.from,
      senderId: entity.senderId,
      category: entity.category,
      sentTime: entity.sentTime,
      threadId: entity.threadId,
      messageId: entity.messageId,
      messageType: entity.messageType,
      collapseKey: entity.collapseKey,
      mutableContent: entity.mutableContent,
      contentAvailable: entity.contentAvailable,
      android: entity.android,
      apple: entity.apple,
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
    'threadId': threadId,
    'messageId': messageId,
    'messageType': messageType,
    'collapseKey': collapseKey,
    'mutableContent': mutableContent,
    'contentAvailable': contentAvailable,
    'sentTime': sentTime?.toIso8601String(),

    'android.channelId': ?android?.channelId,
    'android.clickAction': ?android?.clickAction,
    'android.color': ?android?.color,
    'android.count': ?android?.count,
    'android.imageUrl': ?android?.imageUrl,
    'android.link': ?android?.link,
    'android.smallIcon': ?android?.smallIcon,
    'android.sound': ?android?.sound,
    'android.ticker': ?android?.ticker,
    'android.tag': ?android?.tag,
    'apple.badge': ?apple?.badge,
    'apple.imageUrl': ?apple?.imageUrl,
    'apple.subtitle': ?apple?.subtitle,
    'apple.subtitleLocArgs': ?apple?.subtitleLocArgs,
    'apple.subtitleLocKey': ?apple?.subtitleLocKey,
    'apple.soundName': ?apple?.soundName,
    'apple.soundCritical': ?apple?.soundCritical,
    'apple.soundVolume': ?apple?.soundVolume,
  });

  Map<String, dynamic> get toMap {
    late final String payload;
    try {
      payload = jsonEncode(this.payload);
    } catch (e) {
      payload = '';
    }
    return {
      'id': id,
      'ttl': ttl,
      'body': body,
      'from': from,
      'title': title,
      'payload': payload,
      'senderId': senderId,
      'category': category,
      'threadId': threadId,
      'messageId': messageId,
      'messageType': messageType,
      'collapseKey': collapseKey,
      'mutableContent': mutableContent,
      'contentAvailable': contentAvailable,
      'sentTime': sentTime?.toIso8601String(),

      'android.channelId': ?android?.channelId,
      'android.clickAction': ?android?.clickAction,
      'android.color': ?android?.color,
      'android.count': ?android?.count,
      'android.imageUrl': ?android?.imageUrl,
      'android.link': ?android?.link,
      'android.smallIcon': ?android?.smallIcon,
      'android.sound': ?android?.sound,
      'android.ticker': ?android?.ticker,
      'android.tag': ?android?.tag,
      'apple.badge': ?apple?.badge,
      'apple.imageUrl': ?apple?.imageUrl,
      'apple.subtitle': ?apple?.subtitle,
      'apple.subtitleLocArgs': ?apple?.subtitleLocArgs,
      'apple.subtitleLocKey': ?apple?.subtitleLocKey,
      'apple.soundName': ?apple?.soundName,
      'apple.soundCritical': ?apple?.soundCritical,
      'apple.soundVolume': ?apple?.soundVolume,
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
    android,
    apple,
  ];

  @override
  bool? get stringify => true;
}
