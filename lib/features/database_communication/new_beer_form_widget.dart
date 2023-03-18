import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewBeerForm extends StatefulWidget {
  late String barcode;

  NewBeerForm({required this.barcode});

  @override
  _NewBeerFormState createState() => _NewBeerFormState();
}

class _NewBeerFormState extends State<NewBeerForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _alcoholContentController =
      TextEditingController();

  String _containerType = 'bottle';

  final List<String> _categories = [
    'flavoured',
    'non-alcoholic',
    'light',
    'dark',
    'strong'
  ];
  List<String> _selectedCategories = [];

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          return FilterChip(
            label: Text(category),
            selected: _selectedCategories.contains(category),
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  _selectedCategories.add(category);
                } else {
                  _selectedCategories.removeWhere((String name) {
                    return name == category;
                  });
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _brandController,
            decoration: InputDecoration(labelText: 'Brand'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a brand';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _alcoholContentController,
            decoration: InputDecoration(labelText: 'Alcohol Content'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an alcohol content';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            value: _containerType,
            items: [
              DropdownMenuItem(child: Text('Bottle'), value: 'bottle'),
              DropdownMenuItem(child: Text('Can'), value: 'can')
            ],
            onChanged: (String? newValue) {
              setState(() {
                this._containerType = newValue!;
              });
            },
          ),
          _buildCategoryChips(),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Submit'),
          )
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, String> barcodes = {};
      barcodes[widget.barcode] = _containerType;

      final User? user = FirebaseAuth.instance.currentUser;
      final String uid = user!.uid;

      await FirebaseFirestore.instance.collection('beers').add({
        'added_by': uid,
        'alcohol_content': double.parse(_alcoholContentController.text),
        'approved': false,
        'barcodes': barcodes,
        'brand': _brandController.text,
        'categories': _selectedCategories,
        'description': '',
        'hidden': false,
        'name': _nameController.text,
      });
      _nameController.clear();
      _brandController.clear();
      _alcoholContentController.clear();
    }
  }
}
