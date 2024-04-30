import 'dart:convert' show jsonEncode;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_notifications_driver.dart'
    show IFirebaseNotificationsDriver;
import '../../../infra/drivers/firebase/i_firebase_storage_driver.dart';
import '../../../infra/drivers/i_local_notifications_driver.dart';
import '../../../infra/models/received_notifications_model.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('onMessageOpenedApp: $message');
}

class FirebaseNotificationsDriver extends IFirebaseNotificationsDriver {
  FirebaseNotificationsDriver({
    required this.instance,
    required this.crashLog,
    required this.storageDriver,
    required this.localNotificationsDriver,
  });

  final CrashLog crashLog;
  final FirebaseMessaging instance;
  final IFirebaseStorageDriver storageDriver;
  final ILocalNotificationsDriver localNotificationsDriver;

  @override
  Future<Either<Exception, String>> getToken() async {
    try {
      final token = await instance.getToken();
      if (token == null) {
        return Left(Exception('Token está vazio'));
      }
      return Right(token);
    } catch (exception, strackTrace) {
      await crashLog.capture(exception: exception, stackTrace: strackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> configure() async {
    try {
      //Define as opções de apresentação para notificações da Apple
      //  quando recebidas em primeiro plano.
      instance.setForegroundNotificationPresentationOptions(
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

        await localNotificationsDriver.showNotification(
          notification: notification,
        );
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        final notification = ReceivedNotificationModel(
          id: message.messageId?.hashCode ?? message.hashCode,
          title: message.notification?.title ?? '',
          body: message.notification?.title ?? '',
          payload: jsonEncode(message.data),
        );

        debugPrint('onMessageOpenedApp: $notification');
      });

      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
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
      return Right(unit);
    } catch (exception, strackTrace) {
      await crashLog.capture(exception: exception, stackTrace: strackTrace);
      debugPrint('Error to unsubscribe to topic: $topic');
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> saveToken({required String userId}) async {
    try {
      final response = await storageDriver.docGet(
        collection: 'users',
        doc: userId,
      );
      final token = await getToken();
      return token.fold((l) => Left(l), (token) async {
        return response.fold((l) async {
          final response = await storageDriver.docSet(
            collection: 'users',
            id: userId,
            data: {
              'deviceTokens': [token],
            },
          );
          return response.fold((l) => Left(l), (r) => Right(unit));
        }, (r) async {
          final deviceTokens = List.from(
            ((r.data()?['deviceTokens'] as List?) ?? []),
            growable: true,
          );
          if (!deviceTokens.contains(token)) {
            final response = await storageDriver.docSet(
              collection: 'users/',
              id: userId,
              data: {'deviceTokens': deviceTokens..add(token)},
            );
            return response.fold((l) => Left(l), (r) => Right(unit));
          }
          return Right(unit);
        });
      });
    } catch (exception, strackTrace) {
      debugPrint('Error in saveToken');
      await crashLog.capture(exception: exception, stackTrace: strackTrace);
      return Left(
        Exception('FirebaseNotificationsDriver.saveToken: $exception'),
      );
    }
  }
}
