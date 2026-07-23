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
    this.android,
    this.apple,
  });
  final int id;
  final int? ttl;
  final String? from;
  final String? body;
  final String? title;
  final String? senderId;
  final String? category;
  final String? threadId;
  final String? messageId;
  final DateTime? sentTime;
  final String? messageType;
  final String? collapseKey;
  final bool? mutableContent;
  final bool? contentAvailable;
  final AppleNotificationData? apple;
  final Map<String, dynamic>? payload;
  final AndroidNotificationData? android;
}

/// Dados específicos de notificação Android.
class AndroidNotificationData {
  const AndroidNotificationData({
    this.channelId,
    this.clickAction,
    this.color,
    this.count,
    this.imageUrl,
    this.link,
    this.smallIcon,
    this.sound,
    this.ticker,
    this.tag,
  });

  final String? channelId;
  final String? clickAction;
  final String? color;
  final int? count;
  final String? imageUrl;
  final String? link;
  final String? smallIcon;
  final String? sound;
  final String? ticker;
  final String? tag;
}

/// Dados específicos de notificação Apple (iOS/macOS).
class AppleNotificationData {
  const AppleNotificationData({
    this.badge,
    this.imageUrl,
    this.subtitle,
    this.subtitleLocArgs = const [],
    this.subtitleLocKey,
    this.soundName,
    this.soundCritical = false,
    this.soundVolume = 0,
  });

  final String? badge;
  final String? imageUrl;
  final String? subtitle;
  final List<String> subtitleLocArgs;
  final String? subtitleLocKey;
  final String? soundName;
  final bool soundCritical;
  final num soundVolume;
}
