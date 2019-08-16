import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

class Notifications {
  static final instance = Notifications._internal();

  Notifications._internal();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future init(Function(String) onSelectNotification) async {
    final initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {});
    final initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future scheduleNotification(
      int id, DateTime date, String title, String body, String payload) async {
    final androidPlatformChannelSpecifics =
        new AndroidNotificationDetails('Movies', 'movies', 'upcoming movies');
    final iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        id, title, body, date, platformChannelSpecifics,
        payload: payload);
  }

  Future cancelNotifications() async {
    return flutterLocalNotificationsPlugin.cancelAll();
  }
}
