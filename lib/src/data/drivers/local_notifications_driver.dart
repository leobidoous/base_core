import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show
        FlutterLocalNotificationsPlugin,
        NotificationResponse,
        AndroidInitializationSettings,
        DarwinInitializationSettings,
        InitializationSettings,
        AndroidNotificationDetails,
        NotificationDetails,
        Importance,
        Priority,
        DarwinNotificationDetails;
import 'package:rxdart/subjects.dart' show BehaviorSubject;

import '../../domain/entities/received_notifications_entity.dart'
    show ReceivedNotificationEntity;
import '../../domain/interfaces/disposable.dart';
import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_local_notifications_driver.dart'
    show ILocalNotificationsDriver;

class LocalNotificationsDriver extends ILocalNotificationsDriver
    with Disposable {
  LocalNotificationsDriver({required this.onReceiveNotification});
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<NotificationResponse> onReceiveNotification;

  @override
  Future<Either<Exception, Unit>> init() async {
    try {
      const settingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );
      final settingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      final settings = InitializationSettings(
        android: settingsAndroid,
        iOS: settingsIOS,
      );
      await _localNotificationsPlugin.initialize(
        settings,
        onDidReceiveNotificationResponse: (NotificationResponse payload) async {
          debugPrint('notification payload: $payload');
          onReceiveNotification.add(payload);
        },
      );
      debugPrint('LocalNotificationsDriver iniciado com sucesso.');
      return Right(unit);
    } catch (e) {
      debugPrint('Erro ao iniciar LocalNotificationsDriver.');
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> requestPermissions() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> scheduleNotification() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> showNotification({
    required ReceivedNotificationEntity notification,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );
      const iOSDetails = DarwinNotificationDetails();
      const platformChannelSpecifics = NotificationDetails(
        android: androidDetails,
        iOS: iOSDetails,
      );
      await _localNotificationsPlugin.show(
        notification.id,
        notification.body,
        notification.title,
        platformChannelSpecifics,
        payload: notification.payload,
      );
      debugPrint('LocalNotificationsDriver exibida com sucesso: $notification');
      return Right(unit);
    } catch (e) {
      debugPrint('LocalNotificationsDriver não exibida.');
      return Left(Exception(e));
    }
  }

  @override
  void dispose() {
    onReceiveNotification.close();
  }
}
