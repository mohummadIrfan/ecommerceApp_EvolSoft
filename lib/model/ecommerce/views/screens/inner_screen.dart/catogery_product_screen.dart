import 'package:flutter/material.dart';

class CatogeryProductScreen extends StatefulWidget {
  final dynamic catogeryData;

  const CatogeryProductScreen({super.key, this.catogeryData});

  @override
  State<CatogeryProductScreen> createState() => _CatogeryProductScreen();
}

class _CatogeryProductScreen extends State<CatogeryProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catogeryData['categoryName']),
      ),
    );
  }
}
