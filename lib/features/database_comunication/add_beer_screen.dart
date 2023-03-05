import 'package:flutter/material.dart';

import 'new_beer_form_widget.dart';

class AddBeerScreen extends StatefulWidget {
  const AddBeerScreen({Key? key}) : super(key: key);

  @override
  State<AddBeerScreen> createState() => _AddBeerScreenState();
}

class _AddBeerScreenState extends State<AddBeerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddBeerForm(),
    );
  }
}
