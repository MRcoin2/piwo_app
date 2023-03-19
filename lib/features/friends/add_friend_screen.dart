import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFriendPage extends StatefulWidget {
  static String routeName = '/add_friend';

  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final TextEditingController _usernameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    // Get the current user ID
    currentUserId = _auth.currentUser!.uid;
  }
  // Add a friend by username
  void sendFriendRequest() async {
    String username = _usernameController.text;
    // Check if the username exists
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    //check if user alredy a friend
    QuerySnapshot querySnapshot2 = await _firestore
        .collection('users')
        .where('friends', arrayContains: currentUserId)
        .get();
    if (querySnapshot.docs.isEmpty) {
      // Username does not exist
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Username does not exist")));
      return;
    }
    // Get the user ID of the friend to add
    String friendId = querySnapshot.docs.first.id;
    // Add currentUserId to the requests list in the friend's document
    await _firestore.collection('users').doc(friendId).update({
      'requests': FieldValue.arrayUnion([currentUserId])
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Friend request sent")));
  }

  void acceptRequest(String friendId) async {
    // Add friendId to the friends list in the user's document
    await _firestore.collection('users').doc(currentUserId).update({
      'friends': FieldValue.arrayUnion([friendId]),
      'requests': FieldValue.arrayRemove([friendId])
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Friend request accepted")));
  }

  void rejectRequest(String friendId) async {
    // Remove friendId from the requests list in the user's document
    await _firestore.collection('users').doc(currentUserId).update({
      'requests': FieldValue.arrayRemove([friendId])
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Friend request rejected")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Friend"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: sendFriendRequest,
                child: Text("Send Friend Request")),
            SizedBox.fromSize(
              size: Size.fromHeight(160),
              child: StreamBuilder<DocumentSnapshot>(
                stream: _firestore
                    .collection('users')
                    .doc(currentUserId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  List<dynamic> requests = snapshot.data!['requests'] ?? [];
                  return ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      String requestId = requests[index];
                      return FutureBuilder<DocumentSnapshot>(
                        future: _firestore.collection('users').doc(requestId).get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return CircularProgressIndicator();
                          String username = snapshot.data!['username'] ?? 'Unknown';
                          return ListTile(
                            title: Text(username),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.check),
                                    onPressed: () => acceptRequest(requestId)),
                                IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () => rejectRequest(requestId)),
                              ],
                            ),
                          );
                        },
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
