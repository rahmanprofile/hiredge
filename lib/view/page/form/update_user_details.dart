import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/controller/auth_controller.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../controller/update_controller.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final recruiterIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Update \nYour Information?",
                  style: GoogleFonts.sansita(
                      fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 30),
                Text(
                  "Name *",
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: TextFormField(
                      controller: nameController,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        hintText: "Your good name",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.normal),
                        prefixIcon: const Icon(LineAwesomeIcons.user, size: 18),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            Provider.of<UpdateController>(context, listen: false).updateName(context, nameController.text.trim());
                            nameController.clear();
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              color: Colors.cyan,
                            ),
                            child: const Center(
                              child: Icon(LineAwesomeIcons.chevron_circle_up,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Email *",
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: TextFormField(
                      controller: emailController,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.normal),
                        prefixIcon:
                            const Icon(LineAwesomeIcons.envelope, size: 18),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            Provider.of<UpdateController>(context, listen: false).updateEmail(context, emailController.text.trim());
                            emailController.clear();
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              color: Colors.cyan,
                            ),
                            child: const Center(
                              child: Icon(LineAwesomeIcons.chevron_circle_up,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Phone *",
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: TextFormField(
                      controller: phoneController,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        hintText: "Enter your phone number",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.normal),
                        prefixIcon: const Icon(LineAwesomeIcons.phone, size: 18),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            Provider.of<UpdateController>(context, listen: false).updatePhone(context, phoneController.text.trim());
                            phoneController.clear();
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              color: Colors.cyan,
                            ),
                            child: const Center(
                              child: Icon(LineAwesomeIcons.chevron_circle_up,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Password *",
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: TextFormField(
                      controller: passwordController,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        hintText: "Update your password",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.normal),
                        prefixIcon: const Icon(LineAwesomeIcons.key, size: 18),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            Provider.of<UpdateController>(context, listen: false).updatePassword(context, passwordController.text.trim());
                            passwordController.clear();
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              color: Colors.cyan,
                            ),
                            child: const Center(
                              child: Icon(LineAwesomeIcons.chevron_circle_up,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 20),
                Text(
                  "UID *",
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: TextFormField(
                      controller: recruiterIdController,
                      style: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        hintText: "Update your user identity",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.roboto(
                            fontSize: 14, fontWeight: FontWeight.normal),
                        prefixIcon: const Icon(LineAwesomeIcons.lock, size: 18),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            Provider.of<UpdateController>(context, listen: false).updateRecruiterId(context, recruiterIdController.text.trim());
                            recruiterIdController.clear();
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              color: Colors.cyan,
                            ),
                            child: const Center(
                              child: Icon(LineAwesomeIcons.chevron_circle_up,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "Note : You can update your email, but you can't access your account with your updated email, in authentication you need to used old email because it's verified.",
                  style: GoogleFonts.roboto(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "Alert!",
                    style: GoogleFonts.roboto(),
                  ),
                  content: Text(
                    "Are you sure want to delete your account",
                    style: GoogleFonts.roboto(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "No",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                            fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final __user = FirebaseAuth.instance.currentUser;
                        if (__user != null) {
                          Provider.of<AuthController>(context,listen: false).deleteAccount(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Yes",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                            fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                );
              });
        },
        backgroundColor: Colors.cyan,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(LineAwesomeIcons.remove_user),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
