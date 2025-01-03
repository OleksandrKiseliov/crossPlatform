import 'package:flutter/material.dart';

class RewardsPage extends StatelessWidget {
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
            // Points collected section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Point collected',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Swap reward logic
                  },
                  child: Text('Swap Now'),
                  style: ElevatedButton.styleFrom(

                  ),
                ),
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
                    '1150', // This would be fetched from a backend
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
                TextButton(
                  onPressed: () {
                    // See All history logic
                  },
                  child: Text('See All'),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  RewardHistoryItem(
                    points: -100,
                    description: 'Swap reward',
                    isNegative: true,
                  ),
                  RewardHistoryItem(
                    points: 100,
                    description: 'Reward from first login',
                  ),
                  RewardHistoryItem(
                    points: 120,
                    description: 'Reward from first login',
                  ),
                ],
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

