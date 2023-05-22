import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/controller/constant.dart';
import 'package:jobkar_pro/controller/data_controller.dart';
import 'package:jobkar_pro/view/components/round_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final locationController = TextEditingController();
  final orgNameController = TextEditingController();
  final phoneController = TextEditingController();
  String? identityUrl;
  String? logoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        title: Text("Document",style: GoogleFonts.roboto(fontSize: 23,fontWeight: FontWeight.w600),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(height: 6),
            userCard("Logo", "imageUrl", () {
              Provider.of<DataController>(context,listen: false).uploadLogoImage(context);
            }),
            const SizedBox(height: 10),
            userCard("Pan/Aadhaar Card", "imageUrl", () {
              Provider.of<DataController>(context,listen: false).uploadIdentityImage(context);
            }),
            const SizedBox(height: 10),
            userFrom("Location", "Enter your office location", locationController,TextInputType.text,CupertinoIcons.location_solid),
            const SizedBox(height: 10),
            userFrom("Name", "Enter your organisation name", orgNameController,TextInputType.emailAddress,CupertinoIcons.building_2_fill),
            const SizedBox(height: 10),
            userFrom("Phone", "Enter your phone number", phoneController,TextInputType.phone,CupertinoIcons.building_2_fill),
            const SizedBox(height: 20),
            RoundButton(
                text: "Submit",
                onTap: () {
                  Provider.of<DataController>(context,listen: false)
                      .documentSubmission(context, phoneController.text,
                      orgNameController.text, orgNameController.text,
                  );
                },
                textColor: Colors.white,
                color: mainColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget userCard(String title, String imageUrl ,VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title,style: GoogleFonts.roboto(fontSize: 17,fontWeight: FontWeight.w600),),
            Text(" *",style: GoogleFonts.roboto(fontSize: 23,fontWeight: FontWeight.w600,color: Colors.red),),
          ],
        ),
        const SizedBox(height: 5.0),
        Stack(
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.black12)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                    placeholder: (context, url) => Icon(LineAwesomeIcons.photo_video,size: 40),
                    errorWidget: (context, url, error) => Icon(LineAwesomeIcons.photo_video,size: 40),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: softColor,
                    shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Icon(LineAwesomeIcons.pen),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget userFrom(String title, String subTitle ,TextEditingController controller,TextInputType textType,IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title,style: GoogleFonts.roboto(fontSize: 17,fontWeight: FontWeight.w600),),
            Text(" *",style: GoogleFonts.roboto(fontSize: 23,fontWeight: FontWeight.w600,color: Colors.red),),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12)
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: textType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: subTitle,
              prefixIcon: Icon(icon)
            ),
          ),
        ),
      ],
    );
  }
}
