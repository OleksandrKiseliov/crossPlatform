/// The TaskModel represents a to-do item in the app.
/// It contains information such as:
/// - Task title and description.
/// - Due date and priority level.
/// - Completion status (done or not).


class Task {
  String title;
  String description;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

