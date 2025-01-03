/// The RecommendationModel represents AI-generated productivity recommendations
/// tailored to the user's behavior and task history.
/// It stores information such as:
/// - Suggested tasks or actions to improve productivity.
/// - Tips for better time management or focus.
/// - Recommended task priorities based on user progress.
/// This model helps in delivering personalized suggestions to users, enhancing
/// their productivity and helping them make better decisions regarding their tasks.



class RecommendationModel {
  String recommendationText;
  DateTime recommendedTime;

  RecommendationModel({
    required this.recommendationText,
    required this.recommendedTime,
  });
}
