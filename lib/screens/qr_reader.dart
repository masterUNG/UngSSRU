import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class QRreader extends StatefulWidget {
  @override
  _QRreaderState createState() => _QRreaderState();
}

class _QRreaderState extends State<QRreader> {
  // Explicit
  String qrCodeString = 'QRcode';

  // Method
  Widget showText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '$qrCodeString',
        style: TextStyle(fontSize: 48.0),
      ),
    );
  }

  Widget showButton() {
    return RaisedButton.icon(
      icon: Icon(Icons.android),
      label: Text('Read QR code'),
      onPressed: () {
        qrProcess();
      },
    );
  }

  Future<void> qrProcess() async {
    try {
      String codeString = await BarcodeScanner.scan();

      if (codeString.length != 0) {
        setState(() {
          qrCodeString = codeString;
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          showText(),
          showButton(),
        ],
      ),
    );
  }
}
