import 'dart:typed_data';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:ecommerce_app/model/ecommerce/controller/ecommerce_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class EcommerceRegistrationScreen extends StatefulWidget {
  const EcommerceRegistrationScreen({super.key});

  @override
  State<EcommerceRegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends State<EcommerceRegistrationScreen> {
  final EcommerceController _ecommerceController = EcommerceController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late String businessName;
  late String emailAddress;
  late String phoneNumber;
  late String stateValue;
  late String countryValue;
  late String cityValue;
  Uint8List? _image;
  selectImageFromGallery() async {
    Uint8List img = await _ecommerceController.selectImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: Colors.pink,
            toolbarHeight: 200,
            flexibleSpace: Center(
                child: Container(
              height: 50,
              width: 50,
              color: Colors.white,
              child: _image != null
                  ? Image.memory(_image!)
                  : IconButton(
                      onPressed: () {
                        selectImageFromGallery();
                      },
                      icon: Icon(CupertinoIcons.photo)),
            )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        businessName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter Business Name';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.business_center,
                            color: Colors.pink,
                          ),
                          labelText: 'Business Name',
                          hintText: 'Business Name'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) {
                        emailAddress = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter email address';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.pink,
                          ),
                          labelText: 'Email Address',
                          hintText: 'Email Address'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter phone number';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.pink,
                          ),
                          labelText: 'Phone Number',
                          hintText: 'Phone Number'),
                    ),
                    SizedBox(height: 15),
                    SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              EasyLoading.show(status: 'Please wait');
              _ecommerceController
                  .vendorRegistrationForm(emailAddress, phoneNumber,
                      businessName, stateValue, countryValue, cityValue, _image)
                  .whenComplete(() {
                EasyLoading.dismiss();
              });
            } else {
              print("false");
            }
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: Text(
              'Register',
              style: TextStyle(
                  letterSpacing: 5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
