import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreen();
}

class _ShippingScreen extends State<ShippingScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool? _chargeShipping = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProdcutProvider _productProvider =
        Provider.of<ProdcutProvider>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CheckboxListTile(
            title: const Text('Shipping Charges'),
            value: _chargeShipping,
            onChanged: (value) {
              setState(() {
                _chargeShipping = value;
              });
              _productProvider.getFormData(chargeShipping: value);
            },
          ),
          if (_chargeShipping == true)
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Shipping Charges';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                _productProvider.getFormData(
                    shippingCharge: double.parse(value));
              },
              decoration: const InputDecoration(
                  hintText: 'Shipping Charging Fee',
                  labelText: 'Enter Shipping Charge'),
            )
        ],
      ),
    ));
  }
}
