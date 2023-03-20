import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);
  static const routeName = "/collection";

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late List<DocumentSnapshot> _brands;

  @override
  void initState() {
    super.initState();
    _loadBrands();
  }

  Future<void> _loadBrands() async {
    final QuerySnapshot brandsSnapshot =
    await _firestore.collection('brands').get();
    setState(() {
      _brands = brandsSnapshot.docs;
    });
  }

  Widget _buildBrandLogo(String logoUrl) {
    if (logoUrl.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Image.network(
        logoUrl,
        width: 100,
        height: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collection'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _brands.length,
        itemBuilder: (BuildContext ctx, int index) {
          final brand = _brands[index];
          final logoRef = _storage.ref('brands/${brand.id}/logo.png');
          return FutureBuilder<String>(
            future: logoRef.getDownloadURL(),
            builder: (BuildContext ctx, AsyncSnapshot<String> snapshot) {
              final logoUrl = snapshot.data ?? '';
              return InkWell(
                onTap: () {
                  // Navigate to the details screen for this brand
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildBrandLogo(logoUrl),
                    const SizedBox(height: 10),
                    Text(
                      brand['name'],
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}