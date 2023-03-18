import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../settings/edit_user_info_screen.dart';
import '../user_login/login_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50,bottom: 50),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2.0,
                ),
              ),
              child: CircleAvatar(
                radius: 100.0,
                backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser?.photoURL ??
                      "https://wallpapers-clan.com/wp-content/uploads/2022/08/default-pfp-1.jpg",
                ),
              ),
            ),
          ),
          Column(
            children: [
              //TODO crate screens for profile, collection and settings
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, EditProfilePage.routeName);
                },
              ),
              ListTile(
                leading: Icon(Icons.collections_bookmark_outlined),
                title: Text("My Collection"),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              Padding(padding: EdgeInsets.all(30)),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text("Logout",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    )),
                trailing: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.error,
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
