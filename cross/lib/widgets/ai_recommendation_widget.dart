/// The AIRecommendationWidget displays personalized productivity tips and task suggestions
/// provided by the AI, helping users to optimize their productivity.



import 'package:flutter/material.dart';
import 'package:to_bee/models/recommendation_model.dart';

class AIRecommendationDisplay extends StatelessWidget {
  final RecommendationModel recommendation;

  AIRecommendationDisplay({required this.recommendation});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'AI Recommendation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(recommendation.recommendationText),
            SizedBox(height: 10),
            Text(
              'Recommended Time: ${recommendation.recommendedTime}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
