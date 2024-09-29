import 'package:ecommerce_app/model/ecommerce/views/screens/bottomNavbarScreen/category_screen.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/bottomNavbarScreen/homeScreen.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/bottomNavbarScreen/uploadScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _indexPages = 0;
  final List<Widget> _pageScreens = [
    HomeScreen(),
    CategoryScreen(),
    UploadScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black,
        currentIndex: _indexPages,
        onTap: (value) {
          setState(() {
            _indexPages = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(Icons.upload), label: 'Upload Task'),
        ],
      ),
      body: _pageScreens[_indexPages],
    );
  }
}
