import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/view/components/user_card.dart';
import '../../../controller/constant.dart';

class JobUser extends StatefulWidget {
  const JobUser({Key? key}) : super(key: key);

  @override
  State<JobUser> createState() => _JobUserState();
}

class _JobUserState extends State<JobUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
