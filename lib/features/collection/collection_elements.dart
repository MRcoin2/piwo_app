import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CollectionBeerCard extends StatefulWidget {
  late String beerId;
  late String packagingType;
  bool isGray=true;
  CollectionBeerCard({Key? key, required beerID, required packagingType, isGray}) : super(key: key);

  @override
  State<CollectionBeerCard> createState() => _CollectionBeerCardState();
}

class _CollectionBeerCardState extends State<CollectionBeerCard> {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    //card for displaying the beer picture from firestore and the beer name
    return Card(
      child: FutureBuilder(
        future: _storage.ref('brands/${beerId}/${packagingType}.png').getDownloadURL(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [

              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
  }
}
