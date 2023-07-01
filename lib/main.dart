import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:book_store/sign_in_screen.dart';
import 'package:book_store/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BookStoreApp());
}

class BookStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/sign_in',
      routes: {
        '/sign_in': (context) => SignInScreen(),
        '/sign_up': (context) => SignUpScreen(),
      },
    );
  }
}
