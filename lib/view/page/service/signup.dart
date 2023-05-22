import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/controller/auth_controller.dart';
import 'package:jobkar_pro/view/components/round_button.dart';
import 'package:jobkar_pro/view/page/service/signin.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../controller/constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: whiteColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/img/hiredge.png")
                            )
                        ),
                      ),
                      Text("Sign Up",style: GoogleFonts.aBeeZee(fontSize: 40,fontWeight: FontWeight.w700),),
                      Text(
                        "hiredge most welcome you",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: whiteColor,
                                border: Border.all(color: Colors.black12)
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value!.isEmpty || value == '') {
                                    return "enter your valid name";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter your name",
                                  prefixIcon: Icon(
                                      LineAwesomeIcons.user,
                                      size: 20),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: whiteColor,
                                border: Border.all(color: Colors.black12)
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: phoneController,
                                validator: (value) {
                                  if (value!.isEmpty || value == '') {
                                    return "enter your 10 digit number";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Your phone number",
                                  prefixIcon:
                                  Icon(CupertinoIcons.phone, size: 18),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: whiteColor,
                                border: Border.all(color: Colors.black12)
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty || value == '') {
                                    return "enter your correct email";
                                  } else if (!value.contains("@")) {
                                    return "enter correct email format character @";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter your email",
                                  prefixIcon:
                                  Icon(CupertinoIcons.mail, size: 18),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: whiteColor,
                                border: Border.all(color: Colors.black12)
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value!.isEmpty || value == '') {
                                    return "enter your correct password";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Enter your password",
                                  prefixIcon:
                                  Icon(CupertinoIcons.lock, size: 18),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          _isLoading
                              ? Center(
                            child: CircularProgressIndicator(
                                color: mainColor),
                          )
                              : RoundButton(
                              text: "Sign Up",
                              onTap: () async {
                                final prefs = await SharedPreferences.getInstance();
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                    prefs.setString("myName", nameController.text);
                                    prefs.setString("myEmail", emailController.text);
                                    prefs.setString("myPhone", phoneController.text);
                                    Provider.of<AuthController>(context,listen: false).signUp(context, emailController.text.trim(),
                                        nameController.text.trim(), passwordController.text.trim(), phoneController.text.trim());
                                    //_isLoading = false;
                                  });
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              textColor: Colors.white,
                              color:  mainColor),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignIn(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign In",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: mainColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
