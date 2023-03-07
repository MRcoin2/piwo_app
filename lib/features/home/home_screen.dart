import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/features/home/home_tab.dart';

import 'menu_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.menu)),
        title: _tabController.index == 0 ? Text("Home Screen") : Text("Menu"),
        actions: [
          IconButton(
              onPressed: () {
                /*TODO implement settings page*/
              },
              icon: Icon(Icons.settings))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:50),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser?.photoURL ??
                      "https://wallpapers-clan.com/wp-content/uploads/2022/08/default-pfp-1.jpg",
                ),
              ),
            ),
            Column(
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
                ),Padding(padding:EdgeInsets.all(30)),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text("Settings"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (current_index) {
          setState(() {
            _tabController.index = current_index;
          });
        },
        currentIndex: _tabController.index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "???")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.qr_code_scanner),
        onPressed: () {
          Navigator.pushNamed(context, "/scan");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: TabBarView(
        children: const [HomeTab(), MenuTab()],
        controller: _tabController,
      ),
    );
  }
}
