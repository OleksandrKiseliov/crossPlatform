import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:to_bee/views/recommendations_view.dart';

class RecommendedTasksPageAI extends StatelessWidget {
  String token='CfDJ8GYzjPyrj9RJseswFZGYVpqTiff1PWfNOdLeQxw5qX8A9qhw_8Y_-YVfiVfWoZWJYugQXu5aR-iSuROdurT71q8AJwDD08u3mOnCbFAUGfkjBHEdNqLJ0hrIBMI9qH4-zZ2E5ACLGLlu1OD0KFzl_p6M2S8YMVI5P34DgkoSXFC55K2MdxDV7Rl0kO8uQoK4vkOVDYJOunUp-qPK_edzRZi8NnbrlPRgfVToBnNJWoVC1S3IHDyBUHDO1qjilDkCdKFesRVMP-D2EehkMks6W8VUzs43X_86KRjWkOwrZsWIBZBe5ZHRQQWERdrcrnGMdjosp8JAcjhv4nBSv_y_rD7_hJxamufZgMfseD4pEeWEjr1BDicngL92fjKzPXmMsjhFFRatJvItdv4WlMCK5za1ug5wW_EEwd6J2em3wcDEmHD7r42vdjFenBH05qgfjahKhA0Hvro0cWt7Q-9kQ9h6DkcE2tLiEvVqIe3NDEo2NNAV-kNPZwQdVsykarXnHMSvb0uAQChhAfu4wHemEJkJnVUBM-SwfVMs26YRYsdddBxb8Z_VhcNnONzA98sOYbcuh58NEhq_o-OijGIqvVt1CFrwwcIWq1BCcv_1AWgAwz7DAiHtbKZifAxn5VQAjHKX7bl-8DTrP2k_ZU2e5o0aXMjSS1Pdv4IOLBBIZILs';

  RecommendedTasksPageAI({required this.token});

  Future<List<Task>> fetchRecommendedTasks() async {
    final response = await http.get(
      Uri.parse('http://tobee.runasp.net/api/AIRecommendation/user/recommendations'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> recommendations = data['recommendations'];
      return recommendations.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Recommended Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Task>>(
          future: fetchRecommendedTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No recommended tasks found.'));
            }

            return ListView(
              children: snapshot.data!.map((task) {
                return TaskCard(
                  title: task.task,
                  description: 'Priority: ${task.recommendedPriority}, Completion Probability: ${task.completionProbability.toStringAsFixed(2)}%',
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder:(context) => RecommendedTasksPage(),));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class Task {
  final String task;
  final String recommendedPriority;
  final double completionProbability;

  Task({
    required this.task,
    required this.recommendedPriority,
    required this.completionProbability,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      task: json['task'],
      recommendedPriority: json['recommendedPriority'],
      completionProbability: json['completionProbability'],
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String description;

  TaskCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // End task functionality
                  },
                  child: Text('End Task'),
                  style: ElevatedButton.styleFrom(),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Show task details functionality
                  },
                  icon: Icon(Icons.visibility),
                  label: Text('Show'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
