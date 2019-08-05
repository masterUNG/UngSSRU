import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowProduct extends StatefulWidget {
  @override
  _ShowProductState createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {

  // Explicit
  Firestore fireStore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;


  // Method
  @override
  void initState() { 
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore()async{

    CollectionReference collectionReference = fireStore.collection('Product');
    subscription = await collectionReference.snapshots().listen((dataSnapshop){
      snapshots = dataSnapshop.documents;

      for (var snapshot in snapshots) {
        
        String nameProduct = snapshot.data['Name'];
        print('nameProduct = $nameProduct');

      }

    });

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('This is ShowProduce'),
    );
  }
}
