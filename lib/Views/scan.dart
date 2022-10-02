import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  double height = 0, width = 0;
  String qrString = "Not Scanned";
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFFF835F),
            Color(0xFFFC663C),
            Color(0xFFFF3F1A),
          ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              qrString,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            ElevatedButton(
              onPressed: scanQR,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                child: Text(
                  'Scan ...',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFF3F1A), // background
                  onPrimary: Colors.white // foreground
                  ),
            ),
            SizedBox(width: width),
          ],
        ),
      ),
    );
  }

  Future<void> scanQR() async {
    try {
      FlutterBarcodeScanner.scanBarcode("#2A99CF", "Cancel", true, ScanMode.QR)
          .then((value) {
        setState(() {
          if (value == "-1") {
            qrString = "Not Scanned";
          } else {
            qrString = value;
          }
        });
      });
    } catch (e) {
      setState(() {
        qrString = "unable to read the qr";
      });
    }
  }
}
