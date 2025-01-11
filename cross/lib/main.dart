import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_bee/services/provider.dart';
import 'package:to_bee/views/home.dart';
import 'package:to_bee/views/home2.dart';
import 'package:to_bee/views/home_page.dart';
import 'package:to_bee/views/on_boarding.dart'; // Updated comment
import 'package:to_bee/views/pomodoro_timer.dart';
import 'package:to_bee/views/pomodoro_timer_poage.dart';
import 'package:to_bee/views/pprofile.dart';
import 'package:to_bee/views/tasks.dart';
import 'package:to_bee/views/tasks2.dart';
import 'package:to_bee/views/login_screen.dart' as login_view;
import 'package:to_bee/views/sign_up.dart' as signup_view;

import 'package:to_bee/services/notification_service.dart'; // Import NotificationService
import 'dart:io'; // For platform checks

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize NotificationService
  final notificationService = NotificationService();
  await notificationService.initializeNotifications();

  // Request permissions for notifications
  await requestNotificationPermissions();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TaskProvider()),
    ],
    child: const MyApp(),
  ));
}

Future<void> requestNotificationPermissions() async {
  if (Platform.isAndroid) {
    if (await NotificationService.isAndroid13OrAbove()) {
      // Request POST_NOTIFICATIONS for Android 13+
      final status = await NotificationService.requestNotificationPermission();
      if (!status) {
        print('Notification permission denied');
      }
    }

    // Request SCHEDULE_EXACT_ALARM for Android 12+
    if (await NotificationService.isAndroid12OrAbove()) {
      final exactAlarmGranted =
          await NotificationService.requestExactAlarmPermission();
      if (!exactAlarmGranted) {
        print('Exact alarm permission denied');
      }
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoarding(),
        '/sign_in': (context) => const login_view.Login(),
        '/sign_up': (context) => const signup_view.SignUp(),
        '/home': (context) => MyHomePage(),
        '/profile': (context) => const Profile(),
      },
    );
  }
}
