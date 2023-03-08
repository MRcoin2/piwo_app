import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(//TODO display a real list of user's beers
      itemBuilder: (BuildContext context, int index) {
        if (index < 100) {
          return ListTile(
            leading: const Icon(Icons.wine_bar),
            trailing: Text("$index"),
          );
        }
        return null;
      },
    );
  }
}
