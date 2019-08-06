import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ung_ssru/screens/my_map.dart';
import 'package:ung_ssru/screens/qr_reader.dart';
import 'package:ung_ssru/screens/show_info.dart';
import 'package:ung_ssru/screens/show_product.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String nameString = '';
  Widget myWidget = ShowProduct();

  // Method
  Widget myDivider() {
    return Divider(
      height: 5.0,
      color: Colors.blue[800],
    );
  }

  Widget menuQRcode() {
    return ListTile(
      leading: Icon(
        Icons.android,
        size: 36.0,
        color: Colors.purple,
      ),
      title: Text(
        'QR code Reader',
        style: TextStyle(fontSize: 18.0),
      ),onTap: (){
        setState(() {
          myWidget = QRreader();
          Navigator.of(context).pop();
        });
      },
    );
  }

  Widget menuShowInfo() {
    return ListTile(
      leading: Icon(
        Icons.account_box,
        size: 36.0,
        color: Colors.orange,
      ),
      title: Text(
        'Show Info',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = ShowInfo();
          Navigator.of(context).pop();
        });
      },
    );
  }

  Widget menuShowMap() {
    return ListTile(
      leading: Icon(
        Icons.map,
        size: 36.0,
        color: Colors.blue,
      ),
      title: Text(
        'Show Map',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = MyMap();
          Navigator.of(context).pop();
        });
      },
    );
  }

  Widget menuShowProduct() {
    return ListTile(
      leading: Icon(
        Icons.face,
        size: 36.0,
        color: Colors.green,
      ),
      title: Text(
        'Show Product',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        setState(() {
          myWidget = ShowProduct();
          Navigator.of(context).pop();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      nameString = firebaseUser.displayName;
    });
    print('name = $nameString');
  }

  Widget showDrawerMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          headMenu(),
          menuShowProduct(),
          myDivider(),
          menuShowMap(),
          myDivider(),
          menuShowInfo(),
          myDivider(),
          menuQRcode(),
          myDivider(),
          signOutAnExit(),
        ],
      ),
    );
  }

  Widget signOutAnExit() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        size: 36.0,
        color: Colors.red,
      ),
      title: Text(
        'Sign Out & Exit',
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        mySignOut();
      },
    );
  }

  Future<void> mySignOut() async {
    await firebaseAuth.signOut().then((response) {
      exit(0);
    });
  }

  Widget headMenu() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, Colors.yellow[900]],
          radius: 1.5,
          center: Alignment.center,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 60.0,
            height: 60.0,
            child: Image.asset('images/logo.png'),
          ),
          Text(
            'Ung SSRU',
            style: TextStyle(
              color: Colors.green[800],
              fontSize: 24.0,
            ),
          ),
          Text('Login by $nameString')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: myWidget,
      drawer: showDrawerMenu(),
    );
  }
}
