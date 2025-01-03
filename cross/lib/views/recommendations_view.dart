import 'package:flutter/material.dart';

class RecommendedTasksPage extends StatelessWidget {
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
        title: Text('Recommended tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TaskCard(
              imageUrl: 'https://via.placeholder.com/300x150.png', // Replace with your image URL
              title: 'Wireframe login',
              description: 'must finish login screen tobee app #my task',
            ),
            TaskCard(
              imageUrl: 'https://via.placeholder.com/300x150.png', // Replace with your image URL
              title: 'Wireframe home page tobee',
              description: 'end home screen Car rent app thin start detail',
            ),
            TaskCard(
              imageUrl: 'https://via.placeholder.com/300x150.png', // Replace with your image URL
              title: 'Lorem ipsum dolor',
              description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add task functionality
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class TaskCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  TaskCard({required this.imageUrl, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
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
        ],
      ),
    );
  }
}

