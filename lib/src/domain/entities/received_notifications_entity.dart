class ReceivedNotificationEntity {
  ReceivedNotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    this.senderId,
    this.category,
    this.collapseKey,
    this.contentAvailable,
    this.from,
    this.messageId,
    this.messageType,
    this.mutableContent,
    this.sentTime,
    this.threadId,
    this.ttl,
  });
  final int id;
  final String? title;
  final String? body;
  final String? payload;
  final String? senderId;
  final String? category;
  final String? collapseKey;
  final bool? contentAvailable;
  final String? from;
  final String? messageId;
  final String? messageType;
  final bool? mutableContent;
  final DateTime? sentTime;
  final String? threadId;
  final int? ttl;
}
