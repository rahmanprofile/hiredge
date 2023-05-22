import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/controller/auth_controller.dart';
import 'package:jobkar_pro/view/page/service/reset_password.dart';
import 'package:jobkar_pro/view/components/round_button.dart';
import 'package:jobkar_pro/view/page/service/signup.dart';
import 'package:provider/provider.dart';
import '../../../controller/constant.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

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
                      Text(
                        "Sign In",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 40, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "It's time to hire smart people",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
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
                                border: Border.all(color: Colors.black12)),
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
                                      Icon(CupertinoIcons.mail, size: 20),
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
                                border: Border.all(color: Colors.black12)),
                            child: Center(
                              child: TextFormField(
                                obscureText: true,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ResetPassword()),
                                  );
                                },
                                child: Text(
                                  "Reset Password",
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: mainColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: mainColor),
                                )
                              : RoundButton(
                                  text: "Sign In",
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                        Provider.of<AuthController>(context,
                                                listen: false)
                                            .signIn(
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim());
                                        print("object");
                                      });
                                    } else {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  },
                                  textColor: Colors.white,
                                  color: mainColor,
                                ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
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
                                      builder: (context) => const SignUp(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign Up",
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
                )
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
    super.dispose();
  }
}
