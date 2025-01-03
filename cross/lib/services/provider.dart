import 'package:flutter/material.dart';
import 'package:to_bee/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  // Add Task
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  // Delete Task
  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  // Toggle Task Completion and Delete after completion
  void toggleTaskCompletionAndDelete(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();

    // If task is completed, delete it from the list
    if (_tasks[index].isCompleted) {
      Future.delayed(Duration(milliseconds: 500), () {
        deleteTask(index); // Automatically delete task after a short delay
      });
    }
  }
}
