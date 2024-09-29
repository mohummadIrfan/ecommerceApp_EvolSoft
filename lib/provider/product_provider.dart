import 'package:flutter/material.dart';

class ProdcutProvider with ChangeNotifier {
  Map<String, dynamic> productData = {};

  getFormData(
      {String? productName,
      double? productPrice,
      int? productQuantity,
      String? category,
      String? describtion,
      bool? chargeShipping,
      double? shippingCharge,
      String? brandName,
      List<String>? sizeList,
      List<String>? imageUrlLink}) {
    if (productName != null) {
      productData['productName'] = productName;
    }
    if (productPrice != null) {
      productData['productPrice '] = productPrice;
    }
    if (productQuantity != null) {
      productData['productQuantity'] = productQuantity;
    }
    if (category != null) {
      productData['category'] = category;
    }
    if (describtion != null) {
      productData['describtion'] = describtion;
    }
    if (chargeShipping != null) {
      productData['chargeShipping'] = chargeShipping;
    }
    if (shippingCharge != null) {
      productData['shippingCharge'] = shippingCharge;
    }
    if (brandName != null) {
      productData['brandName '] = brandName;
    }
    if (sizeList != null) {
      productData['sizeList'] = sizeList;
    }
    if (imageUrlLink != null) {
      productData['imageUrlLink'] = imageUrlLink;
    }

    notifyListeners();
  }

  clearData() {
    productData.clear();
    notifyListeners();
  }
}
