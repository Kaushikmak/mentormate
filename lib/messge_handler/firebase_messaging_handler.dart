import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHandler {
  static final FirebaseMessagingHandler _instance = FirebaseMessagingHandler._internal();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Singleton pattern
  factory FirebaseMessagingHandler() {
    return _instance;
  }

  FirebaseMessagingHandler._internal();

  // Initialize the Firebase messaging services
  Future<void> initialize(BuildContext? context) async {
    // Request permission for iOS
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Enable FCM auto-initialization
    await _firebaseMessaging.setAutoInitEnabled(true);

    // Get FCM token for this device
    final fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $fcmToken");

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle when user taps on notification to open the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null && context != null) {
        _handleNotificationTap(message.data, context);
      }
    });

    // Handle when user taps on notification to open the app from background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (context != null) {
        _handleNotificationTap(message.data, context);
      }
    });
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print("Got a message whilst in the foreground!");
    print("Message data: ${message.data}");

    RemoteNotification? notification = message.notification;
    if (notification != null) {
      print("Message also contained a notification: ${notification.title}");
      // When the app is in the foreground, we won't show a notification
      // but you can still handle the message data here
    }
  }

  void _handleNotificationTap(Map<String, dynamic> data, BuildContext? context) {
    if (context == null) return;

    if (data['page'] != null) {
      final page = data['page'];
      if (page == 'user-profile') {
        Navigator.of(context).pushNamed('/user-profile');
      }
    }
  }
}

// Background message handler must be a top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  // You can process the message data here
}
