import 'package:flutter/material.dart';
//TODO make this a profile tab and move settings to an action on the appbar
class MenuTab extends StatelessWidget {
  const MenuTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: Text("Profile"),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: const Icon(Icons.collections_bookmark_outlined),
          title: Text("My Collection"),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text("Settings"),
          trailing: Icon(Icons.keyboard_arrow_right),
        )
      ],
    );
  }
}

/*
Profile
My Collection
Settings

*/
