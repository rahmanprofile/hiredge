import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/view/components/hired_user.dart';
import 'package:jobkar_pro/view/panel/profile_panel.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'notification_page.dart';

class HiredPanel extends StatefulWidget {
  const HiredPanel({Key? key}) : super(key: key);

  @override
  State<HiredPanel> createState() => _HiredPanelState();
}

class _HiredPanelState extends State<HiredPanel> {
  @override
  void initState() {
    __data();
    super.initState();
  }
  final __user = FirebaseAuth.instance.currentUser;
  final __store = FirebaseFirestore.instance;
  String? imageUrl;
  __data() async {
    if (__user != null) {
      final data =
          await __store.collection("recruiters").doc(__user!.uid).get();
      if (data.exists) {
        final images = data.data()!['imageUrl'];
        setState(() {
          imageUrl = images;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                        border: Border.all(color: Colors.black12),
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
                              builder: (context) => const NotificationPage()));
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
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
                "Discover \nThe Hired Applicants",
                style: GoogleFonts.roboto(
                    fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8.0),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("hired-users").where("adminId",isEqualTo: __user!.uid).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 200.0),
                        child: Text("no users found. . ."),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HiredUser(
                        name: snapshot.data!.docs[index]['name'],
                        email: snapshot.data!.docs[index]['email'],
                        phone: snapshot.data!.docs[index]['phone'],
                        skill: snapshot.data!.docs[index]['skill'],
                        experience: snapshot.data!.docs[index]['experience'],
                        imageUrl: snapshot.data!.docs[index]['imageUrl'],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
