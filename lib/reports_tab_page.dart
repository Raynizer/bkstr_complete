import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsTabPage extends StatefulWidget {
  @override
  _ReportsTabPageState createState() => _ReportsTabPageState();
}

class _ReportsTabPageState extends State<ReportsTabPage> {
  bool _showIssuedBooks = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      backgroundColor: Colors.grey[900], // Set dark grey background color
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showIssuedBooks = true;
                  });
                },
                child: Text('Issued Books'),
                style: ElevatedButton.styleFrom(
                  primary: _showIssuedBooks ? Colors.blue : Colors.grey,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showIssuedBooks = false;
                  });
                },
                child: Text('Returned Books'),
                style: ElevatedButton.styleFrom(
                  primary: _showIssuedBooks ? Colors.grey : Colors.blue,
                ),
              ),
            ],
          ),
          Expanded(
            child: _showIssuedBooks ? _buildIssuedBooksList() : _buildReturnedBooksList(),
          ),
          ElevatedButton(
            onPressed: () {
              // Perform action when download button is pressed
              // Implement your download logic here
            },
            child: Text('Download Document'),
          ),
        ],
      ),
    );
  }

  Widget _buildIssuedBooksList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('books').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final books = snapshot.data!.docs;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              final studentName = book['studentName'];
              final admissionNumber = book['admissionNumber'];
              final bookNumber = book['bookNumber'];
              final bookClass = book['class'];
              final stream = book['stream'];
              final subject = book['subject'];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    'Student Name: $studentName',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admission Number: $admissionNumber',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Book Number: $bookNumber',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Class: $bookClass',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Stream: $stream',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Subject: $subject',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildReturnedBooksList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('bookreturned').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final books = snapshot.data!.docs;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              final studentName = book['studentName'];
              final admissionNumber = book['admissionNumber'];
              final bookReturned = book['bookReturned'];
              final returnDate = book['returnDate'];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    'Student Name: $studentName',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admission Number: $admissionNumber',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Book Returned: $bookReturned',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Return Date: $returnDate',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
