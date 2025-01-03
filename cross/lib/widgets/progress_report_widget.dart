/// The ProgressReportWidget displays visual summaries of user productivity,
/// such as charts or graphs showing progress over time.



import 'package:flutter/material.dart';
import 'package:to_bee/models/progress_report_model.dart';

class ProgressReportWidget extends StatelessWidget {
  final ProgressReportModel report;

  ProgressReportWidget({required this.report});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Date: ${report.date.toLocal()}'),
      subtitle: Text('Tasks Completed: ${report.tasksCompleted}, Pomodoro Sessions: ${report.pomodoroSessions}'),
    );
  }
}
