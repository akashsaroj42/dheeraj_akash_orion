import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Storepost {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName).child("posts");
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveDatapost({
    required Uint8List file,
    required String discription,
    required String RentailAmount,
    required String Deposite,
    required String phone,
    required String Address,
    required String itemname,
  }) async {
    String resp = "Some Error Occurred";

    try {
      if (discription.isNotEmpty ||
          RentailAmount.isNotEmpty ||
          Deposite.isNotEmpty ||
          phone.isNotEmpty ||
          Address.isNotEmpty ||
          itemname.isNotEmpty) {
        String imageUrl = await uploadImageToStorage('share', file);
        await _firestore.collection('post').add({
          'imagelink': imageUrl,
          'discription': discription,
          'RentailAmount': RentailAmount,
          'Deposite': Deposite,
          'phone': phone,
          'Address': Address,
          'itemname': itemname,
        });
      }
      resp = 'success';
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
