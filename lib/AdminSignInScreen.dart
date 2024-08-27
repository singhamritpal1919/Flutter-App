// import 'package:flutter/material.dart';
// import 'package:my_flutter_app/AdminGroupManagementScreen.dart';
// import 'auth_service.dart';
//
// class AdminSignInScreen extends StatefulWidget {
//   @override
//   _AdminSignInScreenState createState() => _AdminSignInScreenState();
// }
//
// class _AdminSignInScreenState extends State<AdminSignInScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final AuthService _authService = AuthService();
//
//   void _adminSignIn() async {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty) {
//       return;
//     }
//
//     final user = await _authService.signInWithEmailAndPassword(email, password);
//     if (user != null) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => AdminGroupManagementScreen()),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Sign In'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Admin Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _adminSignIn,
//               child: Text('Sign In as Admin'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:my_flutter_app/AdminGroupManagementScreen.dart';
import 'auth_service.dart';

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // Define the admin email
  static const String adminEmail = 'gill97.amrit@gmail.com';

  void _adminSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Please enter both email and password.');
      return;
    }

    if (email != adminEmail) {
      _showError('You are not authorized to log in as admin.');
      return;
    }

    final user = await _authService.signInWithEmailAndPassword(email, password);
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AdminGroupManagementScreen()),
      );
    } else {
      _showError('Admin login failed. Please check your credentials.');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Admin Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adminSignIn,
              child: Text('Sign In as Admin'),
            ),
          ],
        ),
      ),
    );
  }
}

