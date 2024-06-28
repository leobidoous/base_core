class ReceivedNotificationEntity {
  ReceivedNotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  // TODO: Map more remote message fields
  // final String? senderId;
  // final String? category;
  // final String? collapseKey;
  // final bool contentAvailable;
  // final String? from;
  // final String? messageId;
  // final String? messageType;
  // final bool mutableContent;
  // final DateTime? sentTime;
  // final String? threadId;
  // final int? ttl;
}
