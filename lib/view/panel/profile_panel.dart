import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobkar_pro/controller/constant.dart';
import 'package:jobkar_pro/controller/update_controller.dart';
import 'package:jobkar_pro/view/page/form/update_orgnization_details.dart';
import 'package:jobkar_pro/view/page/form/update_user_details.dart';
import 'package:jobkar_pro/view/panel/feedback_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../controller/auth_controller.dart';

class ProfilePanel extends StatefulWidget {
  const ProfilePanel({Key? key}) : super(key: key);

  @override
  State<ProfilePanel> createState() => _ProfilePanelState();
}

class _ProfilePanelState extends State<ProfilePanel> {
  @override
  void initState() {
    __data();
    checkEmailVerificationStatus();
    super.initState();
  }

  final __user = FirebaseAuth.instance.currentUser;
  final __store = FirebaseFirestore.instance;
  String? name;
  String? email;
  String? phone;
  String? imageUrl;
  String? company;
  String? location;
  String? recruiterId;
  String? imageOrg;
  __data() async {
    if (__user != null) {
      final data =
          await __store.collection("recruiters").doc(__user!.uid).get();
      if (data.exists) {
        final names = data.data()!['name'];
        final emails = data.data()!['email'];
        final phones = data.data()!['phone'];
        final images = data.data()!['imageUrl'];
        final companies = data.data()!['organisation-name'];
        final locations = data.data()!['org-location'];
        final image = data.data()!['logoUrl'];
        final recId = data.data()!['recruiterId'];
        setState(() {
          name = names;
          email = emails;
          phone = phones;
          imageUrl = images;
          company = companies;
          location = locations;
          imageOrg = image;
          recruiterId = recId;
        });
      }
    }
  }
  bool _isEmailVerified = false;
  void checkEmailVerificationStatus() async {
    bool isVerified = await AuthController().isEmailVerified();
    setState(() {
      _isEmailVerified = isVerified;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.cyan.withOpacity(1.0),
                      border: Border.all(color: Colors.black12),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: -40,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      onTap: () async {
                                        Provider.of<UpdateController>(context,
                                                listen: false)
                                            .updateImage(
                                                context, ImageSource.camera);
                                      },
                                      leading: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: const Center(
                                          child: Icon(LineAwesomeIcons.camera),
                                        ),
                                      ),
                                      title: Text(
                                        "Camera",
                                        style: GoogleFonts.roboto(),
                                      ),
                                      subtitle: Text(
                                        "Select from camera",
                                        style: GoogleFonts.roboto(),
                                      ),
                                      trailing: const Icon(
                                          CupertinoIcons.chevron_right,
                                          size: 18),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Provider.of<UpdateController>(context,
                                                listen: false)
                                            .updateImage(
                                                context, ImageSource.gallery);
                                      },
                                      leading: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: const Center(
                                          child: Icon(
                                              LineAwesomeIcons.envira_gallery),
                                        ),
                                      ),
                                      title: Text(
                                        "Gallery",
                                        style: GoogleFonts.roboto(),
                                      ),
                                      subtitle: Text(
                                        "Select from gallery",
                                        style: GoogleFonts.roboto(),
                                      ),
                                      trailing: const Icon(
                                          CupertinoIcons.chevron_right,
                                          size: 18),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                          height: 90,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(2)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: imageUrl.toString(),
                            placeholder: (context, url) => Icon(CupertinoIcons.person),
                            errorWidget: (context, url, error) => Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: -12,
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12)),
                      child: const Center(
                        child: Icon(CupertinoIcons.checkmark_seal_fill,
                            color: Colors.cyan, size: 16),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: InkWell(
                      onTap: () {
                        Provider.of<UpdateController>(context, listen: false)
                            .updateLogo(context, ImageSource.gallery);
                      },
                      child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: Colors.black12)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: imageOrg.toString(),
                            placeholder: (context, url) => Icon(CupertinoIcons.person),
                            errorWidget: (context, url, error) => Icon(LineAwesomeIcons.building),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LineAwesomeIcons.user),
                  const SizedBox(width: 5),
                  Text(
                    name.toString(),
                    style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              Text(
                "Email : ${email.toString()}",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              Text(
                "Phone : ${phone.toString()}",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              recruiterId == '' ?  Text(
                "uid : user@recruiter",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.cyan),
              ) : Text(
                "uid : ${recruiterId.toString()}@recruiter",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.cyan),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LineAwesomeIcons.building),
                  const SizedBox(width: 5),
                  Text(
                    "Organisation",
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              Text(
                "Company : $company",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              Text(
                "Location : $location",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LineAwesomeIcons.handshake),
                  const SizedBox(width: 5),
                  Text(
                    "Support",
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              Text(
                "Technical : technical@jobkar.net",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              Text(
                "Payment : payment@jobkar.net",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              Text(
                "Service : service@jobkar.net",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              Text(
                "Website : https://jobkar.net",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.cyan),
              ),
              Text(
                "Phone : +919876543210",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.cyan),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(LineAwesomeIcons.feather),
                  const SizedBox(width: 5),
                  Text(
                    "Feedback",
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
              Text(
                "Please write a feedback, What we can improve services & what we can do for you. If you are facing any issue please share with us.",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedbackPage()));
                },
                child: Text(
                  "Click Here",
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.cyan),
                ),
              ),
              const SizedBox(height: 20),
              if (_isEmailVerified == true)
                Container()
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)
                    )
                  ),
                  onPressed: () {
                    __user?.sendEmailVerification();
                  },
                  child: Text('Verify Email'),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              builder: (context) {
                return SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UpdateUser()));
                        },
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: softColor,
                          ),
                          child: const Center(
                            child: Icon(LineAwesomeIcons.user,
                                size: 20, color: Colors.black),
                          ),
                        ),
                        title: Text(
                          "Personal",
                          style: GoogleFonts.roboto(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          "Update your personal details",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.black54),
                        ),
                        trailing:
                            const Icon(CupertinoIcons.chevron_right, size: 18),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UpdateOrganization()));
                        },
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: softColor,
                          ),
                          child: const Center(
                            child: Icon(LineAwesomeIcons.building,
                                size: 20, color: Colors.black),
                          ),
                        ),
                        title: Text(
                          "Organisation",
                          style: GoogleFonts.roboto(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          "Update your organization details",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.black54),
                        ),
                        trailing:
                            const Icon(CupertinoIcons.chevron_right, size: 18),
                      ),
                      // ListTile(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //             const DocumentPage()));
                      //   },
                      //   leading: Container(
                      //     height: 40,
                      //     width: 40,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(2),
                      //       color: softColor,
                      //     ),
                      //     child: const Center(
                      //       child: Icon(LineAwesomeIcons.dochub,
                      //           size: 20, color: Colors.black),
                      //     ),
                      //   ),
                      //   title: Text(
                      //     "Document",
                      //     style: GoogleFonts.roboto(
                      //         fontSize: 15, fontWeight: FontWeight.w400),
                      //   ),
                      //   subtitle: Text(
                      //     "Manage your personal document",
                      //     style: GoogleFonts.roboto(
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w300,
                      //         color: Colors.black54),
                      //   ),
                      //   trailing:
                      //   const Icon(CupertinoIcons.chevron_right, size: 18),
                      // ),
                      ListTile(
                        onTap: () => {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Alert",
                                  style: GoogleFonts.roboto(fontSize: 18),
                                ),
                                content: Text(
                                  "Are you sure want to logout",
                                  style: GoogleFonts.roboto(fontSize: 13),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "No",
                                      style: GoogleFonts.roboto(
                                          color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      if (__user != null) {
                                        Provider.of<AuthController>(context,
                                                listen: false)
                                            .signOut(context);
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      "Yes",
                                      style: GoogleFonts.roboto(
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        },
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: softColor,
                          ),
                          child: const Center(
                            child: Icon(LineAwesomeIcons.alternate_sign_out,
                                size: 20, color: Colors.black),
                          ),
                        ),
                        title: Text(
                          "Logout",
                          style: GoogleFonts.roboto(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          "Signout from phone",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.black54),
                        ),
                        trailing:
                            const Icon(CupertinoIcons.chevron_right, size: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.roboto(color: Colors.cyan),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: const Icon(LineAwesomeIcons.edit),
      ),
    );
  }
}
