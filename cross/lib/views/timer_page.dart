import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_bee/services/firebase_service.dart';
import 'package:to_bee/services/pomodoro_timer_service.dart'; // Для работы с Firestore

class TimerPage extends StatefulWidget {
  final String taskTitle;
  final String taskDescription;
  final String taskTime;
  final String taskId;

  TimerPage({
    required this.taskTitle,
    required this.taskDescription,
    required this.taskTime,
    required this.taskId,
  });

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Duration duration;
  Timer? timer;
  bool isRunning = false;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    duration = parseTaskTime(widget.taskTime);
  }

  Duration parseTaskTime(String taskTime) {
    final timeParts = taskTime.split(':');
    if (timeParts.length == 3) {
      return Duration(
        hours: int.parse(timeParts[0]),
        minutes: int.parse(timeParts[1]),
        seconds: int.parse(timeParts[2]),
      );
    }
    return const Duration(minutes: 25);
  }

  void startTimer() {
    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (duration.inSeconds > 0) {
        setState(() {
          duration = duration - const Duration(seconds: 1);
        });
      } else {
        setState(() {
          isRunning = false;
          isCompleted = true;
          timer.cancel();
        });
      }
    });
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
    });
    timer?.cancel();
  }

  void selectDuration(Duration newDuration) {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    setState(() {
      duration = newDuration;
      isRunning = false;
      isCompleted = false;
    });
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await PomodoroTimerService().deleteTask(taskId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task deleted successfully")),
      );
      Navigator.pop(context); // Закрываем экран после успешного удаления
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting task: $e")),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            timer?.cancel();
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.taskTitle,
          style: const TextStyle(color: Colors.orange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.taskDescription,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              isCompleted
                  ? "Completed!"
                  : isRunning
                  ? "In progress"
                  : "Paused",
              style: const TextStyle(fontSize: 20, color: Colors.orange),
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              value: duration.inSeconds > 0
                  ? duration.inSeconds /
                  parseTaskTime(widget.taskTime).inSeconds
                  : 0.0,
              strokeWidth: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            const SizedBox(height: 20),
            Text(
              "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (!isRunning && !isCompleted)
              Column(
                children: [
                  Text(
                    "Choose time:",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            selectDuration(parseTaskTime(widget.taskTime)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: Text(widget.taskTitle),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            selectDuration(const Duration(minutes: 5)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text("5 min break"),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            selectDuration(const Duration(minutes: 15)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text("15 min break"),
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
                  iconSize: 40,
                  color: Colors.orange,
                  onPressed: isRunning ? pauseTimer : startTimer,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.stop),
                  iconSize: 40,
                  color: Colors.orange,
                  onPressed: () {
                    timer?.cancel();
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.delete),
                  iconSize: 40,
                  color: Colors.red,
                  onPressed: () {
                    if (isRunning) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Pause the timer before deleting")),
                      );
                    } else {
                      deleteTask(widget.taskId);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
