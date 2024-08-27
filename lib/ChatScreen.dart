


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/GroupCreationScreen.dart';
import 'auth_service.dart';

class ChatScreen extends StatefulWidget {
  final String groupName;

  ChatScreen({required this.groupName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  late AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    _authService.user.listen((user) {
      setState(() {
        _user = user;
      });
    });
  }

  String _extractFirstName(String email) {
    final parts = email.split('@');
    final namePart = parts[0]; // Extracts the part before '@'
    final nameParts = namePart.split('.');
    return nameParts.isNotEmpty ? nameParts.first.capitalize() : 'Unknown';
  }

  void _sendMessage() {
    if (_controller.text.isEmpty || _user == null) return;

    final firstName = _extractFirstName(_user!.email ?? '');

    final message = {
      'text': _controller.text,
      'createdAt': Timestamp.now(),
      'userId': _user!.uid,
      'userName': firstName,
    };

    FirebaseFirestore.instance.collection('chats/${widget.groupName}/messages').add(message);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat - ${widget.groupName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _authService.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => GroupCreationScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats/${widget.groupName}/messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final chatDocs = chatSnapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) {
                    final message = chatDocs[index];
                    final isCurrentUser = message['userId'] == _user!.uid;
                    final alignment = isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
                    final backgroundColor = isCurrentUser ? Colors.blueAccent : Colors.grey[300];
                    final textColor = isCurrentUser ? Colors.white : Colors.black;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          if (!isCurrentUser) ...[
                            CircleAvatar(child: Text(message['userName'][0])),
                            SizedBox(width: 8),
                          ],
                          Column(
                            crossAxisAlignment: alignment,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message['userName'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    Text(
                                      message['text'],
                                      style: TextStyle(color: textColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                (message['createdAt'] as Timestamp).toDate().toLocal().toString(),
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                          if (isCurrentUser) ...[
                            SizedBox(width: 8),
                            CircleAvatar(child: Text(message['userName'][0])),
                          ],
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Send a message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension StringCapitalization on String {
  String capitalize() {
    return this.isEmpty ? this : this[0].toUpperCase() + substring(1);
  }
}
