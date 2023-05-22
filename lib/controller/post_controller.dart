import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:jobkar_pro/view/components/mysnackbar.dart';

class PostController extends ChangeNotifier {
  final __user = FirebaseAuth.instance.currentUser;
  final __store = FirebaseFirestore.instance;

  Future<void> createJob(
      context,
      String newSalary,
      String endSalary,
      String jobFor,
      String jobName,
      String type,
      String company,
      String quantity,
      String address,
      String requirement,
      String logoUrl,
      String responsibility) async {
    try {
      await __store
          .collection("post-jobs")
          .add({
        "jobName": jobName,
        "jobFor": jobFor,
        "newSalary": newSalary,
        "endSalary": endSalary,
        "company": company,
        "type": type,
        "quantity": quantity,
        "address": address,
        'logoUrl' : logoUrl,
        "requirement": requirement,
        "responsibility": responsibility,
        "time": DateTime.now(),
        "adminId": __user!.uid,
      }).then((value) {
        Navigator.pop(context);
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<void> createInternship(
      context,
      String newSalary,
      String endSalary,
      String jobFor,
      String jobName,
      String type,
      String company,
      String quantity,
      String logoUrl,
      String address,
      String requirement,
      String responsibility) async {
    try {
      await __store
          .collection("post-internships")
          .add({
        "jobName": jobName,
        "jobFor": jobFor,
        "newSalary": newSalary,
        "endSalary": endSalary,
        "company": company,
        "logoUrl" : logoUrl,
        "type": type,
        "quantity": quantity,
        "address": address,
        "requirement": requirement,
        "responsibility": responsibility,
        "time": DateTime.now(),
        "adminId": __user!.uid,
      }).then((value) {
        Navigator.pop(context);
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<void> deleteJobPost(String postId) async {
    __store
        .collection("post-jobs")
        .doc(postId)
        .delete();
    notifyListeners();
  }

  Future<void> deleteInternshipPost(String postId) async {
    __store
        .collection("post-internships")
        .doc(postId)
        .delete();
    notifyListeners();
  }

  Future<void> hiredUser(context, String name, String email, String imageUrl,
      String skill, String experience, String phone, String userId) async {
    __store.collection("hired-users").add({
      "name": name,
      "email": email,
      "phone": phone,
      "skill": skill,
      "experience": experience,
      "imageUrl": imageUrl,
      "userId": userId,
      "adminId": __user!.uid,
      "time": DateTime.now(),
    }).then((value) {
      MySnackBar(context, "User hired successfully");
      notifyListeners();
    });
  }

}
