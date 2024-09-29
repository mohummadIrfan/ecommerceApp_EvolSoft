import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/tab_bar_screens.dart/attriburesScreen.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/tab_bar_screens.dart/generalScreen.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/tab_bar_screens.dart/images_screen.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/tab_bar_screens.dart/shippingScreen.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final ProdcutProvider _prodcutProvider =
        Provider.of<ProdcutProvider>(context);
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Screen'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'General'),
              Tab(text: 'Shipping'),
              Tab(text: 'Attributes'),
              Tab(text: 'Images'),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: TabBarView(
            children: [
              GeneralScreen(),
              ShippingScreen(),
              AttributesScreen(),
              ImagesScreen()
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () async {
              final productId = Uuid().v4();
              if (_formKey.currentState!.validate()) {
                EasyLoading.show(status: 'Please Wait');
                await _firestore.collection('products').doc(productId).set({
                  'productId': productId,
                  'productName': _prodcutProvider.productData['productName'],
                  'productPrice': _prodcutProvider.productData['productPrice '],
                  'productQuantity':
                      _prodcutProvider.productData['productQuantity'],
                  'category': _prodcutProvider.productData['category'],
                  'describtion': _prodcutProvider.productData['describtion'],
                  'chargeShipping':
                      _prodcutProvider.productData['chargeShipping'],
                  'shippingCharge':
                      _prodcutProvider.productData['shippingCharge'],
                  'brandName': _prodcutProvider.productData['brandName'],
                  'sizeList': _prodcutProvider.productData['sizeList'],
                  'imageUrlLink': _prodcutProvider.productData['imageUrlLink'],
                }).whenComplete(() {
                  return EasyLoading.dismiss();
                  //   _prodcutProvider.clearData();
                });
              }
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(15)),
              child: const Center(
                child: Text(
                  'Upload Products',
                  style: TextStyle(
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
