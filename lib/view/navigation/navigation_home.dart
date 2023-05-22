import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar_pro/view/panel/hired_panel.dart';
import 'package:jobkar_pro/view/panel/post_panel.dart';
import 'package:jobkar_pro/view/panel/premium_panel.dart';
import 'package:jobkar_pro/view/panel/user_panel.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../panel/member_group.dart';

class NavigationHome extends StatefulWidget {
  const NavigationHome({Key? key}) : super(key: key);

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  int _currentIndex = 0;
  final List<Widget> _optionList = const [
    PostPanel(),
    PremiumPanel(),
    MemberGroup(),
    UserPanel(),
    HiredPanel(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _optionList.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedLabelStyle: GoogleFonts.roboto(
            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
        selectedLabelStyle: GoogleFonts.roboto(
            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              label: "Post",
              icon: Icon(LineAwesomeIcons.feather, color: Colors.black)),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              label: "Recommend",
              icon: Icon(LineAwesomeIcons.check_square, color: Colors.black)),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              label: "Community",
              icon: Icon(CupertinoIcons.hexagon, color: Colors.black,size:35,)),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              label: "Applicants",
              icon: Icon(LineAwesomeIcons.address_book, color: Colors.black)),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              label: "Hired",
              icon: Icon(LineAwesomeIcons.get_pocket, color: Colors.black)),
        ],
      ),
    );
  }
}
