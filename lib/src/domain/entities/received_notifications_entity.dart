class ReceivedNotificationEntity {
  ReceivedNotificationEntity({
    required this.id,
    required this.body,
    required this.title,
    required this.payload,
    this.ttl,
    this.from,
    this.sentTime,
    this.threadId,
    this.senderId,
    this.category,
    this.messageId,
    this.collapseKey,
    this.messageType,
    this.mutableContent,
    this.contentAvailable,
  });
  final int id;
  final int? ttl;
  final String? from;
  final String? body;
  final String? title;
  final String? payload;
  final String? senderId;
  final String? category;
  final String? threadId;
  final String? messageId;
  final DateTime? sentTime;
  final String? messageType;
  final String? collapseKey;
  final bool? mutableContent;
  final bool? contentAvailable;
}
