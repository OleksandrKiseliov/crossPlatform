import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? getCurrentUserId() {
    final User? user = _auth.currentUser;
    return user?.uid;
  }

  Future<List<Map<String, String>>> getUserTasks() async {
    try {
      List<Map<String, String>> tasks = [];

      final tasksSnapshot = await _firestore
          .collection('users')
          .doc(getCurrentUserId())
          .collection('task')
          .where('isCompleted', isEqualTo: false)
          .get();

      for (var doc in tasksSnapshot.docs) {
        var startTime = (doc['startDateTime'] as Timestamp).toDate();
        var endTime = (doc['endDateTime'] as Timestamp).toDate();

        String formattedStartDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(startTime);
        String formattedEndDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(endTime);

        tasks.add({
          'id': doc.id,
          'title': doc['title'],
          'description': doc['description'],
          'startDate': formattedStartDate,
          'endDate': formattedEndDate,
        });
      }

      return tasks;

    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  Future<void> markTaskAsCompleted(String taskId, BuildContext context) async {
    try {
      await _firestore
          .collection('users')
          .doc(getCurrentUserId())
          .collection('task')
          .doc(taskId)
          .update({'isCompleted': true});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task marked as completed")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error marking task as completed: $e")),
      );
    }
  }

  Future<void> deleteTask(String taskId, BuildContext context) async {
    try {
      await _firestore
          .collection('users')
          .doc(getCurrentUserId())
          .collection('task')
          .doc(taskId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task deleted successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting task: $e")),
      );
    }
  }

  Future<List<Map<String, String>>> getCompletedTasks() async {
    try {
      final userId = getCurrentUserId();
      if (userId != null) {
        final tasksSnapshot = await _firestore
            .collection('users')
            .doc(userId)
            .collection('task')
            .where('isCompleted', isEqualTo: true)
            .get();

        List<Map<String, String>> completedTasks = [];
        int points = 0;

        for (var doc in tasksSnapshot.docs) {
          completedTasks.add({
            'title': doc['title'],
            'description': doc['description'],
          });
          points += 100;
        }

        return completedTasks;
      } else {
        throw Exception('User not logged in');
      }
    } catch (e) {
      print('Error fetching completed tasks: $e');
      return [];
    }
  }
}
