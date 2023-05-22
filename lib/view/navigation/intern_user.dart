import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../controller/constant.dart';
class InternUser extends StatefulWidget {
  const InternUser({Key? key}) : super(key: key);

  @override
  State<InternUser> createState() => _InternUserState();
}

class _InternUserState extends State<InternUser> {
  final auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softColor,
        body: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
          },
        )
    );
  }
}
