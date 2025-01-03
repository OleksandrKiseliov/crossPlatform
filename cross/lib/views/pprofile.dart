import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _currentUser;
  String? _status;
  String? _name;
  String? _profilePicUrl;
  File? _selectedImage;
  List<String> _activityHistory = [];

  bool _isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (_currentUser == null) return;

    try {
      final docSnapshot = await _firestore.collection('users').doc(_currentUser!.uid).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        setState(() {
          _status = data?['status'] ?? '';
          _name = data?['name'] ?? '';
          _profilePicUrl = data?['profilePicUrl'];
          _activityHistory = List<String>.from(data?['activityHistory'] ?? []);
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _updateStatus() async {
    if (_currentUser == null) return;

    try {
      final newStatus = _statusController.text.trim();
      await _firestore.collection('users').doc(_currentUser!.uid).update({
        'status': newStatus,
        'activityHistory': FieldValue.arrayUnion(['Updated status to "$newStatus" at ${DateTime.now()}']),
      });
      setState(() {
        _status = newStatus;
        _activityHistory.add('Updated status to "$newStatus" at ${DateTime.now()}');
      });
      _statusController.clear();
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  Future<void> _changePassword() async {
    try {
      final newPassword = _newPasswordController.text.trim();
      if (newPassword.isEmpty) {
        print('Password is empty');
        return;
      }
      await _auth.currentUser?.updatePassword(newPassword);
      _newPasswordController.clear();
      print('Password updated successfully');
    } catch (e) {
      print('Error changing password: $e');
    }
  }

  Future<void> _updateProfile() async {
    if (_currentUser == null) return;

    try {
      String? imageUrl = _profilePicUrl;

      if (_selectedImage != null) {
        // Upload image to Firebase Storage
        final fileName = '${_currentUser!.uid}_${DateTime.now().millisecondsSinceEpoch}';
        final ref = FirebaseStorage.instance.ref().child('profilePics/$fileName');

        await ref.putFile(_selectedImage!);
        imageUrl = await ref.getDownloadURL();
      }

      await _firestore.collection('users').doc(_currentUser!.uid).update({
        'name': _nameController.text.trim(),
        'profilePicUrl': imageUrl ?? '',
      });

      setState(() {
        _name = _nameController.text.trim();
        _profilePicUrl = imageUrl;
        _selectedImage = null;
      });

      print('Profile updated successfully');
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkTheme ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(_isDarkTheme ? Icons.dark_mode : Icons.light_mode),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : (_profilePicUrl != null
                          ? NetworkImage(_profilePicUrl!)
                          : const AssetImage('assets/placeholder.png')) as ImageProvider,
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.edit, color: Colors.orange),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Name:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
            TextField(
              controller: _nameController..text = _name ?? '',
              decoration: const InputDecoration(
                labelText: 'Edit your name',
                labelStyle: TextStyle(color: Colors.orange),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              onPressed: _updateProfile,
              child: const Text('Update Profile'),
            ),
            const SizedBox(height: 20),
            const Text('Status:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
            Text(_status ?? 'No status set', style: TextStyle(color: _isDarkTheme ? Colors.white : Colors.black)),
            TextField(
              controller: _statusController,
              decoration: const InputDecoration(
                labelText: 'Update your status',
                labelStyle: TextStyle(color: Colors.orange),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              onPressed: _updateStatus,
              child: const Text('Update Status'),
            ),
            const SizedBox(height: 20),
            const Text('Activity History:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
            Expanded(
              child: ListView.builder(
                itemCount: _activityHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _activityHistory[index],
                      style: TextStyle(color: _isDarkTheme ? Colors.white : Colors.black),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Change Password:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: Colors.orange),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              onPressed: _changePassword,
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
