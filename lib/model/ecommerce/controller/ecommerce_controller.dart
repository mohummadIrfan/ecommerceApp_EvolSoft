import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EcommerceController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  selectImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? xFile = await _imagePicker.pickImage(source: source);

    if (xFile != null) {
      return await xFile.readAsBytes();
    } else {
      print('not Selected');
    }
  }

  _uploadImageToStorage(Uint8List? image) async {
    Reference ref = _firebaseStorage
        .ref()
        .child('storageImage')
        .child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downLoadUrl = await taskSnapshot.ref.getDownloadURL();
    return downLoadUrl;
  }

  Future<String> vendorRegistrationForm(
      String emailAddress,
      String phoneNumber,
      String businessName,
      String stateValue,
      String countryValue,
      String cityValue,
      Uint8List? image) async {
    String res = "something went wrong";
    try {
      String downLoadUrl = await _uploadImageToStorage(image);
      await _firestore.collection("vendor").doc(_auth.currentUser!.uid).set({
        "emailAddress": emailAddress,
        "phoneNumber": phoneNumber,
        "businessName": businessName,
        "countryValue": countryValue,
        "stateValue": stateValue,
        "cityValue": cityValue,
        "storageImage": downLoadUrl,
        "id": _auth.currentUser!.uid,
        "approved": false,
      });
      res = "sucess";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
