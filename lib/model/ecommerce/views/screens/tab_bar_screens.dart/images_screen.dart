import 'dart:io';

import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImagesScreen extends StatefulWidget {
  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ImagePicker imagePicker = ImagePicker();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final List<File> _image = [];
  List<String> _imageUrlLink = [];

  choseImage() async {
    final fileImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (fileImage == null) {
      print('Please Select Image');
    } else {
      setState(() {
        _image.add(File(fileImage.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProdcutProvider _productProvider = Provider.of(context);
    return Scaffold(
        body: Column(
      children: [
        GridView.builder(
            shrinkWrap: true,
            itemCount: _image.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              childAspectRatio: 3 / 3,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return index == 0
                  ? Center(
                      child: IconButton(
                          onPressed: () {
                            choseImage();
                          },
                          icon: Icon(Icons.add)))
                  : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(_image[index - 1])),
                      ),
                    );
            }),
        ElevatedButton(
            onPressed: () async {
              EasyLoading.show(status: 'Please Wait');
              for (var img in _image) {
                Reference ref = await _storage
                    .ref()
                    .child('productImage')
                    .child(Uuid().v4());

                await ref.putFile(img).whenComplete(() async {
                  await ref.getDownloadURL().then((value) {
                    setState(() {
                      _imageUrlLink.add(value);
                    });
                  });
                  EasyLoading.dismiss();
                });
                _productProvider.getFormData(imageUrlLink: _imageUrlLink);
              }
            },
            child: Text('Saved Image'))
      ],
    ));
  }
}
