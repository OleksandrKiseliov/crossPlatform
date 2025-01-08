import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:to_bee/services/firebase_service.dart';
import 'package:to_bee/views/tasks2.dart';

class TaskListPage2 extends StatefulWidget {
  @override
  State<TaskListPage2> createState() => _TaskListPageState2();
}

List items = [];

class _TaskListPageState2 extends State<TaskListPage2> {
  List<Map<String, String?>> recommendedTasks = [];
  List<Map<String, String?>> dailyTasks = [];
  List<Map<String, String?>> allTasks = [];

  String sortOrder = 'Sort Asc';

  @override
  void initState() {
    super.initState();
    fetchAllTasks();
  }

  Future<void> fetchAllTasks() async {
    final tasks = await FirebaseService().getUserTasks();
    setState(() {
      allTasks = tasks.map((task) {
        return {
          'id': task['id'],
          'title': task['title'],
          'description': task['description'],
          'startDate': task['startDate'],
          'endDate': task['endDate'],
        };
      }).toList();

      filterTasks();
      sortTasks();
    });
  }

  void filterTasks() {
    DateTime today = DateTime.now();
    DateTime threeDaysLater = today.add(Duration(days: 3));

    // Filter daily tasks (start and end today)
    dailyTasks = allTasks.where((task) {
      DateTime startDate = DateTime.parse(task['startDate']!);
      DateTime endDate = DateTime.parse(task['endDate']!);
      return isSameDay(today, startDate) && isSameDay(today, endDate);
    }).toList();

    // Filter recommended tasks (end within the next 3 days but not daily)
    recommendedTasks = allTasks.where((task) {
      DateTime endDate = DateTime.parse(task['endDate']!);
      return endDate.isAfter(today) && endDate.isBefore(threeDaysLater) &&
          !dailyTasks.contains(task); // Exclude daily tasks
    }).toList();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  void sortTasks() {
    if (sortOrder == 'Sort Asc') {
      allTasks.sort((a, b) {
        DateTime startA = DateTime.parse(a['startDate']!);
        DateTime startB = DateTime.parse(b['startDate']!);
        return startA.compareTo(startB);
      });
    } else {
      allTasks.sort((a, b) {
        DateTime endA = DateTime.parse(a['endDate']!);
        DateTime endB = DateTime.parse(b['endDate']!);
        return endB.compareTo(endA);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFfFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 130,
              color: const Color(0xffFFD3B2),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 100),
                    Container(
                      width: 130.32,
                      height: 103.04,
                      child: Image.asset("lib/assets/images/Group305.png", fit: BoxFit.fill),
                    ),
                    const SizedBox(width: 28.5),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 39,
                        height: 39,
                        child: Image.asset("lib/assets/images/mdi_bell-notification.png"),
                      ),
                    ),
                    const SizedBox(width: 30)
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Daily tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            dailyTasks.isEmpty
                ? Center(child: Text('No daily tasks available', style: TextStyle(fontSize: 16, color: Colors.grey)))
                : Container(
              height: 150, // Adjust this height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dailyTasks.length,
                itemBuilder: (context, index) {
                  return _buildTaskCard(
                    dailyTasks[index]['title']!,
                    dailyTasks[index]['description']!,
                    dailyTasks[index]['id']!,
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Recommended tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            _buildTaskList(recommendedTasks),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('All tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<String>(
                    value: sortOrder,
                    items: [
                      DropdownMenuItem<String>(
                        value: 'Sort Asc',
                        child: Text('Sort Asc'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Sort Desc',
                        child: Text('Sort Desc'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        sortOrder = value!;
                        sortTasks();
                      });
                    },
                  ),
                ],
              ),
            ),
            _buildTaskList(allTasks),
            SizedBox(height: 80), // Increased space for bottom navigation bar
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTask()));
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.orange),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<Map<String, String?>> tasks) {
    return Container(
      height: 150,
      child: tasks.isEmpty
          ? Center(child: Text('No tasks available', style: TextStyle(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return _buildTaskCard(tasks[index]['title']!, tasks[index]['description']!, tasks[index]['id']!);
        },
      ),
    );
  }

  Widget _buildTaskCard(String title, String description, String taskId) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.orange),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(description),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle_outline),
                    onPressed: () async {
                      await _markTaskAsCompleted(taskId);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () async {
                      await _deleteTask(taskId);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteTask(String taskId) async {
    try {
      await FirebaseService().deleteTask(taskId, context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task deleted successfully")),
      );
      fetchAllTasks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting task: $e")),
      );
    }
  }

  Future<void> _markTaskAsCompleted(String taskId) async {
    try {
      await FirebaseService().markTaskAsCompleted(taskId, context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task marked as completed")),
      );
      fetchAllTasks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error marking task as completed: $e")),
      );
    }
  }

}
