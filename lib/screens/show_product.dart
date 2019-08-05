import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ung_ssru/models/product_model.dart';

class ShowProduct extends StatefulWidget {
  @override
  _ShowProductState createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  // Explicit
  Firestore fireStore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  List<ProductModel> productModels = [];

  // Method
  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    CollectionReference collectionReference = fireStore.collection('Product');
    subscription = await collectionReference.snapshots().listen((dataSnapshop) {
      snapshots = dataSnapshop.documents;

      for (var snapshot in snapshots) {
        String nameProduct = snapshot.data['Name'];
        print('nameProduct = $nameProduct');

        String detailProduct = snapshot.data['Detial'];
        String urlProduct = snapshot.data['Url'];

        ProductModel productModel =
            ProductModel(nameProduct, detailProduct, urlProduct);

        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  Widget showListProduct() {
    return ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(productModels[index].name);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showListProduct(),
    );
  }
}
