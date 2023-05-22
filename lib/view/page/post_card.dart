import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/constant.dart';

class PostCard extends StatelessWidget {
  String newSalary;
  String endSalary;
  String jobName;
  String company;
  String jobFor;
  String type;
  String orgLogo;
  VoidCallback onView;
  VoidCallback onDelete;
  PostCard({
    Key? key,
    required this.endSalary,
    required this.jobName,
    required this.company,
    required this.jobFor,
    required this.orgLogo,
    required this.type,
    required this.newSalary,
    required this.onView,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: onView,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(2),
                color: whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                              border: Border.all(color: Colors.black12),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(orgLogo),
                              )),
                        ),
                        const SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              company,
                              style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Text(
                              jobName,
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Text(
                              "$type - $jobFor",overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54),
                            ),
                            Text(
                              "₹$newSalary - ₹$endSalary",
                              style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: onDelete,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: softColor,
                  ),
                  child: const Center(
                    child: Icon(CupertinoIcons.delete, size: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
