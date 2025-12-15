import 'dart:convert' show jsonEncode;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/entities/received_notifications_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_notifications_driver.dart'
    show IFirebaseNotificationsDriver;
import '../../../infra/drivers/firebase/i_firebase_storage_driver.dart';
import '../../../infra/models/received_notifications_model.dart';

class FirebaseNotificationsDriver extends IFirebaseNotificationsDriver {
  FirebaseNotificationsDriver({
    required this.crashLog,
    required this.storageDriver,
  });

  final CrashLog crashLog;
  final IFirebaseStorageDriver storageDriver;

  FirebaseMessaging get instance {
    try {
      return FirebaseMessaging.instance;
    } catch (e, s) {
      crashLog.capture(exception: e, stackTrace: s);
      return throw (e);
    }
  }

  @override
  Future<Either<Exception, String>> getToken() async {
    try {
      final token = await instance.getToken();
      if (token == null) return Left(Exception('Token está vazio'));
      return Right(token);
    } catch (exception, strackTrace) {
      await crashLog.capture(exception: exception, stackTrace: strackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> configure({
    Function(ReceivedNotificationEntity)? onMessage,
    Function(ReceivedNotificationEntity)? onMessageOpenedApp,
  }) async {
    try {
      // Define as opções de apresentação para notificações da Apple
      // quando recebidas em primeiro plano.
      await instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        final notification = ReceivedNotificationModel(
          id: message.messageId?.hashCode ?? message.hashCode,
          title: message.notification?.title ?? '',
          body: message.notification?.title ?? '',
          payload: jsonEncode(message.data),
        );

        if (onMessage != null) onMessage(notification);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        final notification = ReceivedNotificationModel(
          id: message.messageId?.hashCode ?? message.hashCode,
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
          payload: jsonEncode(message.data),
        );

        if (onMessageOpenedApp != null) onMessageOpenedApp(notification);
      });

      debugPrint('FirebaseNotificationsDriver configurado com sucesso.');
      return Right(unit);
    } catch (exception, strackTrace) {
      await crashLog.capture(exception: exception, stackTrace: strackTrace);
      debugPrint('Erro ao configurar FirebaseNotificationsDriver.');
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> subscribeToTopic({
    required String topic,
  }) async {
    try {
      await instance.subscribeToTopic(topic);
      debugPrint('Subscribed in topic: $topic');
      return Right(unit);
    } catch (exception, strackTrace) {
      await crashLog.capture(exception: exception, stackTrace: strackTrace);
      debugPrint('Error to subscribe to topic: $topic');
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> unsubscribeFromTopic({
    required String topic,
  }) async {
    try {
      await instance.unsubscribeFromTopic(topic);
      debugPrint('Unsubscribed from topic: $topic');
      return Right(unit);
    } catch (exception, strackTrace) {
      await crashLog.capture(exception: exception, stackTrace: strackTrace);
      debugPrint('Error to unsubscribe to topic: $topic');
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> saveToken({
    required String userId,
    String collection = 'users',
  }) async {
    final response = await storageDriver.docGet(
      collection: collection,
      doc: userId,
    );
    final token = await getToken();
    return token.fold((l) => Left(l), (token) async {
      return response.fold(
        (l) async {
          final response = await storageDriver.docSet(
            collection: collection,
            id: userId,
            data: {
              'deviceTokens': [token],
            },
          );
          return response;
        },
        (r) async {
          try {
            final deviceTokens = List.from(
              ((r.data()?['deviceTokens'] as List?) ?? []),
              growable: true,
            );
            if (!deviceTokens.contains(token)) {
              final response = await storageDriver.docSet(
                collection: collection,
                id: userId,
                data: {'deviceTokens': deviceTokens..add(token)},
              );
              return response;
            }
            return Right(unit);
          } catch (e, s) {
            debugPrint('FirebaseNotificationsDriver.saveToken: $e');
            await crashLog.capture(exception: e, stackTrace: s);
            return Left(Exception('$e'));
          }
        },
      );
    });
  }
}
