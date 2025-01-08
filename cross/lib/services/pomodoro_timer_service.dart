import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PomodoroTimerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? getCurrentUserId() {
    final User? user = _auth.currentUser;
    return user?.uid;
  }

  Future<List<Map<String, dynamic>>> getUserTasks() async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw Exception('No user is currently signed in.');
      }

      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .get();

      return querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  Future<void> addTask(Map<String, dynamic> taskData) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw Exception('No user is currently signed in.');
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add(taskData);
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  Future<void> updateTask(String taskId, Map<String, dynamic> updatedData) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw Exception('No user is currently signed in.');
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .update(updatedData);
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      final String? userId = getCurrentUserId();
      if (userId == null) {
        throw Exception('No user is currently signed in.');
      }

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
