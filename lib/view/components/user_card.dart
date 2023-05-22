import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../controller/constant.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final String experience;
  final String appliedOn;
  final String phone;
  final String skill;
  final VoidCallback onMail;
  final VoidCallback onCall;
  final VoidCallback onHired;
  const UserCard({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.skill,
    required this.experience,
    required this.appliedOn,
    required this.imageUrl,
    required this.onMail,
    required this.onCall,
    required this.onHired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding:const EdgeInsets.only(left: 8,right: 8,top: 8.0,bottom: 4.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl)
          )
        ),
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
                    Text(name,style: GoogleFonts.roboto(fontSize: 15),),
                    Text("Email : $email",style: GoogleFonts.roboto(fontSize: 10,color: Colors.black54,fontWeight: FontWeight.w600),),
                    Text("Phone : $phone",style: GoogleFonts.roboto(fontSize: 10,color: Colors.black54,fontWeight: FontWeight.w600),),
                    Text("Skill : $skill",style: GoogleFonts.roboto(fontSize: 10,color: Colors.black54,fontWeight: FontWeight.w600),),
                    Text("Experience : $experience",style: GoogleFonts.roboto(fontSize: 10,color: Colors.black54,fontWeight: FontWeight.w600),),
                    Text("Applied on : $appliedOn",style: GoogleFonts.roboto(fontSize: 10,color: Colors.black54,fontWeight: FontWeight.w600),),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                height: 1,
                width: double.infinity,
                decoration:const BoxDecoration(
                  color: Colors.black12
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: onCall,
                  child: Container(
                   // padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
                    height: 25,
                    width:90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.black12)
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.phone,size: 13,color: Colors.black,),
                          const SizedBox(width: 5),
                          Text("Call",style: GoogleFonts.roboto(fontSize: 11,color: Colors.black),)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: onMail,
                  child: Container(
                    //padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
                    height: 25,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.black12)
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.envelope,size: 13,color: Colors.white,),
                          const SizedBox(width: 5),
                          Text("Mail",style: GoogleFonts.roboto(fontSize: 11,color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: onHired,
                  child: Container(
                    height: 25,
                    width: 70,
                   // padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.pink.shade400,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.black12)
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LineAwesomeIcons.get_pocket,size: 13,color: Colors.white,),
                          const SizedBox(width: 5),
                          Text("Hired",style: GoogleFonts.roboto(fontSize: 11,color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
