import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jobkar_pro/view/page/post/overview_job.dart';
import 'package:jobkar_pro/view/panel/profile_panel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/controller/post_controller.dart';
import 'package:jobkar_pro/view/page/form/create_jobs.dart';
import 'package:jobkar_pro/view/page/post_card.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../page/form/create_internship.dart';
import 'notification_page.dart';

class PostPanel extends StatefulWidget {
  const PostPanel({Key? key}) : super(key: key);

  @override
  State<PostPanel> createState() => _PostPanelState();
}

class _PostPanelState extends State<PostPanel> {
  @override
  void initState() {
    __data();
    super.initState();
  }

  final __user = FirebaseAuth.instance.currentUser;
  final __store = FirebaseFirestore.instance;
  String imageUrl = '';
  __data() async {
    if (__user != null) {
      final data =
          await __store.collection("recruiters").doc(__user!.uid).get();
      if (data.exists) {
        final images = data.data()!['imageUrl'];
        setState(
          () {
            imageUrl = images;
          },
        );
      }
    }
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final searchController = TextEditingController();
  String searchItem = '';

  @override
  Widget build(BuildContext context) {
    final collection1 = FirebaseFirestore.instance.collection("post-jobs");
    final collection2 =
        FirebaseFirestore.instance.collection("post-internships");
    final combinedStream = Rx.combineLatest2(
      collection1.where("adminId", isEqualTo: uid).snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((documentSnapshot) => documentSnapshot)
              .toList()),
      collection2.where("adminId", isEqualTo: uid).snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((documentSnapshot) => documentSnapshot)
              .toList()),
      (collection1Docs, collection2Docs) => [collection1Docs, collection2Docs],
    );
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePanel()));
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
                            placeholder: (context, url) =>
                                Icon(CupertinoIcons.person),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.person),
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
                  "Discover \nThe Perfect Dashboard",
                  style: GoogleFonts.roboto(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: CupertinoSearchTextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchItem = value;
                      });
                    },
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                StreamBuilder<List<List<DocumentSnapshot<Object?>>>>(
                  stream: combinedStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<List<DocumentSnapshot<Object?>>>>
                          snapshot) {
                    if (snapshot.hasData) {
                      final List<List<DocumentSnapshot<Object?>>> data =
                          snapshot.data!;
                      final List<DocumentSnapshot<Object?>> collection1Docs =
                          data[0];
                      final List<DocumentSnapshot<Object?>> collection2Docs =
                          data[1];
                      return ListView.builder(
                        itemCount:
                            collection1Docs.length + collection2Docs.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index < collection1Docs.length) {
                            String searchData =
                                collection1Docs[index]['jobName'];
                            if (searchController.text.isEmpty) {
                              return PostCard(
                                endSalary: collection1Docs[index]['endSalary'],
                                jobName: collection1Docs[index]['jobName'],
                                company: collection1Docs[index]['company'],
                                jobFor: collection1Docs[index]['jobFor'],
                                newSalary: collection1Docs[index]['newSalary'],
                                type: collection1Docs[index]['type'],
                                orgLogo: collection1Docs[index]['logoUrl'],
                                onView: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobOverview(
                                        id: collection1Docs[index].id,
                                        imageUrl: collection1Docs[index]
                                            ['logoUrl'],
                                        company: collection1Docs[index]
                                            ['company'],
                                        type: collection1Docs[index]['type'],
                                        jobName: collection1Docs[index]
                                            ['jobName'],
                                        endSalary: collection1Docs[index]
                                            ['endSalary'],
                                        newSalary: collection1Docs[index]
                                            ['newSalary'],
                                        address: collection1Docs[index]
                                            ['address'],
                                        jobFor: collection1Docs[index]
                                            ['jobFor'],
                                        quantity: collection1Docs[index]
                                            ['quantity'],
                                        requirement: collection1Docs[index]
                                            ['requirement'],
                                        responsibility: collection1Docs[index]
                                            ['responsibility'],
                                        onDelete: () {
                                          Provider.of<PostController>(context,
                                                  listen: false)
                                              .deleteInternshipPost(
                                                  collection1Docs[index].id);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                onDelete: () {
                                  Provider.of<PostController>(context,
                                          listen: false)
                                      .deleteJobPost(collection1Docs[index].id);
                                },
                              );
                            } else if (searchData.toUpperCase().contains(
                                    searchController.text.toString()) ||
                                searchData.toLowerCase().contains(
                                    searchController.text.toString())) {
                              return PostCard(
                                endSalary: collection1Docs[index]['endSalary'],
                                jobName: collection1Docs[index]['jobName'],
                                company: collection1Docs[index]['company'],
                                jobFor: collection1Docs[index]['jobFor'],
                                newSalary: collection1Docs[index]['newSalary'],
                                type: collection1Docs[index]['type'],
                                orgLogo: collection1Docs[index]['logoUrl'],
                                onView: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobOverview(
                                        id: collection1Docs[index].id,
                                        imageUrl: collection1Docs[index]
                                            ['logoUrl'],
                                        company: collection1Docs[index]
                                            ['company'],
                                        type: collection1Docs[index]['type'],
                                        jobName: collection1Docs[index]
                                            ['jobName'],
                                        endSalary: collection1Docs[index]
                                            ['endSalary'],
                                        newSalary: collection1Docs[index]
                                            ['newSalary'],
                                        address: collection1Docs[index]
                                            ['address'],
                                        jobFor: collection1Docs[index]
                                            ['jobFor'],
                                        quantity: collection1Docs[index]
                                            ['quantity'],
                                        requirement: collection1Docs[index]
                                            ['requirement'],
                                        responsibility: collection1Docs[index]
                                            ['responsibility'],
                                        onDelete: () {
                                          Provider.of<PostController>(context,
                                                  listen: false)
                                              .deleteInternshipPost(
                                                  collection1Docs[index].id);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                onDelete: () {
                                  Provider.of<PostController>(context,
                                          listen: false)
                                      .deleteJobPost(collection1Docs[index].id);
                                },
                              );
                            }
                          } else {
                            final int newIndex = index - collection1Docs.length;
                            String searchData =
                                collection2Docs[newIndex]['jobName'];
                            if (searchController.text.isEmpty) {
                              return PostCard(
                                endSalary: collection2Docs[newIndex]
                                    ['endSalary'],
                                jobName: collection2Docs[newIndex]['jobName'],
                                company: collection2Docs[newIndex]['company'],
                                jobFor: collection2Docs[newIndex]['jobFor'],
                                newSalary: collection2Docs[newIndex]
                                    ['newSalary'],
                                type: collection2Docs[newIndex]['type'],
                                orgLogo: collection2Docs[newIndex]['logoUrl'],
                                onView: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobOverview(
                                        id: collection2Docs[newIndex].id,
                                        imageUrl: collection2Docs[newIndex]
                                            ['logoUrl'],
                                        company: collection2Docs[newIndex]
                                            ['company'],
                                        type: collection2Docs[newIndex]['type'],
                                        jobName: collection2Docs[newIndex]
                                            ['jobName'],
                                        endSalary: collection2Docs[newIndex]
                                            ['endSalary'],
                                        newSalary: collection2Docs[newIndex]
                                            ['newSalary'],
                                        address: collection2Docs[newIndex]
                                            ['address'],
                                        jobFor: collection2Docs[newIndex]
                                            ['jobFor'],
                                        quantity: collection2Docs[newIndex]
                                            ['quantity'],
                                        requirement: collection2Docs[newIndex]
                                            ['requirement'],
                                        responsibility:
                                            collection2Docs[newIndex]
                                                ['responsibility'],
                                        onDelete: () {
                                          Provider.of<PostController>(context,
                                                  listen: false)
                                              .deleteInternshipPost(
                                                  collection2Docs[newIndex].id);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                onDelete: () {
                                  Provider.of<PostController>(context,
                                          listen: false)
                                      .deleteInternshipPost(
                                          collection2Docs[newIndex].id);
                                },
                              );
                            } else if (searchData.toUpperCase().contains(
                                    searchController.text.toString()) ||
                                searchData.toLowerCase().contains(
                                    searchController.text.toString())) {
                              return PostCard(
                                endSalary: collection2Docs[newIndex]
                                    ['endSalary'],
                                jobName: collection2Docs[newIndex]['jobName'],
                                company: collection2Docs[newIndex]['company'],
                                jobFor: collection2Docs[newIndex]['jobFor'],
                                newSalary: collection2Docs[newIndex]
                                    ['newSalary'],
                                type: collection2Docs[newIndex]['type'],
                                orgLogo: collection2Docs[newIndex]['logoUrl'],
                                onView: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobOverview(
                                        id: collection2Docs[newIndex].id,
                                        imageUrl: collection2Docs[newIndex]
                                            ['logoUrl'],
                                        company: collection2Docs[newIndex]
                                            ['company'],
                                        type: collection2Docs[newIndex]['type'],
                                        jobName: collection2Docs[newIndex]
                                            ['jobName'],
                                        endSalary: collection2Docs[newIndex]
                                            ['endSalary'],
                                        newSalary: collection2Docs[newIndex]
                                            ['newSalary'],
                                        address: collection2Docs[newIndex]
                                            ['address'],
                                        jobFor: collection2Docs[newIndex]
                                            ['jobFor'],
                                        quantity: collection2Docs[newIndex]
                                            ['quantity'],
                                        requirement: collection2Docs[newIndex]
                                            ['requirement'],
                                        responsibility:
                                            collection2Docs[newIndex]
                                                ['responsibility'],
                                        onDelete: () {
                                          Provider.of<PostController>(context,
                                                  listen: false)
                                              .deleteInternshipPost(
                                                  collection2Docs[newIndex].id);
                                        },
                                      ),
                                    ),
                                  );
                                },
                                onDelete: () {
                                  Provider.of<PostController>(context,
                                          listen: false)
                                      .deleteInternshipPost(
                                          collection2Docs[newIndex].id);
                                },
                              );
                            }
                          }
                          return Container();
                        },
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.white,
            context: context,
            builder: (context) {
              return SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateJobs()));
                        },
                        child: Text(
                          "Create jobs",
                          style: GoogleFonts.roboto(
                              fontSize: 14, color: Colors.black),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateInternship(),
                            ),
                          );
                        },
                        child: Text(
                          "Create internship",
                          style: GoogleFonts.roboto(
                              fontSize: 14, color: Colors.black),
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: const Icon(
          LineAwesomeIcons.chevron_circle_right,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
} /**/
