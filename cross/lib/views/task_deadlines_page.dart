import 'package:flutter/material.dart';

class TaskDeadlinesPage extends StatefulWidget {
  @override
  _TaskDeadlinesPageState createState() => _TaskDeadlinesPageState();
}

class _TaskDeadlinesPageState extends State<TaskDeadlinesPage> {
  // Fake data representing tasks
  Map<int, List<Map<String, String>>> tasks = {
    20: [
      {'title': 'Wireframe login', 'description': 'must finish login screen tobee app #my task'},
      {'title': 'Wireframe home page', 'description': 'end home screen Car rent app thin start detail'}
    ],
    26: [
      {'title': 'Lorem ipsum dolor sit ...', 'description': 'Lorem ipsum dolor sit amet magna aliqua'},
      {'title': 'Lorem ipsum dolor sit ...', 'description': 'Lorem ipsum dolor sit amet magna aliqua'},
      {'title': 'Lorem ipsum dolor sit ...', 'description': 'Lorem ipsum dolor sit amet magna aliqua'}
    ],
    28: [
      {'title': 'Lorem ipsum dolor sit ...', 'description': 'Lorem ipsum dolor sit amet magna aliqua'}
    ]
  };

  // Selected date
  int selectedDate = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade100,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Task Deadlines',
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: Column(
        children: [
          // Calendar Selection
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "SEPTEMBER 2024",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildDateButton(19, "SUN"),
                    _buildDateButton(20, "MON"),
                    _buildDateButton(21, "TUE"),
                    _buildDateButton(22, "WED"),
                    _buildDateButton(23, "THU"),
                    _buildDateButton(24, "FRI"),
                    _buildDateButton(25, "SAT"),
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 2),
          // Task Schedule
          Expanded(
            child: ListView.builder(
              itemCount: tasks[selectedDate]?.length ?? 0,
              itemBuilder: (context, index) {
                var task = tasks[selectedDate]![index];
                return _buildTaskItem(task['title']!, task['description']!);
              },
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
    );
  }

  // Date selection buttons
  Widget _buildDateButton(int day, String dayOfWeek) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = day;
        });
      },
      child: Column(
        children: [
          Text(
            dayOfWeek,
            style: TextStyle(
              fontSize: 14,
              color: selectedDate == day ? Colors.orange : Colors.grey,
            ),
          ),
          SizedBox(height: 5),
          CircleAvatar(
            radius: 18,
            backgroundColor: selectedDate == day ? Colors.orange : Colors.grey.shade200,
            child: Text(
              '$day',
              style: TextStyle(
                fontSize: 16,
                color: selectedDate == day ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Task item builder
  Widget _buildTaskItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade200,
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(description),
          trailing: Checkbox(
            value: false,
            onChanged: (bool? value) {
              // Handle checkbox state
            },
          ),
        ),
      ),
    );
  }
}
