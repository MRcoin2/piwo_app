import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendRequestsPage extends StatefulWidget {
  static const routeName = '/friend_requests';
  @override
  _FriendRequestsPageState createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<FriendRequestsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = _auth.currentUser!.uid;
  }

  void acceptRequest(String friendId) async {
    // Add friendId to the friends list in the user's document
    await _firestore.collection('users').doc(currentUserId).update({
      'friends': FieldValue.arrayUnion([friendId]),
      'requests': FieldValue.arrayRemove([friendId])
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Friend request accepted")));
  }

  void rejectRequest(String friendId) async {
    // Remove friendId from the requests list in the user's document
    await _firestore.collection('users').doc(currentUserId).update({
      'requests': FieldValue.arrayRemove([friendId])
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Friend request rejected")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend Requests"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('users').doc(currentUserId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          List<dynamic> requests = snapshot.data!['requests'];
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              String requestId = requests[index];
              return FutureBuilder<DocumentSnapshot>(
                future: _firestore.collection('users').doc(requestId).get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  String username = snapshot.data!['username'];
                  return ListTile(
                    title: Text(username),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: Icon(Icons.check), onPressed: () => acceptRequest(requestId)),
                        IconButton(icon: Icon(Icons.close), onPressed: () => rejectRequest(requestId)),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}