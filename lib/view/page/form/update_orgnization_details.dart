import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobkar_pro/view/components/round_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../controller/update_controller.dart';

class UpdateOrganization extends StatefulWidget {
  const UpdateOrganization({Key? key}) : super(key: key);

  @override
  State<UpdateOrganization> createState() => _UpdateOrganizationState();
}

class _UpdateOrganizationState extends State<UpdateOrganization> {
  final orgController = TextEditingController();
  final locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 30),
            Text(
              "Update \nYour Organization?",
              style: GoogleFonts.sansita(
                  fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 30),
            Text(
              "Location *",
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
                  controller: locationController,
                  style: GoogleFonts.roboto(
                      fontSize: 14, fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    hintText: "Enter your location",
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.roboto(
                        fontSize: 14, fontWeight: FontWeight.normal),
                    prefixIcon: const Icon(LineAwesomeIcons.map, size: 18),
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        Provider.of<UpdateController>(context, listen: false)
                            .updateLocation(context, locationController.text);
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
              "Organisation *",
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
                  controller: orgController,
                  style: GoogleFonts.roboto(
                      fontSize: 14, fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    hintText: "Enter your company name",
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.roboto(
                        fontSize: 14, fontWeight: FontWeight.normal),
                    prefixIcon: const Icon(LineAwesomeIcons.building, size: 18),
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        Provider.of<UpdateController>(context, listen: false)
                            .updateOrganisation(context, orgController.text);
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
              "Organisation Logo *",
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            const SizedBox(height: 5),
            Container(
              height: 100,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                onPressed: () {
                  Provider.of<UpdateController>(context, listen: false).updateLogo(context, ImageSource.gallery);
                },
                child: Text(
                  "Upload Image",
                  style: GoogleFonts.roboto(color: Colors.black,
                      fontSize: 13, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(height: 30),
            RoundButton(
                text: "Back",
                onTap: () {
                  Navigator.pop(context);
                },
                textColor: Colors.white,
                color: Colors.cyan),
          ],
        ),
      ),
    );
  }
}
