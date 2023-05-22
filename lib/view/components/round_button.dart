import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundButton extends StatelessWidget {
  String text;
  VoidCallback onTap;
  Color color;
  Color textColor;
  RoundButton({Key? key,
    required this.text,
    required this.onTap,
    required this.textColor,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: color,
        ),
        child: Center(
          child: Text(text,style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w400,color: textColor)),
        ),
      ),
    );
  }
}
