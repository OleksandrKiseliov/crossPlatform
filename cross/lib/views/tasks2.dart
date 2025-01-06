import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:to_bee/views/home.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedStartDate;
  TimeOfDay? _selectedStartTime;
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedEndTime;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _pickDate(bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _selectedStartDate = picked;
        } else {
          _selectedEndDate = picked;
        }
      });
    }
  }

  Future<void> _pickTime(bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = picked;
        } else {
          _selectedEndTime = picked;
        }
      });
    }
  }

  Future<void> _addTask() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }

    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();

    if (title.isEmpty || _selectedStartDate == null || _selectedStartTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    final DateTime now = DateTime.now();
    final String taskType =
        _selectedStartDate!.difference(DateTime(now.year, now.month, now.day)).inDays == 0
            ? 'daily'
            : 'recommended';

    final DateTime startDateTime = DateTime(
      _selectedStartDate!.year,
      _selectedStartDate!.month,
      _selectedStartDate!.day,
      _selectedStartTime!.hour,
      _selectedStartTime!.minute,
    );

    final DateTime? endDateTime = _selectedEndDate != null && _selectedEndTime != null
        ? DateTime(
            _selectedEndDate!.year,
            _selectedEndDate!.month,
            _selectedEndDate!.day,
            _selectedEndTime!.hour,
            _selectedEndTime!.minute,
          )
        : null;

    try {
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('task')
          .add({
        'title': title,
        'description': description,
        'startDateTime': startDateTime,
        'endDateTime': endDateTime,
        'type': taskType,
        'createdAt': DateTime.now(),
        'status': 'pending',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task added successfully")),
      );
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedStartDate = null;
        _selectedStartTime = null;
        _selectedEndDate = null;
        _selectedEndTime = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error adding task: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFD3B2),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFD3B2),
        title: const Text(
          "Add Task",
          style: TextStyle(color: Color(0xff29221D), fontWeight: FontWeight.w600, fontSize: 24),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined, color: Colors.orange, size: 40),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: Text(
                  _selectedStartDate == null
                      ? 'Start Date'
                      : DateFormat.yMMMd().format(_selectedStartDate!),
                ),
                onTap: () => _pickDate(true),
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(
                  _selectedStartTime == null
                      ? 'Start Time'
                      : _selectedStartTime!.format(context),
                ),
                onTap: () => _pickTime(true),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.date_range),
                title: Text(
                  _selectedEndDate == null
                      ? 'End Date'
                      : DateFormat.yMMMd().format(_selectedEndDate!),
                ),
                onTap: () => _pickDate(false),
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text(
                  _selectedEndTime == null
                      ? 'End Time'
                      : _selectedEndTime!.format(context),
                ),
                onTap: () => _pickTime(false),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Add Task",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
