import 'package:flutter/material.dart';
import 'package:to_bee/views/timer_page.dart';


class PomodoroTimerPage extends StatelessWidget {
  // Simulated tasks, these will come from API in the future
  final List<Map<String, String>> tasks = [
    {
      'title': 'go to the gym',
      'description': 'must do cardio exercises to lose weight',
      'time': '00:42:21'
    },
    {
      'title': 'أداء الفروض المنزلية',
      'description': 'أداء الواجب المدرسي لمادة الرياضيات مع مذاكرة لمدة ساعتين لاختبار اللغة العربية',
      'time': '00:42:21'
    },
    {
      'title': 'Wireframe login',
      'description': 'must finish login screen tobee app',
      'time': '00:42:21'
    },
    {
      'title': 'تعلم بعض من الألمانية',
      'description': 'حتى تتمكن من العمل بالخارج',
      'time': '00:42:21'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade100,
        title: Text('Pomodoro Timer', style: TextStyle(color: Colors.orange)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Timer section at the top
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '00:32:10',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('Project task'),
                    ],
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Task list
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimerPage(
                            taskTitle: task['title']!,
                            taskDescription: task['description']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: Icon(Icons.timer, color: Colors.orange),
                        title: Text(
                          task['title']!,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(task['description']!),
                        trailing: Text(task['time']!),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Index of the timer tab
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
