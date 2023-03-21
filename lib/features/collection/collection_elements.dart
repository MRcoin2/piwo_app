import 'package:flutter/material.dart';

class ColloctionBeer extends StatefulWidget {
  const ColloctionBeer({Key? key}) : super(key: key);

  @override
  State<ColloctionBeer> createState() => _ColloctionBeerState();
}

class _ColloctionBeerState extends State<ColloctionBeer> {
  @override
  Widget build(BuildContext context) {
    //card for displaying the beer picture from firestore and the beer name
    return Card(
      child: FutureBuilder(
        future: _storage,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Text("Beer Name"),
                Text("Beer Brand"),
                Text("Beer Alcohol Content"),
                Text("Beer Container Type"),
                Text("Beer Categories"),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
  }
}
