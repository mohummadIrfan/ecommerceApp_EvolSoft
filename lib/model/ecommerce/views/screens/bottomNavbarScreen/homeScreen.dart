import 'package:ecommerce_app/model/ecommerce/views/screens/widgets/MensProductsWidget.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/widgets/banner_widgets.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/widgets/category_text_widget.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/widgets/home_productsWidget.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/widgets/phoneWidgetsProducts.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/widgets/reuse_text_widgets.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/widgets/shoeProductWidget.dart';
import 'package:ecommerce_app/model/ecommerce/views/screens/widgets/womenWidgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          BannerWidgets(),
          CategoeryText(),
          HomeProductsWidget(),
          ReuseTextWidget(title: "Men's Products"),
          MenProductsWidget(),
          ReuseTextWidget(title: 'Women Products'),
          WomenProductsWidget(),
          ReuseTextWidget(title: 'Phone Products'),
          PhoneProductsWidget(),
          ReuseTextWidget(title: 'Shoes Products'),
          ShoeProductsWidget(),
        ],
      ),
    ));
  }
}
