import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_bee/models/task_model.dart';
import 'package:to_bee/views/home.dart';

import '../services/provider.dart';


class AddTaskPage extends StatefulWidget {
   // Callback for adding a task


  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedSubject;

  final List<String> _subjects = ['Math', 'Science', 'History', 'Art', 'Music'];

  // Function to show date picker
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to show time picker
  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
  final _formKey = GlobalKey<FormState>();
  String _taskTitle = '';
  String _taskDescription = '';
  bool _isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFD3B2),
        title: Text("add tasks",style: TextStyle(color: Color(0xff29221D),fontWeight:FontWeight.w600,fontSize: 24),),
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_outlined, color: Colors.orange,size: 40),
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
            // Back button functionality
          },
        ),
      ),
      body: Container(width:430,height:614,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),color: Color(0xffFFFFFF)),

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Title input
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',

                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // Description input
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 16),

                // Date picker
                ListTile(
                  leading: Icon(Icons.date_range),
                  title: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : DateFormat.yMMMd().format(_selectedDate!),
                  ),
                  onTap: _pickDate,
                ),
                SizedBox(height: 16),

                // Time picker
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text(
                    _selectedTime == null
                        ? 'Select Time'
                        : _selectedTime!.format(context),
                  ),
                  onTap: _pickTime,
                ),
                SizedBox(height: 16),

                // Subject dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    prefixIcon: Icon(Icons.book),
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedSubject,
                  items: _subjects
                      .map((subject) => DropdownMenuItem<String>(
                    child: Text(subject),
                    value: subject,
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSubject = value;
                    });
                  },

                ),
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Container(width: 100,height: 50,
                    child: TextButton(
                        onPressed: () {
                      if (_titleController.text.isNotEmpty &&
                          _descriptionController.text.isNotEmpty) {
                        Provider.of<TaskProvider>(context, listen: false).addTask(
                          Task(
                            title: _titleController.text,
                            description: _descriptionController.text,
                          ),
                        );
                        Navigator.pop(context); // Go back to the previous page
                      }
                    },child:Text("Add",style: TextStyle(color:Colors.orange,fontSize: 20),)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
     /* bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Navigate to home
              },
            ),
            IconButton(
              icon: Icon(Icons.timer),
              onPressed: () {
                // Navigate to timer
              },
            ),
            FloatingActionButton(
              onPressed: () {
                // Add new task
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.orange,
            ),
            IconButton(
              icon: Icon(Icons.card_giftcard),
              onPressed: () {
                // Navigate to rewards
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Navigate to profile
              },
            ),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.black,
      ),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
