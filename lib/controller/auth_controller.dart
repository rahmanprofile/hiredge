import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobkar_pro/view/components/mysnackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/navigation/navigation_home.dart';
import '../view/page/service/signin.dart';

class AuthController extends ChangeNotifier {
  final __user = FirebaseAuth.instance;
  final __store = FirebaseFirestore.instance;

  Future<void> signIn({required String email, required String password, context}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user = await __user.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        prefs.setString("sign_email", email);
        prefs.setString("sign_password", password);
        final currentUser = __user.currentUser;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NavigationHome()),
            (route) => false);
        final token = await currentUser!.getIdToken();
        prefs.setString("token", token);
        notifyListeners();
      }
    } on FirebaseException catch (e) {
      MySnackBar(context, e.message.toString());
      notifyListeners();
    }
  }

  Future<void> signOut(context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await __user.signOut().then((value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
          (route) => false));
      prefs.remove('token');
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<void> signUp(context, String email, String name, String password, String phone) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user = await __user.createUserWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
      if (user != null) {
        final userData = {
          "adminId" : __user.currentUser!.uid,
          "name" : name,
          "email" : email,
          "phone" : phone,
          "password" : password,
          "imageUrl" : "",
          "logoUrl" : "",
          'org-location': '',
          'organisation-name': '',
          "recruiterId" : "",
          "time" : DateTime.now(),
          "privacy-policy" : "$name are happily agree with our privacy & policy",
          "terms-conditions" : "$name are happily agree with our terms & conditions",
          "agree-time" : DateTime.now(),
        };
        final currentUser = __user.currentUser;
        await __store
            .collection("recruiters")
            .doc(__user.currentUser!.uid)
            .set(userData)
            .then((value) {
          prefs.setString("myName", name);
          prefs.setString("myEmail", email);
          prefs.setString("myPhone", phone);
          prefs.setString("myPassword", password);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigationHome(),
              ),
              (route) => false);
        });
        final token = await currentUser!.getIdToken();
        prefs.setString("token", token);
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak.')));
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The account already exists for that email.')));
        notifyListeners();
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      notifyListeners();
    }
  }

  Future<void> deleteAccount(context) async {
    final user = __user.currentUser;
    final _db = __store.collection("recruiters");
    try {
      await user!.delete();
      await _db.doc(user.uid).delete().then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignIn()),
            (route) => false);
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      MySnackBar(context, e.message.toString());
      notifyListeners();
    }
  }

  bool isEmailVerified() {
    User? user = __user.currentUser;
    __user.currentUser!.reload();
    notifyListeners();
    return user != null && user.emailVerified;
  }

}
