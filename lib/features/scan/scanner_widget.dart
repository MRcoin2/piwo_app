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
          // fit: BoxFit.contain,
          controller: MobileScannerController(
            facing: CameraFacing.back,
            torchEnabled: false,
          ),
          onDetect: (capture) async {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            //TODO make sure only one barcode gets scanned (and check the type of barcode)
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');
              //TODO make loading animation when waiting for database response
              if (await checkIfBarcodeExists(barcode.rawValue.toString())) {
                if (!context.mounted) return;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Success'),
                      content: Text(
                          "Added ${FirebaseFirestore.instance.collection('beers').doc(barcode.rawValue.toString()).get().then((DocumentSnapshot documentSnapshot) async {
                          return await documentSnapshot.get('name');
                      }).catchError((error) {
                        print('Error getting document: $error');
                      })} to your collection."),
                      //TODO make the name display properly
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                ).then((value) => Navigator.pushReplacementNamed(
                    context, HomeScreen.routeName));
                //TODO handle already existing beer
              } else {
                if (!context.mounted) return;
                Navigator.pushReplacementNamed(context, AddBeerScreen.routeName,
                    arguments: BeerData(barcode.rawValue.toString()));
              }
            }
          },
        ),
      ),
      SvgPicture.asset(
        "assets/svg/scan_overlay.svg",
        colorFilter:
            ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
      ),
    ]);
  }
}
