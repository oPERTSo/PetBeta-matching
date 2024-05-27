import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pettakecare/view/profile/PetSitter_page.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  late User _user;
  XFile? _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _loadUserData();
  }

  void _loadUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await _firestore.collection('users').doc(_user.uid).get();
    setState(() {
      _nameController.text = userData.data()!['name'];
      _mobileController.text = userData.data()!['mobile'];
      _addressController.text = userData.data()!['address'];
    });
  }

  Future<void> _updateUserData() async {
    await _firestore.collection('users').doc(_user.uid).update({
      'name': _nameController.text,
      'mobile': _mobileController.text,
      'address': _addressController.text,
    });
  }

  Future<void> _updateProfilePicture() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
      // Upload image to Firebase Storage and update user data with image URL
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xffFC6011),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              // Navigate to login screen or any other screen
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _updateProfilePicture,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    _image != null ? FileImage(File(_image!.path)) : null,
                child: _image == null ? Icon(Icons.person, size: 50) : null,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _user.email != null
                  ? TextEditingController(text: _user.email)
                  : TextEditingController(),
              decoration: InputDecoration(labelText: 'Email'),
              readOnly: true, // Make email field read-only
            ),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(labelText: 'Mobile'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () async {
                  await _updateUserData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => PetSitterPage()),
                  );
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xffFC6011),
                )),
          ],
        ),
      ),
    );
  }
}
