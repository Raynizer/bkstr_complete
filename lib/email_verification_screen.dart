import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    user!.sendEmailVerification();
  }

  Future<void> checkEmailVerification() async {
    await user!.reload();
    if (user!.emailVerified) {
      // Email verification successful, navigate to home screen or any other screen
    } else {
      // Email verification unsuccessful, show error message or display a snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Email Verification',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'We have sent a verification link to ${user!.email}.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: checkEmailVerification,
              child: Text('Verify Email'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Already verified your email?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/sign_in');
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
