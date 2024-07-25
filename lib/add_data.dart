import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData{
  Future<String> uploadImagetoStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData({required Uint8List file}) async {
    String resp = "Some Error Occurred";
    try{
      String imageUrl = await uploadImagetoStorage('Profileimages',file);
      await _firestore.collection('Profile_image').add({
          'imagelink' : imageUrl
        }
      );
      resp = 'success';
    }
    catch(err){
      resp = err.toString();
    }
    return resp;
  }
}