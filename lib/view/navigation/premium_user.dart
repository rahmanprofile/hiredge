import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/constant.dart';
import '../page/form/create_jobs.dart';
import '../page/human_search_page.dart';

class PremiumUser extends StatefulWidget {
  const PremiumUser({Key? key}) : super(key: key);

  @override
  State<PremiumUser> createState() => _PremiumUserState();
}

class _PremiumUserState extends State<PremiumUser> {
  final auth = FirebaseAuth.instance.currentUser;
  List<CreateJobs> createJobList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        iconTheme:const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            SvgPicture.asset("assets/img/bag_search_find_icon.svg",color: Colors.white),
            const SizedBox(width: 5.0),
            Text(
              "Premium",
              style:
                  GoogleFonts.roboto(fontSize: 20, color: Colors.white,fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HumanSearchPage(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.search, size: 20),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                  padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recommendation",style: GoogleFonts.roboto(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.red)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black12,
                        ),
                      ),
                      Text("I always recommend you to hire premium people.",style: GoogleFonts.roboto(fontSize: 13,fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 25,
                      width: 120,
                      decoration:const BoxDecoration(
                        color: Colors.orange,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Recommended",style: GoogleFonts.roboto(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),),
                            const SizedBox(width: 4),
                            const Icon(CupertinoIcons.checkmark_seal_fill,size: 13,color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        vertical: 10.0,
                      ),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Narayana Singh",
                                style: GoogleFonts.roboto(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              const Spacer(),
                              Text(
                                "Traction : 6/10 |",
                                style: GoogleFonts.roboto(
                                  color: Colors.red,
                                    fontSize: 10, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                "Core : 8/10",
                                style: GoogleFonts.roboto(
                                  color: Colors.red,
                                    fontSize: 10, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.zero,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Text(
                            "Phone : +918052399848",
                            style: GoogleFonts.roboto(
                                fontSize: 10,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Email : narayan@gmail.com",
                            style: GoogleFonts.roboto(
                                fontSize: 10,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "experience : Two years of experience",
                            style: GoogleFonts.roboto(
                                fontSize: 10,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Skills : ",
                                style: GoogleFonts.roboto(
                                    fontSize: 10,color: Colors.black54,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(width: 5.0),
                              Expanded(
                                child: Text(
                                  "Flutter Development, React JS, Firebase , Postman, Bloc, React Native, Provider, Python, Javascript",
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Opinion : ",
                                style: GoogleFonts.roboto(
                                    fontSize: 10,color: Colors.black54,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(width: 5.0),
                              Expanded(
                                child: Text(
                                  "I have strong development knowledge in development i can handle project alone",
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
