import 'package:flutter/material.dart';

class SettingsTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      backgroundColor: Colors.grey[900], // Set the background color to dark grey
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text('Class Settings'),
                    ),
                    ListTile(
                      leading: Icon(Icons.book),
                      title: Text('Books Settings'),
                    ),
                    ListTile(
                      leading: Icon(Icons.inventory),
                      title: Text('Inventory'),
                    ),
                    ListTile(
                      leading: Icon(Icons.people),
                      title: Text('Teachers'),
                    ),
                    ListTile(
                      leading: Icon(Icons.done_all),
                      title: Text('Clearance'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.help),
                      title: Text('Help and Support'),
                    ),
                    ListTile(
                      leading: Icon(Icons.report_problem),
                      title: Text('Report a Problem'),
                    ),
                    ListTile(
                      leading: Icon(Icons.support),
                      title: Text('Creator Support'),
                    ),
                    ListTile(
                      leading: Icon(Icons.policy),
                      title: Text('Terms and Policies'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'By Emmanuel, UoEm',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.green, // Set the text color to white
                ),
              ),
              Text(
                'App Version: 1.0.0',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color to white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
