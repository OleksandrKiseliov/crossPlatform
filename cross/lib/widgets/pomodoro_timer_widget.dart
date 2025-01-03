/// The PomodoroTimerWidget shows the timer interface for managing work sessions and breaks,
/// including controls to start, pause, and reset the timer.


/*import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

class PomodoroTimerWidget extends StatefulWidget {
  @override
  _PomodoroTimerWidgetState createState() => _PomodoroTimerWidgetState();
}

class _PomodoroTimerWidgetState extends State<PomodoroTimerWidget> {
  Timer? _timer;
  int _start = 1500; // 25 minutes in seconds
  bool _isRunning = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  void initializeNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void onStartPause() {
    if (_isRunning) {
      // Pause the timer
      setState(() {
        _isPaused = true;
        _timer?.cancel();
      });
    } else {
      // Start or resume the timer
      setState(() {
        _isRunning = true;
        _isPaused = false;
        _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
          if (_start == 0) {
            timer.cancel();
            _isRunning = false;
            _showNotification();
          } else {
            setState(() {
              _start--;
            });
          }
        });
      });
    }
  }

  void _showNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    var androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',

      importance: Importance.max,
      priority: Priority.high,
    );
    var generalNotificationDetails = NotificationDetails(
      android: androidDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Pomodoro Timer',
      'Time’s up!',
      generalNotificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${(_start ~/ 60).toString().padLeft(2, '0')}:${(_start % 60).toString().padLeft(2, '0')}',
          style: TextStyle(fontSize: 48),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onStartPause,
          child: Text(_isRunning ? (_isPaused ? 'Resume' : 'Pause') : 'Start'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
*/