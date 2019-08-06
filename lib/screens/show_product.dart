import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ung_ssru/models/product_model.dart';
import 'package:ung_ssru/screens/show_detail.dart';

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

        String detailProduct = snapshot.data['Detail'];
        String urlProduct = snapshot.data['Url'];

        ProductModel productModel =
            ProductModel(nameProduct, detailProduct, urlProduct);

        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(30.0)),
      width: 150.0,
      height: 100.0,
      child: Image.network(
        productModels[index].url,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showText(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        showName(index),
        showDetailShort(index),
      ],
    );
  }

  Widget showName(int index) {
    return Text(
      productModels[index].name,
      style: TextStyle(fontSize: 24.0),
    );
  }

  Widget showDetailShort(int index) {
    String detailShort = (productModels[index].detail).substring(1, 70);
    return Container(
        width: 180.0,
        child: Text(
          '$detailShort ...',
        ));
  }

  Widget showListProduct() {
    return Container(
      child: ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              decoration: index % 2 == 0
                  ? BoxDecoration(color: Colors.blue[50])
                  : BoxDecoration(color: Colors.blue[200]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  showImage(index),
                  SizedBox(
                    width: 8.0,
                  ),
                  showText(index),
                ],
              ),
            ),
            onTap: () {
              print('you click index = $index');

              var showDetailRoute = MaterialPageRoute(
                  builder: (BuildContext context) => ShowDetail(
                        productModel: productModels[index],
                      ));
              Navigator.of(context).push(showDetailRoute);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showListProduct(),
    );
  }
}
