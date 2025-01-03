/// The TaskItemWidget displays individual tasks with their details, such as title, deadline,
/// and completion status, allowing users to view and interact with each task.


/*import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final Function onTaskToggle;

  TaskItemWidget({required this.task, required this.onTaskToggle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text('Priority: ${task.priority}, Deadline: ${task.deadline?.toLocal()}'),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) => onTaskToggle(task),
      ),
    );
  }
}*/
