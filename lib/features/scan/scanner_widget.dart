import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:untitled/features/database_communication/add_beer_screen.dart';
import 'package:untitled/features/database_communication/utils.dart';

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
                //TODO handle already existing beer
              } else {
                if (!context.mounted) return;
                Navigator.pushReplacementNamed(context, AddBeerScreen.routeName,arguments: BeerData(barcode.rawValue.toString()));
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
