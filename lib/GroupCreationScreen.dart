import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/ChatScreen.dart';
import 'package:my_flutter_app/SignInScreen.dart';
import 'auth_service.dart';

class GroupCreationScreen extends StatelessWidget {
  final List<String> predefinedGroups = ['Soccer', 'Basketball', 'Hockey'];
  final AuthService _authService = AuthService();

  void _createGroup(BuildContext context, String groupName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(groupName: groupName),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    await _authService.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _groupController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create or Join a Group'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Select a predefined group:'),
            ...predefinedGroups.map((group) => ListTile(
              title: Text(group),
              onTap: () => _createGroup(context, group),
            )),
            Divider(),
            Text('Or create your own group:'),
            TextField(
              controller: _groupController,
              decoration: InputDecoration(labelText: 'Group Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_groupController.text.isNotEmpty) {
                  _createGroup(context, _groupController.text.trim());
                }
              },
              child: Text('Create Group'),
            ),
          ],
        ),
      ),
    );
  }
}
