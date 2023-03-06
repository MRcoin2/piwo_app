import 'package:cloud_firestore/cloud_firestore.dart';

class BeerData{
  late String barcodeId;
  BeerData(this.barcodeId);
}


Future<bool> checkIfBarcodeExists(String barcodeId) async {
  final DocumentReference documentRef =
  FirebaseFirestore.instance.collection('beers').doc(barcodeId);

  final DocumentSnapshot snapshot = await documentRef.get();

  return snapshot.exists;
}