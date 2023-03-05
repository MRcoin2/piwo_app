import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBeerForm extends StatefulWidget {
  @override
  _AddBeerFormState createState() => _AddBeerFormState();
}

class _AddBeerFormState extends State<AddBeerForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breweryController = TextEditingController();
  final TextEditingController _styleController = TextEditingController();
  final TextEditingController _alcoholContentController =
  TextEditingController();

  void _submitForm() async {
    try {
      await FirebaseFirestore.instance.collection('beers').doc(_barcodeController.text).set({
        'name': _nameController.text,
        'brewery': _breweryController.text,
        'style': _styleController.text,
        'alcohol_content': double.parse(_alcoholContentController.text),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Beer added successfully')),
      );

      _barcodeController.clear();
      _nameController.clear();
      _breweryController.clear();
      _styleController.clear();
      _alcoholContentController.clear();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding beer: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _barcodeController,
            decoration: InputDecoration(
              labelText: 'Barcode',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a barcode';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _breweryController,
            decoration: InputDecoration(
              labelText: 'Brewery',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a brewery';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _styleController,
            decoration: InputDecoration(
              labelText: 'Style',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a style';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _alcoholContentController,
            decoration: InputDecoration(
              labelText: 'Alcohol Content',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an alcohol content';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _submitForm();
              }
            },
            child: Text('Add Beer'),
          ),
        ],
      ),
    );
  }
}