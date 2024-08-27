// SplashScreen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_flutter_app/SignInScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _navigateToSignInScreen(context);

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          'Chat App',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _navigateToSignInScreen(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    });
  }
}
