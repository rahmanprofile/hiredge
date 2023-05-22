import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../controller/constant.dart';

class HiredUser extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final String experience;
  final String phone;
  final String skill;
  const HiredUser({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.skill,
    required this.experience,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8.0, bottom: 4.0),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(imageUrl))),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: softColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.roboto(fontSize: 15),
                        ),
                        Text(
                          "Email : $email",
                          style: GoogleFonts.roboto(
                              fontSize: 10,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Phone : $phone",
                          style: GoogleFonts.roboto(
                              fontSize: 10,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Skill : $skill",
                          style: GoogleFonts.roboto(
                              fontSize: 10,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Experience : $experience",
                          style: GoogleFonts.roboto(
                              fontSize: 10,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 8.0,
            right: 8.0,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: softColor,
              ),
              child: const Center(
                child: Icon(LineAwesomeIcons.get_pocket, size: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
