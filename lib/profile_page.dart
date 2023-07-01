import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _subjectsController = TextEditingController();
  final TextEditingController _classesController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    // Retrieve user details from Firestore
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Retrieve user details from Firestore
      DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      // Update the text controllers with the user details
      setState(() {
        _emailController.text = userSnapshot['email'];
        _phoneNumberController.text = userSnapshot['phoneNumber'];
        _subjectsController.text = userSnapshot['subjects'];
        _classesController.text = userSnapshot['classes'];
        _schoolController.text = userSnapshot['school'];
      });
    }
  }

  Future<void> _saveUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Save the user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': _emailController.text,
        'phoneNumber': _phoneNumberController.text,
        'subjects': _subjectsController.text,
        'classes': _classesController.text,
        'school': _schoolController.text,
      });
    }

    setState(() {
      _isEditing = false;
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    // Navigate to the login screen or any other desired screen after logout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        title: Text('Profile'),
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Teachers Details',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Hey there!',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Email'),
                      subtitle: _isEditing
                          ? TextField(
                        controller: _emailController,
                        decoration: InputDecoration(hintText: 'Enter email'),
                      )
                          : Text(_emailController.text),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone Number'),
                      subtitle: _isEditing
                          ? TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(hintText: 'Enter phone number'),
                      )
                          : Text(_phoneNumberController.text),
                    ),
                    ListTile(
                      leading: Icon(Icons.subject),
                      title: Text('My Subjects'),
                      subtitle: _isEditing
                          ? TextField(
                        controller: _subjectsController,
                        decoration: InputDecoration(hintText: 'Enter subjects'),
                      )
                          : Text(_subjectsController.text),
                    ),
                    ListTile(
                      leading: Icon(Icons.class_),
                      title: Text('Classes'),
                      subtitle: _isEditing
                          ? TextField(
                        controller: _classesController,
                        decoration: InputDecoration(hintText: 'Enter classes'),
                      )
                          : Text(_classesController.text),
                    ),
                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text('My School'),
                      subtitle: _isEditing
                          ? TextField(
                        controller: _schoolController,
                        decoration: InputDecoration(hintText: 'Enter school'),
                      )
                          : Text(_schoolController.text),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: _isEditing
                          ? ElevatedButton(
                        onPressed: _saveUserDetails,
                        child: Text('Save'),
                      )
                          : Column(
                        children: [
                          Text(
                            'You can edit your details',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                _isEditing = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _logout,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
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
