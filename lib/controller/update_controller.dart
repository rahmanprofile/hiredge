import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../view/components/mysnackbar.dart';

class UpdateController extends ChangeNotifier {
  final __user = FirebaseAuth.instance.currentUser;
  final __store = FirebaseFirestore.instance;
  final __storage = FirebaseStorage.instance;
  XFile? __image;

  Future<void> updateName(context, String name) async {
    try {
      __store.collection("recruiters").doc(__user!.uid).update({
        'name': name,
      }).then((value) {
        MySnackBar(context, "Name update successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
    }
  }

  Future<void> updatePhone(context, String phone) async {
    try {
      __store.collection("recruiters").doc(__user!.uid).update({
        'phone': phone,
      }).then((value) {
        MySnackBar(context, "Phone update successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
    }
  }

  Future<void> updateEmail(context, String email) async {
    try {
      __store.collection("recruiters").doc(__user!.uid).update({
        'email': email,
      }).then((value) {
        MySnackBar(context, "Email update successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
    }
  }

  Future<void> updatePassword(context, String password) async {
    try {
      __store.collection("recruiters").doc(__user!.uid).update({
        'password': password,
      }).then((value) {
        MySnackBar(context, "Password update successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
    }
  }

  Future<void> verifiedEmail(context, bool isEmailVerified) async {
    try {
      __store.collection("recruiters").doc(__user!.uid).update({
        'isEmailVerified': isEmailVerified,
      }).then((value) {
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
    }
  }

  Future<void> updateOrganisation(context, String company) async {
    try {
      __store.collection("recruiters").doc(__user!.uid).update({
        'organisation-name': company,
      }).then((value) {
        MySnackBar(context, "Organisation update successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
    }
  }

  Future<void> updateLocation(context, String location) async {
    try {
      __store.collection("recruiters").doc(__user!.uid).update({
        'org-location': location,
      }).then((value) {
        MySnackBar(context, "Location update successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
    }
  }

  Future<void> updateImage(context, ImageSource source) async {
    try {
      __image = await ImagePicker().pickImage(source: source,imageQuality: 50);
      final file = File(__image!.path);
      if (__image != null) {
        var snapshot = await __storage
            .ref()
            .child("profile/${__user!.email}")
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        __store.collection("recruiters").doc(__user!.uid).update({
          'imageUrl': downloadUrl,
        });
        MySnackBar(context, "Your profile updated");
        notifyListeners();
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> updateLogo(context, ImageSource source) async {
    try {
      __image = await ImagePicker().pickImage(source: source,imageQuality: 50);
      final file = File(__image!.path);
      if (__image != null) {
        var snapshot = await __storage
            .ref()
            .child("logo/${__user!.uid}")
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        __store.collection("recruiters").doc(__user!.uid).update({
          'logoUrl': downloadUrl,
        });
        MySnackBar(context, "Your logo updated");
        notifyListeners();
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> updateRecruiterId(context, String id) async {
    try {
      __store.collection("recruiters").doc(__user!.uid).update({
        'recruiterId': id,
      }).then((value) {
        MySnackBar(context, "Update successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
    }
  }
}
