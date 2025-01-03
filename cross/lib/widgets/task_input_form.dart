/// The TaskInputFormWidget allows users to enter and submit details for new tasks,
/// including fields for title, description, deadline, and priority.



import 'package:flutter/material.dart';

class TaskInputForm extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Function onSaveTask;

  TaskInputForm({required this.onSaveTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Task Title',
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
            ),
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: 1,
                  onChanged: (int? newValue) {},
                  items: [
                    DropdownMenuItem(value: 1, child: Text('Low Priority')),
                    DropdownMenuItem(value: 2, child: Text('Medium Priority')),
                    DropdownMenuItem(value: 3, child: Text('High Priority')),
                  ],
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Deadline',
                  ),
                  onTap: () {
                    // Show date picker here
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onSaveTask(titleController.text, descriptionController.text);
            },
            child: Text('Save Task'),
          ),
        ],
      ),
    );
  }
}
