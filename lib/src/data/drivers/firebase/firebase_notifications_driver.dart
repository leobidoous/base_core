import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/crash_log.dart';
import '../../../domain/entities/received_notifications_entity.dart';
import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_notifications_driver.dart';
import '../../../infra/drivers/firebase/i_firebase_storage_driver.dart';
import '../../../infra/models/received_notifications_model.dart';

class FirebaseNotificationsDriver extends IFirebaseNotificationsDriver {
  FirebaseNotificationsDriver({
    required this.crashLog,
    required this.storageDriver,
  });

  final CrashLog crashLog;
  final IFirebaseStorageDriver storageDriver;

  /// Estáticos: o driver é instanciado várias vezes, mas o registro no FCM é
  /// único por app. `onRegistered` é broadcast, então quem não estiver
  /// escutando quando o evento sair o perde.
  static String? _installationId;
  static Completer<String>? _registration;
  static bool _listeningRegistration = false;

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
      // `getToken` foi depreciado em favor de `register`/`onRegistered`, que
      // retornam o FID (outro identificador). Mantido enquanto o backend
      // envia push por token e para SDKs que exigem o token FCM.
      // ignore: deprecated_member_use
      final token = await instance.getToken();
      if (token == null) return Left(Exception('Token está vazio'));
      return Right(token);
    } catch (exception, strackTrace) {
      await crashLog.capture(exception: exception, stackTrace: strackTrace);
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, String>> getInstallationId({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      final cached = _installationId;
      if (cached != null) return Right(cached);

      _listenRegistration();
      final registration = _registration ??= _register();
      return Right(await registration.future.timeout(timeout));
    } on TimeoutException catch (exception) {
      // Libera uma nova tentativa na próxima chamada
      _registration = null;
      return Left(exception);
    } catch (exception, strackTrace) {
      _registration = null;
      await crashLog.capture(exception: exception, stackTrace: strackTrace);
      return Left(Exception(exception));
    }
  }

  Completer<String> _register() {
    final completer = Completer<String>();
    instance.register().catchError((Object exception, StackTrace stackTrace) {
      if (!completer.isCompleted) {
        completer.completeError(exception, stackTrace);
      }
    });
    return completer;
  }

  void _listenRegistration() {
    if (_listeningRegistration) return;
    _listeningRegistration = true;

    instance.onRegistered.listen((fid) {
      _installationId = fid;
      final registration = _registration;
      if (registration != null && !registration.isCompleted) {
        registration.complete(fid);
      }
    });
    instance.onUnregistered.listen((fid) {
      if (_installationId == fid) _installationId = null;
      _registration = null;
    });
  }

  @override
  Future<Either<Exception, Unit>> configure({
    bool setForegroundMessageAlert = true,
    Function(ReceivedNotificationEntity message)? onMessage,
    Function(ReceivedNotificationEntity message)? onMessageOpenedApp,
  }) async {
    try {
      // Define as opções de apresentação para notificações da Apple
      // quando recebidas em primeiro plano.
      await instance.setForegroundNotificationPresentationOptions(
        alert: setForegroundMessageAlert,
        badge: true,
        sound: true,
      );

      // Registra cedo para o FID já estar em cache nas primeiras requisições
      unawaited(getInstallationId());

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        final notification = ReceivedNotificationModel(
          android: _mapAndroidNotification(message.notification?.android),
          apple: _mapAppleNotification(message.notification?.apple),
          id: message.messageId?.hashCode ?? message.hashCode,
          contentAvailable: message.contentAvailable,
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
          mutableContent: message.mutableContent,
          collapseKey: message.collapseKey,
          messageType: message.messageType,
          messageId: message.messageId,
          category: message.category,
          senderId: message.senderId,
          sentTime: message.sentTime,
          threadId: message.threadId,
          payload: message.data,
          from: message.from,
          ttl: message.ttl,
        );

        if (onMessage != null) onMessage(notification);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        final notification = ReceivedNotificationModel(
          android: _mapAndroidNotification(message.notification?.android),
          apple: _mapAppleNotification(message.notification?.apple),
          id: message.messageId?.hashCode ?? message.hashCode,
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
          payload: message.data,
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
  Future<Either<Exception, ReceivedNotificationEntity?>>
  getInitialNotification() async {
    try {
      final initialMessage = await instance.getInitialMessage();
      if (initialMessage == null) return Right(null);

      final notification = ReceivedNotificationModel(
        android: _mapAndroidNotification(initialMessage.notification?.android),
        id: initialMessage.messageId?.hashCode ?? initialMessage.hashCode,
        apple: _mapAppleNotification(initialMessage.notification?.apple),
        title: initialMessage.notification?.title ?? '',
        body: initialMessage.notification?.body ?? '',
        payload: initialMessage.data,
      );
      return Right(notification);
    } catch (exception, strackTrace) {
      await crashLog.capture(exception: exception, stackTrace: strackTrace);
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
    // Transição token -> FID: grava os dois; FID é opcional por enquanto
    final fid = (await getInstallationId()).fold((l) => null, (r) => r);
    return token.fold((l) => Left(l), (token) async {
      return response.fold(
        (l) async {
          final response = await storageDriver.docSet(
            collection: collection,
            id: userId,
            data: {
              'deviceTokens': [token],
              'deviceFids': [?fid],
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
            final deviceFids = List.from(
              ((r.data()?['deviceFids'] as List?) ?? []),
              growable: true,
            );
            final hasNewToken = !deviceTokens.contains(token);
            final hasNewFid = fid != null && !deviceFids.contains(fid);
            if (hasNewToken || hasNewFid) {
              final response = await storageDriver.docSet(
                collection: collection,
                id: userId,
                data: {
                  'deviceTokens': [...deviceTokens, if (hasNewToken) token],
                  'deviceFids': [...deviceFids, if (hasNewFid) fid],
                },
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

  AndroidNotificationData? _mapAndroidNotification(
    AndroidNotification? android,
  ) {
    if (android == null) return null;
    return AndroidNotificationData(
      tag: android.tag,
      link: android.link,
      color: android.color,
      count: android.count,
      sound: android.sound,
      ticker: android.ticker,
      imageUrl: android.imageUrl,
      channelId: android.channelId,
      smallIcon: android.smallIcon,
      clickAction: android.clickAction,
    );
  }

  AppleNotificationData? _mapAppleNotification(AppleNotification? apple) {
    if (apple == null) return null;
    return AppleNotificationData(
      badge: apple.badge,
      imageUrl: apple.imageUrl,
      subtitle: apple.subtitle,
      soundName: apple.sound?.name,
      subtitleLocKey: apple.subtitleLocKey,
      soundVolume: apple.sound?.volume ?? 0,
      subtitleLocArgs: apple.subtitleLocArgs,
      soundCritical: apple.sound?.critical ?? false,
    );
  }
}
