// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:my_flutter_app/AdminSignInScreen.dart';
// // import 'auth_service.dart';
// //
// // class AdminGroupManagementScreen extends StatefulWidget {
// //   @override
// //   _AdminGroupManagementScreenState createState() => _AdminGroupManagementScreenState();
// // }
// //
// // class _AdminGroupManagementScreenState extends State<AdminGroupManagementScreen> {
// //   final List<String> _groups = ['Soccer', 'Basketball', 'Hockey']; // Initial groups
// //   final _groupController = TextEditingController();
// //   final AuthService _authService = AuthService();
// //
// //   void _addGroup() {
// //     if (_groupController.text.isNotEmpty) {
// //       setState(() {
// //         _groups.add(_groupController.text.trim());
// //       });
// //       _groupController.clear();
// //     }
// //   }
// //
// //   void _deleteGroup(String groupName) {
// //     setState(() {
// //       _groups.remove(groupName);
// //     });
// //   }
// //
// //   Future<void> _adminSignOut(BuildContext context) async {
// //     await _authService.signOut();
// //     Navigator.of(context).pushReplacement(
// //       MaterialPageRoute(builder: (context) => AdminSignInScreen()),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Manage Groups'),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.exit_to_app),
// //             onPressed: () => _adminSignOut(context),
// //           ),
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _groupController,
// //               decoration: InputDecoration(labelText: 'Group Name'),
// //             ),
// //             SizedBox(height: 10),
// //             ElevatedButton(
// //               onPressed: _addGroup,
// //               child: Text('Add Group'),
// //             ),
// //             Divider(),
// //             Expanded(
// //               child: ListView(
// //                 children: _groups.map((group) => ListTile(
// //                   title: Text(group),
// //                   trailing: IconButton(
// //                     icon: Icon(Icons.delete),
// //                     onPressed: () => _deleteGroup(group),
// //                   ),
// //                 )).toList(),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:my_flutter_app/SignInScreen.dart';
// // import 'package:my_flutter_app/GroupCreationScreen.dart';
// // import 'auth_service.dart';
// //
// // class AdminGroupManagementScreen extends StatefulWidget {
// //   @override
// //   _AdminGroupManagementScreenState createState() => _AdminGroupManagementScreenState();
// // }
// //
// // class _AdminGroupManagementScreenState extends State<AdminGroupManagementScreen> {
// //   final AuthService _authService = AuthService();
// //   final _groupController = TextEditingController();
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   Future<void> _addGroup(String groupName) async {
// //     await _firestore.collection('groups').add({'name': groupName});
// //   }
// //
// //   Future<void> _deleteGroup(String groupId) async {
// //     await _firestore.collection('groups').doc(groupId).delete();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Admin Group Management'),
// //         actions: [
// //           IconButton(
// //             icon: Icon(Icons.exit_to_app),
// //             onPressed: () async {
// //               await _authService.signOut();
// //               Navigator.of(context).pushReplacement(
// //                 MaterialPageRoute(builder: (context) => SignInScreen()),
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _groupController,
// //               decoration: InputDecoration(labelText: 'Group Name'),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () {
// //                 final groupName = _groupController.text.trim();
// //                 if (groupName.isNotEmpty) {
// //                   _addGroup(groupName);
// //                   _groupController.clear();
// //                 }
// //               },
// //               child: Text('Add Group'),
// //             ),
// //             Expanded(
// //               child: StreamBuilder(
// //                 stream: _firestore.collection('groups').snapshots(),
// //                 builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return Center(child: CircularProgressIndicator());
// //                   }
// //                   final groupDocs = snapshot.data!.docs;
// //                   return ListView.builder(
// //                     itemCount: groupDocs.length,
// //                     itemBuilder: (ctx, index) {
// //                       final group = groupDocs[index];
// //                       return ListTile(
// //                         title: Text(group['name']),
// //                         trailing: IconButton(
// //                           icon: Icon(Icons.delete),
// //                           onPressed: () => _deleteGroup(group.id),
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_flutter_app/SignInScreen.dart';
// import 'auth_service.dart';
//
//
//
// class AdminGroupManagementScreen extends StatefulWidget {
//   @override
//   _AdminGroupManagementScreenState createState() => _AdminGroupManagementScreenState();
// }
//
//
//
// class _AdminGroupManagementScreenState extends State<AdminGroupManagementScreen> {
//   final AuthService _authService = AuthService();
//   final _groupController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   // final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   List<DocumentSnapshot> _pendingRequests = [];
//
//   Future<void> _addGroup(String groupName) async {
//     await _firestore.collection('groups').add({
//       'name': groupName,
//       'members': [],
//     });
//   }
//
//   Future<void> _deleteGroup(String groupId) async {
//     await _firestore.collection('groups').doc(groupId).delete();
//   }
//
//
//
//   Future<void> _approveRequest(String groupId, String userId, String userEmail, String requestId) async {
//     await _firestore.collection('groups').doc(groupId).update({
//       'members': FieldValue.arrayUnion([userId]),
//     });
//     await _firestore.collection('groupRequests').doc(requestId).delete();
//
//     setState(() {
//       // Remove the request from the list
//       _pendingRequests.removeWhere((request) => request.id == requestId);
//     });
//
//     // Sending email notification (simplified example)
//     print('Email sent to $userEmail: You have been approved to join the group!');
//   }
//     // Sending email notification (simplified example)
//     // You need to configure a backend service or use Firebase Cloud Functions to send real emails.
//
//
//   Future<void> _rejectRequest(String requestId) async {
//     await _firestore.collection('groupRequests').doc(requestId).delete();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Group Management'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () async {
//               await _authService.signOut();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => SignInScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _groupController,
//               decoration: InputDecoration(labelText: 'Group Name'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final groupName = _groupController.text.trim();
//                 if (groupName.isNotEmpty) {
//                   _addGroup(groupName);
//                   _groupController.clear();
//                 }
//               },
//               child: Text('Add Group'),
//             ),
//
//             Expanded(
//
//               child: StreamBuilder(
//                 stream: _firestore.collection('groups').snapshots(),
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
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => _deleteGroup(group.id),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Divider(),
//             Text('Pending Join Requests'),
//             Expanded(
//               child: StreamBuilder(
//                 stream: _firestore.collection('groupRequests').snapshots(),
//                 builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   _pendingRequests = snapshot.data!.docs;
//                   return ListView.builder(
//                     itemCount: _pendingRequests.length,
//                     itemBuilder: (ctx, index) {
//                       final request = _pendingRequests[index];
//                       final userId = request['userId'];
//                       final groupId = request['groupId'];
//                       final userEmail = request['userEmail'];
//
//                       return ListTile(
//                         title: Text('Request to join ${request['groupName']} by $userEmail'),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.check),
//                               onPressed: () => _approveRequest(groupId, userId, userEmail, request.id),
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.close),
//                               onPressed: () => _rejectRequest(request.id),
//                             ),
//                           ],
//                         ),
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
//
// }
//
//

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_flutter_app/SignInScreen.dart';
// import 'auth_service.dart';
//
// class AdminGroupManagementScreen extends StatefulWidget {
//   @override
//   _AdminGroupManagementScreenState createState() => _AdminGroupManagementScreenState();
// }
//
// class _AdminGroupManagementScreenState extends State<AdminGroupManagementScreen> {
//   final AuthService _authService = AuthService();
//   final _groupController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   List<DocumentSnapshot> _pendingRequests = [];
//
//   Future<void> _addGroup(String groupName) async {
//     await _firestore.collection('groups').add({
//       'name': groupName,
//       'members': [],
//     });
//   }
//
//   Future<void> _deleteGroup(String groupId) async {
//     await _firestore.collection('groups').doc(groupId).delete();
//   }
//
//   Future<void> _approveRequest(String groupId, String userId, String userEmail, String requestId) async {
//     // Update the group document to add the user to the members array
//     await _firestore.collection('groups').doc(groupId).update({
//       'members': FieldValue.arrayUnion([userId]),
//     });
//
//     // Delete the request document after approval
//     await _firestore.collection('groupRequests').doc(requestId).delete();
//
//     setState(() {
//       // Remove the request from the list
//       _pendingRequests.removeWhere((request) => request.id == requestId);
//     });
//
//     // Sending email notification (optional)
//     print('Email sent to $userEmail: You have been approved to join the group!');
//   }
//
//   Future<void> _rejectRequest(String requestId) async {
//     await _firestore.collection('groupRequests').doc(requestId).delete();
//
//     setState(() {
//       _pendingRequests.removeWhere((request) => request.id == requestId);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Group Management'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () async {
//               await _authService.signOut();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => SignInScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _groupController,
//               decoration: InputDecoration(labelText: 'Group Name'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final groupName = _groupController.text.trim();
//                 if (groupName.isNotEmpty) {
//                   _addGroup(groupName);
//                   _groupController.clear();
//                 }
//               },
//               child: Text('Add Group'),
//             ),
//             Expanded(
//               child: StreamBuilder(
//                 stream: _firestore.collection('groups').snapshots(),
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
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => _deleteGroup(group.id),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Divider(),
//             Text('Pending Join Requests'),
//             Expanded(
//               child: StreamBuilder(
//                 stream: _firestore.collection('groupRequests').snapshots(),
//                 builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   _pendingRequests = snapshot.data!.docs;
//                   return ListView.builder(
//                     itemCount: _pendingRequests.length,
//                     itemBuilder: (ctx, index) {
//                       final request = _pendingRequests[index];
//                       final userId = request['userId'];
//                       final groupId = request['groupId'];
//                       final userEmail = request['userEmail'];
//
//                       return ListTile(
//                         title: Text('Request to join ${request['groupName']} by $userEmail'),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.check),
//                               onPressed: () => _approveRequest(groupId, userId, userEmail, request.id),
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.close),
//                               onPressed: () => _rejectRequest(request.id),
//                             ),
//                           ],
//                         ),
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
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_flutter_app/SignInScreen.dart';
// import 'auth_service.dart';
//
// class AdminGroupManagementScreen extends StatefulWidget {
//   @override
//   _AdminGroupManagementScreenState createState() => _AdminGroupManagementScreenState();
// }
//
// class _AdminGroupManagementScreenState extends State<AdminGroupManagementScreen> {
//   final AuthService _authService = AuthService();
//   final _groupController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   List<DocumentSnapshot> _pendingRequests = [];
//
//   Future<void> _addGroup(String groupName) async {
//     await _firestore.collection('groups').add({
//       'name': groupName,
//       'members': [],
//     });
//   }
//
//   Future<void> _deleteGroup(String groupId) async {
//     await _firestore.collection('groups').doc(groupId).delete();
//   }
//
//   Future<void> _approveRequest(String groupId, String userId, String userEmail, String requestId) async {
//     // Update the request document's status to "approved"
//     await _firestore.collection('groupRequests').doc(requestId).update({
//       'status': 'approved',
//     });
//
//     // Update the group document to add the user to the members array
//     await _firestore.collection('groups').doc(groupId).update({
//       'members': FieldValue.arrayUnion([userId]),
//     });
//
//     setState(() {
//       // Remove the request from the list (will be handled by StreamBuilder)
//       _pendingRequests.removeWhere((request) => request.id == requestId);
//     });
//
//     // Sending email notification (optional)
//     print('Email sent to $userEmail: You have been approved to join the group!');
//   }
//
//   Future<void> _rejectRequest(String requestId) async {
//     await _firestore.collection('groupRequests').doc(requestId).delete();
//
//     setState(() {
//       _pendingRequests.removeWhere((request) => request.id == requestId);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Group Management'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () async {
//               await _authService.signOut();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => SignInScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _groupController,
//               decoration: InputDecoration(labelText: 'Group Name'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final groupName = _groupController.text.trim();
//                 if (groupName.isNotEmpty) {
//                   _addGroup(groupName);
//                   _groupController.clear();
//                 }
//               },
//               child: Text('Add Group'),
//             ),
//             Expanded(
//               child: StreamBuilder(
//                 stream: _firestore.collection('groups').snapshots(),
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
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => _deleteGroup(group.id),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Divider(),
//             Text('Pending Join Requests'),
//             Expanded(
//               child: StreamBuilder(
//                 stream: _firestore.collection('groupRequests').snapshots(),
//                 builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   _pendingRequests = snapshot.data!.docs;
//                   return ListView.builder(
//                     itemCount: _pendingRequests.length,
//                     itemBuilder: (ctx, index) {
//                       final request = _pendingRequests[index];
//                       final userId = request['userId'];
//                       final groupId = request['groupId'];
//                       final userEmail = request['userEmail'];
//
//                       return ListTile(
//                         title: Text('Request to join ${request['groupName']} by $userEmail'),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.check),
//                               onPressed: () => _approveRequest(groupId, userId, userEmail, request.id),
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.close),
//                               onPressed: () => _rejectRequest(request.id),
//                             ),
//                           ],
//                         ),
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
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_flutter_app/SignInScreen.dart';
// import 'auth_service.dart';
//
// class AdminGroupManagementScreen extends StatefulWidget {
//   @override
//   _AdminGroupManagementScreenState createState() => _AdminGroupManagementScreenState();
// }
//
// class _AdminGroupManagementScreenState extends State<AdminGroupManagementScreen> {
//   final AuthService _authService = AuthService();
//   final _groupController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> _addGroup(String groupName) async {
//     await _firestore.collection('groups').add({
//       'name': groupName,
//       'members': [],
//     });
//   }
//
//   Future<void> _deleteGroup(String groupId) async {
//     await _firestore.collection('groups').doc(groupId).delete();
//   }
//
//   Future<void> _approveRequest(String groupId, String userId, String userEmail, String requestId) async {
//     // Update the request document's status to "approved"
//     await _firestore.collection('groupRequests').doc(requestId).update({
//       'status': 'approved',
//     });
//
//     // Update the group document to add the user to the members array
//     await _firestore.collection('groups').doc(groupId).update({
//       'members': FieldValue.arrayUnion([userId]),
//     });
//
//     // Send email notification (optional)
//     print('Email sent to $userEmail: You have been approved to join the group!');
//   }
//
//   Future<void> _rejectRequest(String requestId) async {
//     await _firestore.collection('groupRequests').doc(requestId).delete();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Group Management'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () async {
//               await _authService.signOut();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => SignInScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _groupController,
//               decoration: InputDecoration(labelText: 'Group Name'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final groupName = _groupController.text.trim();
//                 if (groupName.isNotEmpty) {
//                   _addGroup(groupName);
//                   _groupController.clear();
//                 }
//               },
//               child: Text('Add Group'),
//             ),
//             Expanded(
//               child: StreamBuilder(
//                 stream: _firestore.collection('groups').snapshots(),
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
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => _deleteGroup(group.id),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Divider(),
//             Text('Pending Join Requests'),
//             Expanded(
//               child: StreamBuilder(
//                 stream: _firestore.collection('groupRequests').where('status', isEqualTo: 'pending').snapshots(),
//                 builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   final pendingRequests = snapshot.data!.docs;
//                   return ListView.builder(
//                     itemCount: pendingRequests.length,
//                     itemBuilder: (ctx, index) {
//                       final request = pendingRequests[index];
//                       final userId = request['userId'];
//                       final groupId = request['groupId'];
//                       final userEmail = request['userEmail'];
//
//                       return ListTile(
//                         title: Text('Request to join ${request['groupName']} by $userEmail'),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.check),
//                               onPressed: () => _approveRequest(groupId, userId, userEmail, request.id),
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.close),
//                               onPressed: () => _rejectRequest(request.id),
//                             ),
//                           ],
//                         ),
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
//
//


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/SignInScreen.dart';
import 'auth_service.dart';
import 'dart:convert';  // Add this import for JSON handling
import 'package:http/http.dart' as http;  // Add this import for HTTP requests

class AdminGroupManagementScreen extends StatefulWidget {
  @override
  _AdminGroupManagementScreenState createState() => _AdminGroupManagementScreenState();
}

class _AdminGroupManagementScreenState extends State<AdminGroupManagementScreen> {
  final AuthService _authService = AuthService();
  final _groupController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  // Method to send notification using FCM
  Future<void> _sendNotification(String userToken, String groupName) async {
    final notification = {
      'to': userToken,
      'notification': {
        'title': 'Group Join Request Approved',
        'body': 'You have been approved to join the group $groupName.'
      },
      'priority': 'high'
    };

    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=YOUR_SERVER_KEY_HERE',  // Replace with your FCM server key
      },
      body: json.encode(notification),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send notification');
    }
  }

  Future<void> _addGroup(String groupName) async {
    await _firestore.collection('groups').add({
      'name': groupName,
      'members': [],
    });
  }

  Future<void> _deleteGroup(String groupId) async {
    await _firestore.collection('groups').doc(groupId).delete();
  }

  Future<void> _approveRequest(String groupId, String userId, String userEmail, String requestId) async {
    // Update the request document's status to "approved"
    await _firestore.collection('groupRequests').doc(requestId).update({
      'status': 'approved',
    });

    // Update the group document to add the user to the members array
    await _firestore.collection('groups').doc(groupId).update({
      'members': FieldValue.arrayUnion([userId]),
    });

    // Get the user's FCM token from Firestore
    final userDoc = await _firestore.collection('users').doc(userId).get();
    final userToken = userDoc.data()?['fcmToken'];

    // Send a notification to the user
    if (userToken != null) {
      await _sendNotification(userToken, groupId);
    }



    // Sending email notification (optional)
    print('Email sent to $userEmail: You have been approved to join the group!');
  }

  Future<void> _rejectRequest(String requestId) async {
    await _firestore.collection('groupRequests').doc(requestId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Group Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _authService.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _groupController,
              decoration: InputDecoration(labelText: 'Group Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final groupName = _groupController.text.trim();
                if (groupName.isNotEmpty) {
                  _addGroup(groupName);
                  _groupController.clear();
                }
              },
              child: Text('Add Group'),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _firestore.collection('groups').snapshots(),
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
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteGroup(group.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Divider(),
            Text('Pending Join Requests'),
            Expanded(
              child: StreamBuilder(
                stream: _firestore.collection('groupRequests').where('status', isEqualTo: 'pending').snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final pendingRequests = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: pendingRequests.length,
                    itemBuilder: (ctx, index) {
                      final request = pendingRequests[index];
                      final userId = request['userId'];
                      final groupId = request['groupId'];
                      final userEmail = request['userEmail'];

                      return ListTile(
                        title: Text('Request to join ${request['groupName']} by $userEmail'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () => _approveRequest(groupId, userId, userEmail, request.id),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => _rejectRequest(request.id),
                            ),
                          ],
                        ),
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


