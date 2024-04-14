import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await initializeFlutterLocalNotificationsPlugin();
    setupFirebaseMessaging();
  }

  Future<void> initializeFlutterLocalNotificationsPlugin() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> setupFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground notification
      showNotification(message.notification);
    });
  }

  Future<void> showNotification(RemoteNotification? notification) async {
    if (notification != null) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'VidyaVibhava', // Change this to a unique ID for your app
        'VisitChannel', // Change // Change this to a custom channel description
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0, // Change this to a unique ID for each notification
        notification.title ?? '', // Title of the notification
        notification.body ?? '', // Body of the notification
        platformChannelSpecifics,
      );
    }
  }

  Future<void> selectNotification(String? payload) async {
    // Handle notification tap
  }
  Future<void> sendPushNotification(
      String fcmToken, String title, String body) async {
    try {
      String urlToParse = 'http://127.0.0.1:5000/sendNotification';
      print("URL Parse Start");
      final url = Uri.parse(urlToParse);
      print("URL parsed");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'body': body,
          'fcm_token': fcmToken,
        }),
      );
      print("HTTp Posted");
      if (response.statusCode == 200) {
        print('Notification Sent');
      } else {
        print('Failed to send notification. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
