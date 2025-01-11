import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:io';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(
    String id, String title, String body, DateTime scheduledDate) async {
  final notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'task_channel',
      'Task Notifications',
      channelDescription: 'Notifications for task reminders',
      importance: Importance.max,
      priority: Priority.high,
    ),
  );

  await _flutterLocalNotificationsPlugin.zonedSchedule(
    id.hashCode,
    title,
    body,
    tz.TZDateTime.from(scheduledDate, tz.local),
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exact, // Вказуємо точний режим
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

  static Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  static Future<bool> requestExactAlarmPermission() async {
    if (Platform.isAndroid && await isAndroid12OrAbove()) {
      final status = await Permission.scheduleExactAlarm.request();
      return status.isGranted;
    }
    return true;
  }

  static Future<bool> isAndroid12OrAbove() async {
    return Platform.isAndroid && int.parse(await _getAndroidSdkVersion()) >= 31;
  }

  static Future<bool> isAndroid13OrAbove() async {
    return Platform.isAndroid && int.parse(await _getAndroidSdkVersion()) >= 33;
  }

  static Future<String> _getAndroidSdkVersion() async {
    if (!Platform.isAndroid) {
      return '0';
    }
    try {
      return Platform.environment['SDK_VERSION'] ?? '0';
    } catch (e) {
      return '0'; // Default to 0 if SDK_VERSION isn't available
    }
  }
}
