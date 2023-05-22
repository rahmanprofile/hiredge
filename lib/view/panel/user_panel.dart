import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/controller/post_controller.dart';
import 'package:jobkar_pro/view/components/user_card.dart';
import 'package:jobkar_pro/view/panel/notification_page.dart';
import 'package:jobkar_pro/view/panel/profile_panel.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPanel extends StatefulWidget {
  const UserPanel({Key? key}) : super(key: key);

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  @override
  void initState() {
    super.initState();
    __data();
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

  final searchController = TextEditingController();
  String searchData = '';
  @override
  Widget build(BuildContext context) {
    final collection1 = FirebaseFirestore.instance.collection("apply-internships");
    final collection2 = FirebaseFirestore.instance.collection("apply-jobs");
    final combinedStream = Rx.combineLatest2(
      collection1.where("adminId", isEqualTo: __user!.uid).snapshots().map(
              (querySnapshot) => querySnapshot.docs
              .map((documentSnapshot) => documentSnapshot)
              .toList()),
      collection2.where("adminId", isEqualTo: __user!.uid).snapshots().map(
              (querySnapshot) => querySnapshot.docs
              .map((documentSnapshot) => documentSnapshot)
              .toList()),
          (collection1Docs, collection2Docs) => [collection1Docs, collection2Docs],
    );
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationPage()));
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
                          child: Icon(LineAwesomeIcons.bell,
                              size: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Discovered \nApplied Applicants List",
                  style:
                      GoogleFonts.roboto(fontSize: 23, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchData = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search applicants",
                        suffixIcon: Icon(CupertinoIcons.search),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                StreamBuilder<List<List<DocumentSnapshot<Object?>>>>(
                  stream: combinedStream,
                  builder: (BuildContext context, AsyncSnapshot<List<List<DocumentSnapshot<Object?>>>> snapshot) {
                    if (snapshot.hasData) {
                      final List<List<DocumentSnapshot<Object?>>> data = snapshot.data!;
                      final List<DocumentSnapshot<Object?>> collection1Docs = data[0];
                      final List<DocumentSnapshot<Object?>> collection2Docs = data[1];
                      return ListView.builder(
                        itemCount: collection1Docs.length + collection2Docs.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index < collection1Docs.length) {
                            String searchData = collection1Docs[index]['name'];
                            if (searchController.text.isEmpty) {
                              return UserCard(
                                name: collection1Docs[index]['name'],
                                email: collection1Docs[index]['email'],
                                phone: collection1Docs[index]['phone'],
                                skill: collection1Docs[index]['skill'],
                                experience: collection1Docs[index]['experience'],
                                imageUrl: collection1Docs[index]['imageUrl'],
                                appliedOn: collection1Docs[index]['jobName'],
                                onMail: () async {
                                  var path = collection1Docs[index]['email'];
                                  final Uri params = Uri(
                                    scheme: "mailTo",
                                    path: path,
                                    query: 'subject=Example Subject&body=Example Body',
                                  );
                                  if (await canLaunchUrl(params)) {
                                    await launchUrl(params);
                                  } else {
                                    throw "could not launch on $params";
                                  }
                                },
                                onCall: () async {
                                  var phones = "tel://+91${collection1Docs[index]['phone']}";
                                  if (await canLaunchUrl(Uri.parse(phones))) {
                                    await launchUrl(Uri.parse(phones));
                                  }
                                  throw "could not launch on $phones";
                                },
                                onHired: () {
                                  Provider.of<PostController>(context, listen: false).hiredUser(
                                    context,
                                    collection1Docs[index]['name'],
                                    collection1Docs[index]['email'],
                                    collection1Docs[index]['imageUrl'],
                                    collection1Docs[index]['skill'],
                                    collection1Docs[index]['experience'],
                                    collection1Docs[index]['phone'],
                                    collection1Docs[index]['adminId'],
                                  );
                                },
                              );
                            } else if (searchData.toUpperCase().contains(searchController.text.toString()) ||
                                searchData.toLowerCase().contains(searchController.text.toString())) {
                              return UserCard(
                                name: collection1Docs[index]['name'],
                                email: collection1Docs[index]['email'],
                                phone: collection1Docs[index]['phone'],
                                skill: collection1Docs[index]['skill'],
                                experience: collection1Docs[index]['experience'],
                                imageUrl: collection1Docs[index]['imageUrl'],
                                appliedOn: collection1Docs[index]['jobName'],
                                onMail: () async {
                                  var path = collection1Docs[index]['email'];
                                  final Uri params = Uri(
                                    scheme: "mailTo",
                                    path: path,
                                    query: 'subject=Example Subject&body=Example Body',
                                  );
                                  if (await canLaunchUrl(params)) {
                                    await launchUrl(params);
                                  } else {
                                    throw "could not launch on $params";
                                  }
                                },
                                onCall: () async {
                                  var phones = "tel://+91${collection1Docs[index]['phone']}";
                                  if (await canLaunchUrl(Uri.parse(phones))) {
                                    await launchUrl(Uri.parse(phones));
                                  }
                                  throw "could not launch on $phones";
                                },
                                onHired: () {
                                  Provider.of<PostController>(context, listen: false).hiredUser(
                                    context,
                                    collection1Docs[index]['name'],
                                    collection1Docs[index]['email'],
                                    collection1Docs[index]['imageUrl'],
                                    collection1Docs[index]['skill'],
                                    collection1Docs[index]['experience'],
                                    collection1Docs[index]['phone'],
                                    collection1Docs[index]['adminId'],
                                  );
                                },
                              );
                            }
                            return Center(
                              child: Text("No data found"),
                            );

                          } else {
                            final int newIndex = index - collection1Docs.length;
                            String nextData = collection2Docs[newIndex]['name'];
                            if (searchController.text.isEmpty) {
                              return UserCard(
                                name: collection2Docs[newIndex]['name'],
                                email: collection2Docs[newIndex]['email'],
                                phone: collection2Docs[newIndex]['phone'],
                                skill: collection2Docs[newIndex]['skill'],
                                experience: collection2Docs[newIndex]['experience'],
                                imageUrl: collection2Docs[newIndex]['imageUrl'],
                                appliedOn: collection2Docs[newIndex]['jobName'],
                                onMail: () async {
                                  var path = collection1Docs[index]['email'];
                                  final Uri params = Uri(
                                    scheme: "mailTo",
                                    path: path,
                                    query: 'subject=Example Subject&body=Example Body',
                                  );
                                  if (await canLaunchUrl(params)) {
                                    await launchUrl(params);
                                  } else {
                                    throw "could not launch on $params";
                                  }
                                },
                                onCall: () async {
                                  var phones = "tel://+91${collection1Docs[index]['phone']}";
                                  if (await canLaunchUrl(Uri.parse(phones))) {
                                    await launchUrl(Uri.parse(phones));
                                  }
                                  throw "could not launch on $phones";
                                },
                                onHired: () {
                                  Provider.of<PostController>(context, listen: false).hiredUser(
                                    context,
                                    collection2Docs[newIndex]['name'],
                                    collection2Docs[newIndex]['email'],
                                    collection2Docs[newIndex]['imageUrl'],
                                    collection2Docs[newIndex]['skill'],
                                    collection2Docs[newIndex]['experience'],
                                    collection2Docs[newIndex]['phone'],
                                    collection2Docs[newIndex]['adminId'],
                                  );
                                },
                              );
                            } else if (nextData.toLowerCase().contains(searchController.text.toString()) ||
                                nextData.toUpperCase().contains(searchController.toString())) {
                              return UserCard(
                                name: collection2Docs[newIndex]['name'],
                                email: collection2Docs[newIndex]['email'],
                                phone: collection2Docs[newIndex]['phone'],
                                skill: collection2Docs[newIndex]['skill'],
                                experience: collection2Docs[newIndex]['experience'],
                                imageUrl: collection2Docs[newIndex]['imageUrl'],
                                appliedOn: collection2Docs[newIndex]['jobName'],
                                onMail: () async {
                                  var path = collection1Docs[index]['email'];
                                  final Uri params = Uri(
                                    scheme: "mailTo",
                                    path: path,
                                    query: 'subject=Example Subject&body=Example Body',
                                  );
                                  if (await canLaunchUrl(params)) {
                                    await launchUrl(params);
                                  } else {
                                    throw "could not launch on $params";
                                  }
                                },
                                onCall: () async {
                                  var phones = "tel://+91${collection1Docs[index]['phone']}";
                                  if (await canLaunchUrl(Uri.parse(phones))) {
                                    await launchUrl(Uri.parse(phones));
                                  }
                                  throw "could not launch on $phones";
                                },
                                onHired: () {
                                  Provider.of<PostController>(context, listen: false).hiredUser(
                                    context,
                                    collection2Docs[newIndex]['name'],
                                    collection2Docs[newIndex]['email'],
                                    collection2Docs[newIndex]['imageUrl'],
                                    collection2Docs[newIndex]['skill'],
                                    collection2Docs[newIndex]['experience'],
                                    collection2Docs[newIndex]['phone'],
                                    collection2Docs[newIndex]['adminId'],
                                  );
                                },
                              );
                            }
                          }
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
