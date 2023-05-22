import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobkar_pro/controller/auth_controller.dart';
import 'package:jobkar_pro/controller/constant.dart';
import 'package:jobkar_pro/controller/update_controller.dart';
import 'package:jobkar_pro/view/components/round_button.dart';
import 'package:provider/provider.dart';

class OrganizationForm extends StatefulWidget {
  const OrganizationForm({Key? key}) : super(key: key);

  @override
  State<OrganizationForm> createState() => _OrganizationFormState();
}

class _OrganizationFormState extends State<OrganizationForm> {
  final __user = FirebaseAuth.instance.currentUser;
  final orgController = TextEditingController();
  final locController = TextEditingController();
  final bool __isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              const SizedBox(height: 30),
              Text(
                "Required \nYour Organization \nDetails",
                style: GoogleFonts.sansita(fontSize: 25,fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              Text(
                "Location *",
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextFormField(
                  style: GoogleFonts.roboto(
                      fontSize: 14, fontWeight: FontWeight.normal),
                  controller: locController,
                  decoration: InputDecoration(
                      hintText: "Company location",
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      prefixIcon:
                          const Icon(CupertinoIcons.location_solid, size: 18)),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Organization *",
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextFormField(
                  style: GoogleFonts.roboto(
                      fontSize: 14, fontWeight: FontWeight.normal),
                  controller: orgController,
                  decoration: InputDecoration(
                      hintText: "Enter your organisation name",
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.roboto(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      prefixIcon:
                          const Icon(CupertinoIcons.building_2_fill, size: 18)),
                ),
              ),

              const SizedBox(height: 20),
              Text(
                "Organization logo *",
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  Provider.of<UpdateController>(context, listen: false).updateLogo(context, ImageSource.gallery);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text("Upload logo",style: GoogleFonts.roboto(fontSize: 14,color: Colors.black),),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              __isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: mainColor),
                    )
                  : RoundButton(
                      text: "Confirm",
                      onTap: () async {
                        // Provider.of<AuthController>(context,listen: false)
                        //     .addOrganization(context, orgLocation, identityCard, logoUrl, orgName)
                      },
                      textColor: Colors.white,
                      color: mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
