import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:untitled/features/database_communication/add_beer_screen.dart';
import 'package:untitled/features/database_communication/utils.dart';
import 'package:untitled/features/home/home_screen.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - window.viewInsets.top,
        child: MobileScanner(
          // Initialize the MobileScanner widget with a MobileScannerController
          controller: MobileScannerController(
            facing: CameraFacing.back, // Use the back-facing camera
            torchEnabled: false, // Disable the flashlight
          ),
          // Set the onDetect callback to handle the detected barcode
          onDetect: (capture) async {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Scanned Barcode'),
                    content: FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('beers')
                          .doc(barcode.rawValue.toString())
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error getting document: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Display a loading animation while the document is being fetched
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        // Check if the document exists
                        if (snapshot.data != null && snapshot.data!.exists) {
                          //TODO add beer to users collection in firestore
                          // Document exists, show success message
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${snapshot.data?.get('name')} was added to your collection.",
                              ),
                              SizedBox(height: 16),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacementNamed(
                                      context, HomeScreen.routeName);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        } else {
                          // Document does not exist, navigate to AddBeerScreen
                          Navigator.pushReplacementNamed(
                            context,
                            AddBeerScreen.routeName,
                            arguments: BeerData(barcode.rawValue.toString()),
                          );
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      // Show an SVG overlay on top of the camera preview
      SvgPicture.asset(
        "assets/svg/scan_overlay.svg",
        colorFilter:
        ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
      ),
    ]);
  }
}
