// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_flutter_app/ChatScreen.dart';
// import 'package:my_flutter_app/SignInScreen.dart';
// import 'auth_service.dart';
//
// class GroupCreationScreen extends StatelessWidget {
//   final List<String> predefinedGroups = ['Soccer', 'Basketball', 'Hockey'];
//   final AuthService _authService = AuthService();
//
//   void _createGroup(BuildContext context, String groupName) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => ChatScreen(groupName: groupName),
//       ),
//     );
//   }
//
//   Future<void> _signOut(BuildContext context) async {
//     await _authService.signOut();
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => SignInScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _groupController = TextEditingController();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create or Join a Group'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () => _signOut(context),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text('Select a predefined group:'),
//             ...predefinedGroups.map((group) => ListTile(
//               title: Text(group),
//               onTap: () => _createGroup(context, group),
//             )),
//             Divider(),
//             Text('Or create your own group:'),
//             TextField(
//               controller: _groupController,
//               decoration: InputDecoration(labelText: 'Group Name'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (_groupController.text.isNotEmpty) {
//                   _createGroup(context, _groupController.text.trim());
//                 }
//               },
//               child: Text('Create Group'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:my_flutter_app/ChatScreen.dart';
// import 'package:my_flutter_app/SignInScreen.dart';
// import 'auth_service.dart';
//
// class GroupCreationScreen extends StatelessWidget {
//   final AuthService _authService = AuthService();
//
//   void _createGroup(BuildContext context, String groupName) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => ChatScreen(groupName: groupName),
//       ),
//     );
//   }
//
//   Future<void> _signOut(BuildContext context) async {
//     await _authService.signOut();
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => SignInScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _groupController = TextEditingController();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Join a Group'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () => _signOut(context),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: StreamBuilder(
//                 stream: FirebaseFirestore.instance.collection('groups').snapshots(),
//                 builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   final groupDocs = snapshot.data!.docs;
//                   return ListView.builder(
//                     itemCount: groupDocs.length,
//                     itemBuilder: (ctx, index) {
//                       final group = groupDocs[index];
//                       return ListTile(
//                         title: Text(group['name']),
//                         onTap: () => _createGroup(context, group['name']),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:my_flutter_app/ChatScreen.dart';
// import 'package:my_flutter_app/SignInScreen.dart';
// import 'auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class GroupCreationScreen extends StatelessWidget {
//   final AuthService _authService = AuthService();
//
//   void _listenForApproval(
//       BuildContext context, String groupId, String groupName) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       FirebaseFirestore.instance
//           .collection('groups')
//           .doc(groupId)
//           .snapshots()
//           .listen((docSnapshot) {
//         if (docSnapshot.exists &&
//             docSnapshot.data()!['members'].contains(user.uid)) {
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//                 builder: (context) => ChatScreen(groupName: groupName)),
//           );
//         }
//       });
//     }
//   }
//
//   // void _requestToJoinGroup(
//   //     BuildContext context, String groupId, String groupName) async {
//   //   final user = FirebaseAuth.instance.currentUser;
//   //   if (user != null) {
//   //     await FirebaseFirestore.instance.collection('groupRequests').add({
//   //       'userId': user.uid,
//   //       'userEmail': user.email,
//   //       'groupId': groupId,
//   //       'groupName': groupName,
//   //     });
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Request sent to join $groupName')),
//   //     );
//   //     _listenForApproval(
//   //         context, groupId, groupName); // Start listening for approval
//   //   }
//   // }
//
//   Future<void> _requestToJoinGroup(
//       BuildContext context, String groupId, String groupName) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       // Check if the request has already been approved or is pending
//       final requestSnapshot = await FirebaseFirestore.instance
//           .collection('groupRequests')
//           .where('userId', isEqualTo: user.uid)
//           .where('groupId', isEqualTo: groupId)
//           .get();
//
//       if (requestSnapshot.docs.isEmpty) {
//         // Add new request
//         await FirebaseFirestore.instance.collection('groupRequests').add({
//           'userId': user.uid,
//           'userEmail': user.email,
//           'groupId': groupId,
//           'groupName': groupName,
//           'status': 'pending',  // Mark request as pending
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Request sent to join $groupName')),
//         );
//         _listenForApproval(context, groupId, groupName); // Start listening for approval
//       } else {
//         // Check the status of existing request
//         final existingRequest = requestSnapshot.docs.first;
//         if (existingRequest['status'] == 'approved') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('You are already approved to join $groupName')),
//           );
//         } else if (existingRequest['status'] == 'pending') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Request to join $groupName is already pending')),
//           );
//         }
//       }
//     }
//   }
//
//
//
//   Future<void> _signOut(BuildContext context) async {
//           await _authService.signOut();
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => SignInScreen()),
//           );
//         }
//
//
//         @override
//         Widget build(BuildContext context) {
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Join a Group'),
//               actions: [
//                 IconButton(
//                   icon: Icon(Icons.exit_to_app),
//                   onPressed: () => _signOut(context),
//                 ),
//               ],
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: StreamBuilder(
//                       stream:
//                       FirebaseFirestore.instance.collection('groups')
//                           .snapshots(),
//                       builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Center(child: CircularProgressIndicator());
//                         }
//                         final groupDocs = snapshot.data!.docs;
//                         return ListView.builder(
//                           itemCount: groupDocs.length,
//                           itemBuilder: (ctx, index) {
//                             final group = groupDocs[index];
//                             return ListTile(
//                               title: Text(group['name']),
//                               onTap: () =>
//                                   _requestToJoinGroup(
//                                       context, group.id, group['name']),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_flutter_app/ChatScreen.dart';
// import 'package:my_flutter_app/SignInScreen.dart';
// import 'auth_service.dart';
//
// class GroupCreationScreen extends StatelessWidget {
//   final AuthService _authService = AuthService();
//
//   void _listenForApproval(
//       BuildContext context, String groupId, String groupName) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       FirebaseFirestore.instance
//           .collection('groupRequests')
//           .where('userId', isEqualTo: user.uid)
//           .where('groupId', isEqualTo: groupId)
//           .snapshots()
//           .listen((snapshot) {
//         if (snapshot.docs.isNotEmpty) {
//           final request = snapshot.docs.first;
//           if (request['status'] == 'approved') {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                   builder: (context) => ChatScreen(groupName: groupName)),
//             );
//           }
//         }
//       });
//     }
//   }
//
//   Future<void> _requestToJoinGroup(
//       BuildContext context, String groupId, String groupName) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final requestSnapshot = await FirebaseFirestore.instance
//           .collection('groupRequests')
//           .where('userId', isEqualTo: user.uid)
//           .where('groupId', isEqualTo: groupId)
//           .get();
//
//       if (requestSnapshot.docs.isEmpty) {
//         // Add new request
//         await FirebaseFirestore.instance.collection('groupRequests').add({
//           'userId': user.uid,
//           'userEmail': user.email,
//           'groupId': groupId,
//           'groupName': groupName,
//           'status': 'pending',  // Mark request as pending
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Request sent to join $groupName')),
//         );
//         _listenForApproval(context, groupId, groupName); // Start listening for approval
//       } else {
//         final existingRequest = requestSnapshot.docs.first;
//         if (existingRequest['status'] == 'approved') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('You are already approved to join $groupName')),
//           );
//         } else if (existingRequest['status'] == 'pending') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Request to join $groupName is already pending')),
//           );
//         }
//       }
//     }
//   }
//
//   Future<void> _signOut(BuildContext context) async {
//     await _authService.signOut();
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => SignInScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Join a Group'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () => _signOut(context),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: StreamBuilder(
//                 stream: FirebaseFirestore.instance.collection('groups').snapshots(),
//                 builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   final groupDocs = snapshot.data!.docs;
//                   return ListView.builder(
//                     itemCount: groupDocs.length,
//                     itemBuilder: (ctx, index) {
//                       final group = groupDocs[index];
//                       return ListTile(
//                         title: Text(group['name']),
//                         onTap: () => _requestToJoinGroup(
//                             context, group.id, group['name']),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/ChatScreen.dart';
import 'package:my_flutter_app/SignInScreen.dart';
import 'auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroupCreationScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  // void _listenForApproval(
  //     BuildContext context, String groupId, String groupName) {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     FirebaseFirestore.instance
  //         .collection('groups')
  //         .doc(groupId)
  //         .snapshots()
  //         .listen((docSnapshot) {
  //       if (docSnapshot.exists &&
  //           docSnapshot.data()!['members'].contains(user.uid)) {
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(
  //               builder: (context) => ChatScreen(groupName: groupName)),
  //         );
  //       }
  //     });
  //   }
  // }
  void _listenForApproval(
      BuildContext context, String groupId, String groupName) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('groupRequests')
          .where('userId', isEqualTo: user.uid)
          .where('groupId', isEqualTo: groupId)
          .snapshots()
          .listen((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          final request = querySnapshot.docs.first;
          final status = request['status'];

          // Debugging: Print the status to the console
          print('Current status: $status');

          if (status == 'approved') {
            // Debugging: Print when navigating to the chat screen
            print('Navigating to ChatScreen for group: $groupName');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => ChatScreen(groupName: groupName)),
            );
          } else if (status == 'pending') {
            print('Status is still pending for group: $groupName');
          }
        }
      });
    }
  }


  //
  // Future<void> _requestToJoinGroup(
  //     BuildContext context, String groupId, String groupName) async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     // Check if the request has already been approved or is pending
  //     final requestSnapshot = await FirebaseFirestore.instance
  //         .collection('groupRequests')
  //         .where('userId', isEqualTo: user.uid)
  //         .where('groupId', isEqualTo: groupId)
  //         .get();
  //
  //     if (requestSnapshot.docs.isEmpty) {
  //       // Add new request
  //       await FirebaseFirestore.instance.collection('groupRequests').add({
  //         'userId': user.uid,
  //         'userEmail': user.email,
  //         'groupId': groupId,
  //         'groupName': groupName,
  //         'status': 'pending',  // Mark request as pending
  //       });
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Request Approved to join $groupName')),
  //       );
  //       _listenForApproval(context, groupId, groupName); // Start listening for approval
  //     } else {
  //       // Check the status of existing request
  //       final existingRequest = requestSnapshot.docs.first;
  //       if (existingRequest['status'] == 'approved') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('You are already approved to join $groupName')),
  //         );
  //       } else if (existingRequest['status'] == 'pending') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Request to join $groupName group is already pending')),
  //         );
  //       }
  //     }
  //   }
  // }
//----------------
//   Future<void> _requestToJoinGroup(
//       BuildContext context, String groupId, String groupName) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       // Check if the request already exists
//       final requestSnapshot = await FirebaseFirestore.instance
//           .collection('groupRequests')
//           .where('userId', isEqualTo: user.uid)
//           .where('groupId', isEqualTo: groupId)
//           .get();
//
//       if (requestSnapshot.docs.isEmpty) {
//         // Add new request
//         await FirebaseFirestore.instance.collection('groupRequests').add({
//           'userId': user.uid,
//           'userEmail': user.email,
//           'groupId': groupId,
//           'groupName': groupName,
//           'status': 'pending', // Mark request as pending
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Request sent to join $groupName')),
//         );
//
//         _listenForApproval(context, groupId, groupName); // Start listening for approval
//       } else {
//         // Get the existing request
//         final existingRequest = requestSnapshot.docs.first;
//
//         if (existingRequest['status'] == 'approved') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('You are already approved to join $groupName')),
//           );
//
//           // Navigate directly to the chat screen
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//                 builder: (context) => ChatScreen(groupName: groupName)),
//           );
//         } else if (existingRequest['status'] == 'pending') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Request to join $groupName group is already pending')),
//           );
//         }
//       }
//     }
//   }


  Future<void> _requestToJoinGroup(
      BuildContext context, String groupId, String groupName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final requestSnapshot = await FirebaseFirestore.instance
          .collection('groupRequests')
          .where('userId', isEqualTo: user.uid)
          .where('groupId', isEqualTo: groupId)
          .get();

      if (requestSnapshot.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('groupRequests').add({
          'userId': user.uid,
          'userEmail': user.email,
          'groupId': groupId,
          'groupName': groupName,
          'status': 'pending',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request sent to join $groupName')),
        );

        _listenForApproval(context, groupId, groupName);
      } else {
        final existingRequest = requestSnapshot.docs.first;
        final status = existingRequest['status'];

        if (status == 'approved') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Welcome to $groupName group')),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => ChatScreen(groupName: groupName)),
          );
        } else if (status == 'pending') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Request to join $groupName is already pending')),
          );
        }
      }
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await _authService.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join a Group'),
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
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('groups').snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final groupDocs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: groupDocs.length,
                    itemBuilder: (ctx, index) {
                      final group = groupDocs[index];
                      return ListTile(
                        title: Text(group['name']),
                        onTap: () => _requestToJoinGroup(
                            context, group.id, group['name']),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
