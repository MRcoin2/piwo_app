import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/features/home/home_tab.dart';
import 'package:untitled/features/settings/edit_user_info_screen.dart';
import 'package:untitled/features/user_login/login_screen.dart';

import 'menu_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

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
            icon: const Icon(Icons.menu)),
        title: _tabController.index == 0
            ? const Text("Home Screen")
            : const Text("Menu"),
        actions: [
          IconButton(
              onPressed: () {
                /*TODO implement settings page*/
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      drawer: Drawer(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (currentIndex) {
          setState(() {
            _tabController.index = currentIndex;
          });
        },
        currentIndex: _tabController.index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "???")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code_scanner),
        onPressed: () {
          Navigator.pushNamed(context, "/scan");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: TabBarView(
        controller: _tabController,
        children: const [HomeTab(), MenuTab()],
      ),
    );
  }
}
