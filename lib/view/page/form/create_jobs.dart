import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/controller/post_controller.dart';
import 'package:jobkar_pro/view/components/round_button.dart';
import 'package:provider/provider.dart';
import '../../../controller/constant.dart';

class CreateJobs extends StatefulWidget {
  const CreateJobs({Key? key}) : super(key: key);

  @override
  State<CreateJobs> createState() => _CreateJobsState();
}

class _CreateJobsState extends State<CreateJobs> {
  @override
  void initState() {
    __getUser();
    super.initState();
  }
  final newSalaryController = TextEditingController();
  final endSalaryController = TextEditingController();
  final requirementController = TextEditingController();
  final responsibilityController = TextEditingController();
  final companyController = TextEditingController();
  final jobNameController = TextEditingController();
  final jobForController = TextEditingController();
  final quantityController = TextEditingController();
  final addressController = TextEditingController();
  final typeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final __user = FirebaseAuth.instance.currentUser;
  String? logoImage;
  __getUser() async {
    if (__user != null) {
      final data = await FirebaseFirestore.instance.collection("recruiters").doc(__user!.uid).get();
      if (data.exists) {
        final image = data.data()!['logoUrl'];
        setState(() {
          logoImage = image;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Text(
                  "Create \nJobs for Seekers",
                  style: GoogleFonts.sansita(
                      fontSize: 25, fontWeight: FontWeight.w400),
                ),
                Text(
                  "Create multiple jobs it totally free.",
                  style: GoogleFonts.roboto(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildForm("Start Salary", "Enter your salary",
                          newSalaryController, TextInputType.number),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: _buildForm("End Salary", "Enter your salary",
                          endSalaryController, TextInputType.number),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildForm("Company", "Enter your company name",
                    companyController, TextInputType.text),
                const SizedBox(height: 10),
                _buildForm("Job Name", "Enter your job name", jobNameController,
                    TextInputType.text),
                const SizedBox(height: 10),
                _buildForm("Job For", "For experience or fresher",
                    jobForController, TextInputType.text),
                const SizedBox(height: 10),
                _buildForm("Quantity", "Requirements number of people",
                    quantityController, TextInputType.number),
                const SizedBox(height: 10),
                _buildForm("Type", "Full time or part time", typeController,
                    TextInputType.text),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Address ",
                          style: GoogleFonts.roboto(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: softColor,
                          border: Border.all(color: Colors.black12, width: 1)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0,left: 10),
                          child: TextFormField(
                            controller: addressController,
                            keyboardType: TextInputType.text,
                            maxLines: 10,
                            validator: (value) {
                              if (value!.isEmpty || value == "") {
                                return "What your job location";
                              }
                              return null;
                            },
                            style: GoogleFonts.roboto(
                                fontSize: 15, fontWeight: FontWeight.w400),
                            decoration: const InputDecoration(
                              hintText: "Enter your office address",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Requirement ",
                          style: GoogleFonts.roboto(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: softColor,
                          border: Border.all(color: Colors.black12, width: 1)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                          child: TextFormField(
                            controller: requirementController,
                            keyboardType: TextInputType.text,
                            maxLines: 8,
                            // maxLength: 20,
                            validator: (value) {
                              if (value!.isEmpty || value == "") {
                                return "Enter details carefully";
                              }
                              return null;
                            },
                            style: GoogleFonts.roboto(
                                fontSize: 15, fontWeight: FontWeight.w400),
                            decoration: const InputDecoration(
                              hintText: "What your requirement wrote in brief",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Responsibility ",
                          style: GoogleFonts.roboto(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: softColor,
                          border: Border.all(color: Colors.black12, width: 1),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10),
                          child: TextFormField(
                            controller: responsibilityController,
                            keyboardType: TextInputType.text,
                            maxLines: 10,
                            validator: (value) {
                              if (value!.isEmpty || value == "") {
                                return "Enter details carefully";
                              }
                              return null;
                            },
                            style: GoogleFonts.roboto(
                                fontSize: 15, fontWeight: FontWeight.w400),
                            decoration: const InputDecoration(
                              hintText: "What joiner responsibility wrote in brief",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: blackColor),
                      )
                    : RoundButton(
                        text: "Publish",
                        textColor: whiteColor,
                        color: blackColor,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                              Provider.of<PostController>(context, listen: false).createJob(context,
                                  newSalaryController.text,
                                  endSalaryController.text,
                                  jobForController.text,
                                  jobNameController.text,
                                  typeController.text,
                                  companyController.text,
                                  quantityController.text,
                                  addressController.text,
                                  requirementController.text,
                                  logoImage.toString(),
                                  responsibilityController.text,
                              );
                            });
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
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
    newSalaryController.dispose();
    endSalaryController.dispose();
    jobNameController.dispose();
    jobForController.dispose();
    responsibilityController.dispose();
    requirementController.dispose();
    typeController.dispose();
    addressController.dispose();
    companyController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  Widget _buildForm(String title, String subTitle,
      TextEditingController controller, TextInputType inputType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "$title ",
              style:
                  GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            Text(
              "*",
              style: GoogleFonts.roboto(
                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: softColor,
              border: Border.all(color: Colors.black12, width: 1)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: TextFormField(
                controller: controller,
                keyboardType: inputType,
                // maxLength: 20,
                validator: (value) {
                  if (value!.isEmpty || value == "") {
                    return "Enter details carefully";
                  }
                  return null;
                },
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  hintText: subTitle,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
