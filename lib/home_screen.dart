import 'package:flutter/material.dart';
import 'package:book_store/home_tab_page.dart';
import 'package:book_store/classes_tab_page.dart';
import 'package:book_store/reports_tab_page.dart';
import 'package:book_store/settings_tab_page.dart';
import 'package:book_store/profile_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTabPage(),
    ClassesTabPage(),
    ReportsTabPage(),
    SettingsTabPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: PopupMenuButton(
          icon: Icon(Icons.format_line_spacing_outlined),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('Coming Soon...'),
              value: 1,
            ),
            PopupMenuItem(
              child: Text('Coming Soon...'),
              value: 2,
            ),
            // Add more options as needed
          ],
          onSelected: (value) {
            // Handle option selection here
          },
        ),
        title: Text('Book Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.circle_notifications_outlined),
            onPressed: () {
              // Implement notification functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle_outlined),
            onPressed: () {
              // Navigate to profile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: 'Returns',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
