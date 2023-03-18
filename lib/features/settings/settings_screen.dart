//import 'package:flutter/material.dart';
// //TODO make this a leaderboard/friends tab
// class MenuTab extends StatelessWidget {
//   const MenuTab({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: const [
//         ListTile(
//           leading: Icon(Icons.person),
//           title: Text("Profile"),
//           trailing: Icon(Icons.keyboard_arrow_right),
//         ),
//         ListTile(
//           leading: Icon(Icons.collections_bookmark_outlined),
//           title: Text("My Collection"),
//           trailing: Icon(Icons.keyboard_arrow_right),
//         ),
//         ListTile(
//           leading: Icon(Icons.settings),
//           title: Text("Settings"),
//           trailing: Icon(Icons.keyboard_arrow_right),
//         )
//       ],
//     );
//   }
// }
//rewrite this as a settings screen for the app
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
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
            title: Text("My Collection"),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            trailing: Icon(Icons.keyboard_arrow_right),
          )
        ],
      )),
    );
  }
}
