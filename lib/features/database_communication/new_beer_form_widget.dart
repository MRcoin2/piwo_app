import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/features/home/home_screen.dart';

class AddBeerForm extends StatefulWidget {
  final String barcode;

  const AddBeerForm({Key? key, required this.barcode}) : super(key: key);

  @override
  _AddBeerFormState createState() => _AddBeerFormState();
}

class _AddBeerFormState extends State<AddBeerForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breweryController = TextEditingController();
  final TextEditingController _styleController = TextEditingController();
  final TextEditingController _alcoholContentController =
      TextEditingController();

  void _submitForm() async {
    try {
      await FirebaseFirestore.instance
          .collection('beers')
          .doc(widget.barcode)
          .set({
        'name': _nameController.text,
        'brewery': _breweryController.text,
        'style': _styleController.text,
        'alcohol_content': double.parse(_alcoholContentController.text),
        'added_by': FirebaseAuth.instance.currentUser?.uid,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Beer added successfully')),
      );

      _nameController.clear();
      _breweryController.clear();
      _styleController.clear();
      _alcoholContentController.clear();

      Navigator.popAndPushNamed(context, HomeScreen.routeName);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding beer: $error')),
      );
    }
  }

  Widget _buildTextFormField(TextEditingController controller, String label,
      String? Function(String?) validator,
      {TextInputType keyboardType = TextInputType.text,
      void Function()? onEditingComplete}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        keyboardType: keyboardType,
        validator: validator,
        onEditingComplete: onEditingComplete,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextFormField(
              _nameController,
              'Name',
              (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            _buildTextFormField(
              _breweryController,
              'Brewery',
              (value) {
                if (value!.isEmpty) {
                  return 'Please enter a brewery';
                }
                return null;
              },
            ),
            _buildTextFormField(
              _styleController,
              'Style',
              (value) {
                if (value!.isEmpty) {
                  return 'Please enter a style';
                }
                return null;
              },
            ),
            _buildTextFormField(
              _alcoholContentController,
              'Alcohol Content',
              (value) {
                if (value!.isEmpty) {
                  return 'Please enter an alcohol content';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              onEditingComplete: () {
                if (_formKey.currentState!.validate()) {
                  _submitForm();
                }
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _submitForm();
                }
              },
              child: const Text('Add Beer'),
            ),
          ],
        ),
      ),
    );
  }
}
