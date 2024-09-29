import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productData['productName']),
      ),
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.productData['imageUrlLink'],
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      )),
    );
  }
}
