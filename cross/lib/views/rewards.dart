import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class RewardsPage extends StatefulWidget {
  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  FirebaseService _firebaseService = FirebaseService();
  int totalPoints = 0;
  List<Map<String, String>> completedTasks = [];

  @override
  void initState() {
    super.initState();
    _fetchCompletedTasks();
  }

  Future<void> _fetchCompletedTasks() async {
    List<Map<String, String>> tasks = await _firebaseService.getCompletedTasks();
    setState(() {
      completedTasks = tasks;
      totalPoints = tasks.length * 100;
    });
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
        title: Text('Rewards'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section for total points
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Points Collected',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // XP Icon or Image
                  Icon(Icons.star, color: Colors.orange, size: 40),
                  SizedBox(width: 20),
                  Text(
                    '$totalPoints',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // History section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: completedTasks.map((task) {
                  return RewardHistoryItem(
                    points: 100,
                    description: task['title']!,
                    isNegative: false,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new functionality
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class RewardHistoryItem extends StatelessWidget {
  final int points;
  final String description;
  final bool isNegative;

  RewardHistoryItem({
    required this.points,
    required this.description,
    this.isNegative = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: Text(
          '${isNegative ? '-' : '+'}$points',
          style: TextStyle(
            color: isNegative ? Colors.red : Colors.green,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text(description),
      ),
    );
  }
}
