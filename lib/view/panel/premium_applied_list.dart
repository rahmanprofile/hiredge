import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/view/panel/profile_panel.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/post_controller.dart';
import '../components/user_card.dart';
import 'notification_page.dart';

class PremiumAppliedList extends StatefulWidget {
  const PremiumAppliedList({Key? key}) : super(key: key);

  @override
  State<PremiumAppliedList> createState() => _PremiumAppliedListState();
}

class _PremiumAppliedListState extends State<PremiumAppliedList> {
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
        final images = data.data()!['personal']['imageUrl'];
        setState(() {
          imageUrl = images;
        });
      }
    }
  }

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
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
                            errorWidget: (context, url, error) => Icon(Icons.error),
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
                  "Discovered \nPremium Non-Applicants List",
                  style: GoogleFonts.roboto(
                      fontSize: 23, fontWeight: FontWeight.w500),
                ),
                Text(
                  "I always recommend to hire these premium people.",
                  style: GoogleFonts.roboto(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search users or applicants . . .",
                        suffixIcon: Icon(CupertinoIcons.search),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("premium-apply").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return UserCard(
                              name: snapshot.data!.docs[index]['name'],
                              email: snapshot.data!.docs[index]['email'],
                              phone: snapshot.data!.docs[index]['phone'],
                              skill: snapshot.data!.docs[index]['skill'],
                              experience: snapshot.data!.docs[index]['experience'],
                              imageUrl: snapshot.data!.docs[index]['imageUrl'],
                              appliedOn: snapshot.data!.docs[index]['jobName'],
                              onMail: () async {
                                var path = snapshot.data!.docs[index]['email'];
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
                                var phones = "tel://+91${snapshot.data!.docs[index]['phone']}";
                                if (await canLaunchUrl(Uri.parse(phones))) {
                                  await launchUrl(Uri.parse(phones));
                                }
                                throw "could not launch on $phones";
                              },
                              onHired: () {
                                Provider.of<PostController>(context, listen: false).hiredUser(
                                  context,
                                  snapshot.data!.docs[index]['name'],
                                  snapshot.data!.docs[index]['email'],
                                  snapshot.data!.docs[index]['imageUrl'],
                                  snapshot.data!.docs[index]['skill'],
                                  snapshot.data!.docs[index]['experience'],
                                  snapshot.data!.docs[index]['phone'],
                                  __user!.uid,
                                );
                              },
                            );
                          }
                          );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
