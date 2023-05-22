import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobkar_pro/view/components/mysnackbar.dart';

class DataController extends ChangeNotifier {
  final __user  = FirebaseAuth.instance.currentUser;
  final __store = FirebaseFirestore.instance;
  final __storage = FirebaseStorage.instance;
  XFile? __image;
  Future<void> database(context, String name,String email,String phone, String imageUrl,String organisation) async {
    await __store.collection("community").add({
      'name' : name,
      'email' : email,
      'phone' : phone,
      'imageUr' : imageUrl,
      'orgName' : organisation,
      'program' : '',
      'pages' : '',
      'group' : '',
    }).then((value) {
      MySnackBar(context, "Program joined successfully");
    });
  }

  Future<void> documentSubmission(context, String verifiedPhone, String orgName, String orgLocation) async {
    await __store.collection("recruiter").doc(__user!.uid).collection("document").doc().set({
      "organisation-name" : orgName,
      "verified-email" : __user!.emailVerified,
      "verified-phone" : verifiedPhone,
      "org-location" : orgLocation,
    }).then((value) {

    });
  }

  Future<void> uploadLogoImage(context) async {
    try {
      __image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50);
      final file = File(__image!.path);
      if (__image != null) {
        var snapshot = await __storage
            .ref()
            .child("logo/${__user!.uid}")
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        __store.collection("recruiter").doc(__user!.uid).collection("document").doc().update({
          'logoUrl': downloadUrl,
        });
        MySnackBar(context, "Image successfully uploaded");
        notifyListeners();
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> uploadIdentityImage(context) async {
    try {
      __image = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50);
      final file = File(__image!.path);
      if (__image != null) {
        var snapshot = await __storage
            .ref()
            .child("document/${__user!.uid}")
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        __store.collection("recruiter").doc(__user!.uid).collection("document").doc().update({
          'identity-card': downloadUrl,
        });
        MySnackBar(context, "Image successfully uploaded");
        notifyListeners();
      }
    } catch (e) {
      e.toString();
    }
  }
}