import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show
        FlutterLocalNotificationsPlugin,
        AndroidInitializationSettings,
        DarwinInitializationSettings,
        InitializationSettings,
        AndroidNotificationDetails,
        NotificationDetails,
        DarwinNotificationDetails;

import '../../domain/entities/received_notifications_entity.dart';
import '../../domain/interfaces/either.dart';
import '../../infra/drivers/i_local_notifications_driver.dart';
import '../../infra/models/received_notifications_model.dart';

class LocalNotificationsDriver extends ILocalNotificationsDriver {
  LocalNotificationsDriver();
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  Future<Either<Exception, Unit>> init({
    Function(ReceivedNotificationEntity message)? onMessageOpenedApp,
  }) async {
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
        settings: settings,
        onDidReceiveNotificationResponse: (payload) async {
          onMessageOpenedApp?.call(
            ReceivedNotificationModel.fromMap(
              jsonDecode(payload.payload ?? '{}'),
            ),
          );
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
  Future<Either<Exception, Unit>> requestPermissions() async {
    return Right(unit);
  }

  @override
  Future<Either<Exception, Unit>> scheduleNotification() async {
    return Right(unit);
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
        importance: .max,
        priority: .high,
        ticker: 'ticker',
      );
      const iOSDetails = DarwinNotificationDetails();
      const platformChannelSpecifics = NotificationDetails(
        android: androidDetails,
        iOS: iOSDetails,
      );

      await _localNotificationsPlugin.show(
        id: notification.id,
        body: notification.body,
        title: notification.title,
        payload: ReceivedNotificationModel.fromMap({
          'id': notification.id,
          'body': notification.body,
          'title': notification.title,
          'payload': notification.payload,
        }).toJson,
        notificationDetails: platformChannelSpecifics,
      );
      debugPrint('LocalNotificationsDriver exibida com sucesso: $notification');
      return Right(unit);
    } catch (e) {
      debugPrint('LocalNotificationsDriver não exibida.');
      return Left(Exception(e));
    }
  }
}
