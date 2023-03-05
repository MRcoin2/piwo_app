
import 'package:flutter/material.dart';
import 'package:untitled/features/scan/scanner_widget.dart';

class ScanScreen extends StatefulWidget {
  static const routeName = "/scan";
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("scan piwo"),
      ),
      body: Scanner(),
    );
  }
}
