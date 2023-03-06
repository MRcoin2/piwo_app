import 'package:flutter/material.dart';

import 'new_beer_form_widget.dart';

class AddBeerScreen extends StatefulWidget {
  static const String routeName = "/add_beer";
  final String barcodeId;
  const AddBeerScreen({Key? key, required this.barcodeId}) : super(key: key);
  @override
  State<AddBeerScreen> createState() => _AddBeerScreenState();
}

class _AddBeerScreenState extends State<AddBeerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("New Beer Found !!! :D"),
          ),Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.barcodeId),
          ),
            AddBeerForm(barcode: widget.barcodeId),
          ],
        ),
      ),
    );
  }
}
