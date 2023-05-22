import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/view/components/round_button.dart';
import '../../../controller/constant.dart';
import '../../components/mysnackbar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50.0),
              Text(
                "Reset \nYour password \nsecurely?",
                style: GoogleFonts.sansita(
                    fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5.0),
              Text(
                "Enter your verified email address to reset the password.",
                style: GoogleFonts.roboto(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0), color: softColor),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == '' || value!.isEmpty) {
                      return "Enter your correct email";
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: "Enter verified email",
                      border: InputBorder.none,
                      prefixIcon: Icon(CupertinoIcons.mail, size: 18)),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: blueColor),
                    )
                  : RoundButton(
                      text: "Send link",
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await auth
                            .sendPasswordResetEmail(email: emailController.text)
                            .then((value) => Navigator.pop(context));
                        setState(() {
                          MySnackBar(context, "Please check your email box, We have send reset password link");
                          _isLoading = false;
                        });
                      },
                      textColor: whiteColor,
                      color:  mainColor,
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Please check your email box, We have sent reset",
                    style: GoogleFonts.roboto(color: Colors.black54,fontSize: 13),
                  ),
                  Text(
                    "password link on this email.",
                    style: GoogleFonts.roboto(color: Colors.black54),
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
