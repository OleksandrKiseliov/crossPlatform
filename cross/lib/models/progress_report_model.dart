/// The ProgressReportModel is responsible for holding the data related to
/// the user's progress over a period of time (e.g., daily or weekly).
/// It tracks key productivity metrics such as:
/// - The number of tasks completed.
/// - The number of Pomodoro sessions finished.
/// - The total time spent on productive tasks.
/// - Rewards unlocked during a specific time frame.
/// This model is essential for generating daily and weekly progress reports
///  It gathers data from various parts of the app (e.g., task completion, Pomodoro timer)
/// and formats it into a report that can be visualized using charts or stats.



class ProgressReportModel {
  DateTime date;
  int tasksCompleted;
  int pomodoroSessions;

  ProgressReportModel({
    required this.date,
    required this.tasksCompleted,
    required this.pomodoroSessions,
  });
}
