import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit

  // Method
  Widget showDrawerMenu() {
    return ListView(
      children: <Widget>[
        headMenu(),
      ],
    );
  }

  Widget headMenu() {
    return DrawerHeader(
      decoration: BoxDecoration(),
      child: Column(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            child: Image.asset('images/logo.png'),
          )
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
      body: Text('body'),
      drawer: showDrawerMenu(),
    );
  }
}
