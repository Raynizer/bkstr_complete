import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClassesTabPage extends StatefulWidget {
  @override
  _ClassesTabPageState createState() => _ClassesTabPageState();
}

class _ClassesTabPageState extends State<ClassesTabPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  String _errorMessage = '';
  String _successMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey[800], // Dark grey background color
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Admission Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String admissionNumber = _searchController.text.trim();
                searchBooks(admissionNumber);
              },
              child: Text('Search'),
            ),
            SizedBox(height: 16.0),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            if (_successMessage.isNotEmpty)
              Text(
                _successMessage,
                style: TextStyle(color: Colors.green),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final book = _searchResults[index];
                  final studentName = book['studentName'];
                  final admissionNumber = book['admissionNumber'];
                  final bookNumber = book['bookNumber'];
                  final stream = book['stream'];
                  final subject = book['subject'];
                  final Form = book['class'];

                  return ListTile(
                    title: Text('Student Name: $studentName'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Admission Number: $admissionNumber'),
                        Text('Book Number: $bookNumber'),
                        Text('Class: $Form'),
                        Text('Stream: $stream'),
                        Text('Subject: $subject'),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        deleteBook(book['documentId']);
                      },
                      child: Text('Return'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchBooks(String admissionNumber) {
    _firestore
        .collection('books')
        .where('admissionNumber', isEqualTo: admissionNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        _errorMessage = '';
        _successMessage = '';
        _searchResults = querySnapshot.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          data['documentId'] = document.id;
          return data;
        }).toList();
        if (_searchResults.isEmpty) {
          _errorMessage = 'No books found for the given admission number.';
        }
      });
    }).catchError((error) {
      print('Error searching books: $error');
    });
  }

  void deleteBook(String documentId) {
    _firestore
        .collection('books')
        .doc(documentId)
        .delete()
        .then((value) {
      setState(() {
        _successMessage = 'Book returned successfully.';
      });
      print('Book deleted successfully');
    }).catchError((error) {
      print('Error deleting book: $error');
    });
  }
}
