import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  String? _selectedClass;
  String? _selectedStream;
  String? _selectedSubject;
  DateTime? _selectedIssueDate;
  DateTime? _selectedReturnDate;
  TextEditingController _studentNameController = TextEditingController();
  TextEditingController _admissionNumberController = TextEditingController();
  TextEditingController _bookNumberController = TextEditingController();
  String _issueBookErrorMessage = '';
  String _issueBookSuccessMessage = '';

  // Search
  String _searchAdmissionNumber = '';

  void _issueBook() {
    // Check if all required fields are filled
    if (_studentNameController.text.isEmpty ||
        _admissionNumberController.text.isEmpty ||
        _selectedClass == null ||
        _selectedStream == null ||
        _selectedSubject == null ||
        _bookNumberController.text.isEmpty ||
        _selectedIssueDate == null ||
        _selectedReturnDate == null) {
      setState(() {
        _issueBookErrorMessage = 'Please fill in all fields';
        _issueBookSuccessMessage = '';
      });
      return;
    }

    // Create a new document in the "books" collection
    FirebaseFirestore.instance.collection('books').add({
      'studentName': _studentNameController.text,
      'admissionNumber': _admissionNumberController.text,
      'class': _selectedClass,
      'stream': _selectedStream,
      'subject': _selectedSubject,
      'bookNumber': _bookNumberController.text,
      'issueDate': _selectedIssueDate,
      'returnDate': _selectedReturnDate,
    }).then((value) {
      setState(() {
        _studentNameController.clear();
        _admissionNumberController.clear();
        _selectedClass = null;
        _selectedStream = null;
        _selectedSubject = null;
        _bookNumberController.clear();
        _selectedIssueDate = null;
        _selectedReturnDate = null;
        _issueBookErrorMessage = '';
        _issueBookSuccessMessage = 'Book issued successfully';
      });
    }).catchError((error) {
      setState(() {
        _issueBookErrorMessage = 'Failed to issue book. Please try again later.';
        _issueBookSuccessMessage = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.grey[900], // Dark grey background
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchAdmissionNumber = value;
            });
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search by Admission Number Coming Soon...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
        ),
      ),*/
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.grey[800], // Dark grey background
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search bar and other content
              // ...

              SizedBox(height: 16.0),

              // Container for issuing books
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Issue Book',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _studentNameController,
                      decoration: InputDecoration(
                        labelText: 'Student Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _admissionNumberController,
                      decoration: InputDecoration(
                        labelText: 'Admission Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: _selectedClass,
                      hint: Text('Select Class'),
                      items: ['Form 1', 'Form 2', 'Form 3', 'Form 4']
                          .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedClass = value;
                        });
                      },
                    ),
                    SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: _selectedStream,
                      hint: Text('Select Stream'),
                      items: ['Null','East', 'West']
                          .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStream = value;
                        });
                      },
                    ),
                    SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: _selectedSubject,
                      hint: Text('Select Subject'),
                      items: ['Maths', 'English', 'Kiswahili','Physics', 'Chemistry', 'Biology','History', 'CRE', 'Geography','Agriculture', 'Business Studies']
                          .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSubject = value;
                        });
                      },
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _bookNumberController,
                      decoration: InputDecoration(
                        labelText: 'Book Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text('Issue Date: ${_selectedIssueDate?.toString() ?? ''}'),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2030),
                        ).then((date) {
                          setState(() {
                            _selectedIssueDate = date;
                          });
                        });
                      },
                      child: Text('Select Issue Date'),
                    ),
                    SizedBox(height: 8.0),
                    Text('Return Date: ${_selectedReturnDate?.toString() ?? ''}'),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        ).then((date) {
                          setState(() {
                            _selectedReturnDate = date;
                          });
                        });
                      },
                      child: Text('Select Return Date'),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _issueBook,
                      child: Text('Issue Book'),
                    ),
                    SizedBox(height: 8.0),
                    if (_issueBookErrorMessage.isNotEmpty)
                      Text(
                        _issueBookErrorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    if (_issueBookSuccessMessage.isNotEmpty)
                      Text(
                        _issueBookSuccessMessage,
                        style: TextStyle(color: Colors.green),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
