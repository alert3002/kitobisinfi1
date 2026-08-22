import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import 'notices_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
  } catch (_) {}
}

class PushService {
  PushService._();
  static final instance = PushService._();

  bool ready = false;

  Future<void> init() async {
    if (kIsWeb) return;
    try {
      await Firebase.initializeApp();
    } catch (e) {
      debugPrint('Firebase init skipped: $e');
      return;
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(alert: true, badge: true, sound: true);
    if (Platform.isIOS) {
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    await messaging.subscribeToTopic('kitobho_all');
    await messaging.subscribeToTopic('kitobho_grade_$kGrade');

    FirebaseMessaging.onMessage.listen((message) {
      unawaited(NoticesService.instance.refresh());
      final title = message.notification?.title ?? message.data['title'];
      final body = message.notification?.body ?? message.data['body'];
      final ctx = kitobhoNavigatorKey.currentContext;
      if (ctx == null || !ctx.mounted || title == null) return;
      final text = body == null || body.toString().isEmpty
          ? title.toString()
          : '$title\n$body';
      ScaffoldMessenger.maybeOf(ctx)?.showSnackBar(
        SnackBar(content: Text(text)),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((_) {
      unawaited(NoticesService.instance.refresh());
    });

    ready = true;
  }
}

final kitobhoNavigatorKey = GlobalKey<NavigatorState>();
