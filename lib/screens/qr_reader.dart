import 'package:flutter/material.dart';

class QRreader extends StatefulWidget {
  @override
  _QRreaderState createState() => _QRreaderState();
}

class _QRreaderState extends State<QRreader> {
  // Explicit

  // Method
  Widget showText() {
    return Container(alignment: Alignment.center,
      child: Text('QRcode', style: TextStyle(fontSize: 48.0),),
    );
  }

  Widget showButton() {
    return RaisedButton.icon(
      icon: Icon(Icons.android),
      label: Text('Read QR code'),
      onPressed: () {},
    );
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
