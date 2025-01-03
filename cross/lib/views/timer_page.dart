import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  final String taskTitle;
  final String taskDescription;

  TimerPage({required this.taskTitle, required this.taskDescription});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Duration duration = Duration(minutes: 25); // Default Pomodoro work duration
  late Timer timer;
  bool isRunning = false;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
  }

  // Start the timer
  void startTimer() {
    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (duration.inSeconds > 0) {
        setState(() {
          duration = duration - Duration(seconds: 1);
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

  // Pause the timer
  void pauseTimer() {
    setState(() {
      isRunning = false;
    });
    timer.cancel();
  }

  // Resume the timer
  void resumeTimer() {
    startTimer();
  }

  // Quit task
  void quitTask() {
    timer.cancel(); // Stop the timer
    Navigator.pop(context); // Navigate back to the previous screen
  }

  // Select Pomodoro duration (Work, Short Break, Long Break)
  void selectPomodoroDuration(String type) {
    setState(() {
      if (type == "Work") {
        duration = Duration(minutes: 25);
      } else if (type == "Short Break") {
        duration = Duration(minutes: 5);
      } else if (type == "Long Break") {
        duration = Duration(minutes: 15);
      }
    });
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel(); // Cancel timer when leaving the screen
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade100,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            if (timer.isActive) {
              timer.cancel(); // Stop the timer when going back
            }
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.taskTitle,
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.taskDescription,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              isCompleted ? "Completed!" : isRunning ? "In progress" : "Paused",
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: duration.inSeconds > 0
                      ? duration.inSeconds / (25 * 60) // Adjust progress based on Pomodoro time
                      : 0.0,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
                Text(
                  "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (!isRunning && !isCompleted) // Show Pomodoro options before timer starts
              Column(
                children: [
                  Text(
                    "Select Pomodoro Time:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Column( crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => selectPomodoroDuration("Work"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            child: Text(
                              "Work (25 min)",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => selectPomodoroDuration("Short Break"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade300,
                            ),
                            child: Text(
                              "Short Break (5 min)",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),])
                          ,ElevatedButton(
                            onPressed: () => selectPomodoroDuration("Long Break"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade400,
                            ),
                            child: Text(
                              "Long Break (15 min)",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],

                  ),
                ],
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
                  iconSize: 40,
                  color: Colors.orange,
                  onPressed: isRunning ? pauseTimer : startTimer,
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.stop),
                  iconSize: 40,
                  color: Colors.orange,
                  onPressed: quitTask,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
