import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> _categoryList = [];

  getCategories() {
    return _firestore
        .collection('Categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      });
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProdcutProvider _productProvider =
        Provider.of<ProdcutProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Name';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                _productProvider.getFormData(
                  productName: value,
                );
              },
              decoration: InputDecoration(
                  prefixIcon: Image.asset(
                    'assests/images/products.webp',
                    height: 15,
                  ),
                  hintText: 'Enter Product Name',
                  labelText: 'Product Name',
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, letterSpacing: 3)),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Price';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                _productProvider.getFormData(
                  productPrice: double.parse(value),
                );
              },
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.price_change_outlined,
                    size: 40,
                  ),
                  prefixIconColor: Colors.pink,
                  hintText: 'Enter Product Price',
                  labelText: 'Product Price',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3)),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Product Quantity';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                _productProvider.getFormData(
                  productQuantity: int.parse(value),
                );
              },
              decoration: InputDecoration(
                  prefixIcon: Image.asset(
                    'assests/images/quantity.png',
                    height: 15,
                  ),
                  hintText: 'Enter Product Quantity',
                  labelText: 'Product Quantity',
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, letterSpacing: 3)),
            ),
            const SizedBox(
              height: 25,
            ),
            DropdownButtonFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Select Product Category';
                } else {
                  return null;
                }
              },
              hint: const Text('Select Category'),
              icon: const Icon(
                Icons.category,
                color: Colors.pink,
              ),
              items: _categoryList.map<DropdownMenuItem<dynamic>>((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (value) {
                _productProvider.getFormData(category: value);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Product Describtion';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  _productProvider.getFormData(describtion: value);
                },
                maxLines: 10,
                minLines: 3,
                maxLength: 200,
                decoration: InputDecoration(
                    prefixIcon: Image.asset(
                      'assests/images/products.webp',
                      height: 15,
                    ),
                    hintText: 'Enter Product Describtion',
                    labelText: 'Product Describtions',
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 3))),
          ],
        ),
      ),
    ));
  }
}
