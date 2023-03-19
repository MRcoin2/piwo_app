import 'package:flutter/material.dart';
import 'package:untitled/features/friends/add_friend_screen.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName="/settings";

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.collections_bookmark_outlined),
            title: Text("Collection settings"),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Friends"),
            trailing: Icon(Icons.keyboard_arrow_right),onTap: () {Navigator.of(context).pushNamed(AddFriendPage.routeName);} ,
          )
        ],
      )),
    );
  }
}
