import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/controller/constant.dart';
import 'package:jobkar_pro/controller/data_controller.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'notification_page.dart';
import 'profile_panel.dart';

class MemberGroup extends StatefulWidget {
  const MemberGroup({Key? key}) : super(key: key);

  @override
  State<MemberGroup> createState() => _MemberGroupState();
}

class _MemberGroupState extends State<MemberGroup> {
  @override
  void initState() {
    __data();
    super.initState();
  }

  final __user = FirebaseAuth.instance.currentUser;
  final __store = FirebaseFirestore.instance;
  String? imageUrl;
  String name = '';
  String email = '';
  String phone = '';
  String organization = '';
  __data() async {
    if (__user != null) {
      final data =
          await __store.collection("recruiters").doc(__user!.uid).get();
      if (data.exists) {
        final images = data.data()!['imageUrl'];
        final names = data.data()!['name'];
        final emails = data.data()!['email'];
        final phones = data.data()!['phone'];
        final organizations = data.data()!['organisation'];
        setState(
          () {
            imageUrl = images;
            name = names;
            email = emails;
            phone = phones;
            organization = organizations;
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePanel()));
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: imageUrl.toString(),
                          placeholder: (context, url) => Icon(CupertinoIcons.person),
                          errorWidget: (context, url, error) => Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const NotificationPage()));
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(LineAwesomeIcons.bell),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Connect With \nDevelopment Community",
                style: GoogleFonts.roboto(
                    fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8.0),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: softColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Icon(CupertinoIcons.chart_bar,
                                      size: 40, color: Colors.black54),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Artificial Intelligent",
                                    style: GoogleFonts.roboto(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Intelligence Product Development",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Hiredge Intelligence Community",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Followers : 334K+",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        Provider.of<DataController>(context, listen: false)
                            .database(
                          context,
                          name.toString(),
                          email.toString(),
                          phone.toString(),
                          imageUrl.toString(),
                          organization.toString(),
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xFF0071ff),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Join",
                            style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: softColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Icon(CupertinoIcons.app_badge,
                                      size: 40, color: Colors.black54),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Machine Learning",
                                    style: GoogleFonts.roboto(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Product of Artificial Inetelligence",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Hiredge Intelligence Community",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Followers : 189K+",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        Provider.of<DataController>(context, listen: false)
                            .database(
                          context,
                          name.toString(),
                          email.toString(),
                          phone.toString(),
                          imageUrl.toString(),
                          organization.toString(),
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xFF0071ff),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Join",
                            style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: softColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Icon(CupertinoIcons.dial,
                                      size: 40, color: Colors.black54),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Data Science",
                                    style: GoogleFonts.roboto(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Product Management",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Hiredge Intelligence Community",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Followers : 521K+",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        Provider.of<DataController>(context, listen: false)
                            .database(
                          context,
                          name.toString(),
                          email.toString(),
                          phone.toString(),
                          imageUrl.toString(),
                          organization.toString(),
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xFF0071ff),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Join",
                            style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: softColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Icon(CupertinoIcons.function,
                                      size: 40, color: Colors.black54),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Deep Learning",
                                    style: GoogleFonts.roboto(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Deep learning solution",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Hiredge Intelligence Community",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Followers : 301K+",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: (){
                        Provider.of<DataController>(context, listen: false).database(context,
                          name.toString(),
                          email.toString(),
                          phone.toString(),
                          imageUrl.toString(),
                          organization.toString(),
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xFF0071ff),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Join",
                            style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: softColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Icon(CupertinoIcons.antenna_radiowaves_left_right,
                                      size: 40, color: Colors.black54),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Matrix Development",
                                    style: GoogleFonts.roboto(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Advanced Future Production",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Hiredge Intelligence Community",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Followers : 956K+",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        Provider.of<DataController>(context, listen: false)
                            .database(
                          context,
                          name.toString(),
                          email.toString(),
                          phone.toString(),
                          imageUrl.toString(),
                          organization.toString(),
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xFF0071ff),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Join",
                            style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: softColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Icon(CupertinoIcons.timer,
                                      size: 40, color: Colors.black54),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "SCI-FI",
                                    style: GoogleFonts.roboto(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Scientific Future Intelligence",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Hiredge Intelligence Community",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                  Text(
                                    "Followers : 1196K+",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
                        Provider.of<DataController>(context, listen: false)
                            .database(
                          context,
                          name.toString(),
                          email.toString(),
                          phone.toString(),
                          imageUrl.toString(),
                          organization.toString(),
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xFF0071ff),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Join",
                            style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
