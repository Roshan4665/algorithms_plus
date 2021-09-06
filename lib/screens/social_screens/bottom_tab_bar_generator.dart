import 'package:algorithms_plus/screens/social_screens/scan_screens/scanner.dart';
import 'package:algorithms_plus/screens/social_screens/shared_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:algorithms_plus/screens/social_screens/settings_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  static String id = "Home_Page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pageList = [
    ScannerPage(),
    Container(
      color: Colors.greenAccent,
    ),
    SharedSpace(),
    SettingsPage()
  ];
  List<String> appBarName = [
    "Your Scans",
    "Messages",
    "Shared Space",
    "Settings"
  ];
  int currentPage = 0;
  void onTapChangePage(int k) {
    setState(() {
      currentPage = k;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ThemeData.dark().copyWith(
            bottomNavigationBarTheme:
                BottomNavigationBarThemeData(selectedItemColor: Colors.pink)),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              appBarName[currentPage],
              style: GoogleFonts.publicSans(fontWeight: FontWeight.w900),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTapChangePage,
            currentIndex: currentPage,
            items: [
              BottomNavigationBarItem(
                label: "Scanner",
                icon: Icon(Icons.camera_alt_outlined),
              ),
              BottomNavigationBarItem(
                label: "Messages",
                icon: Icon(Icons.message_outlined),
              ),
              BottomNavigationBarItem(
                label: "Social",
                icon: Icon(Icons.public),
              ),
              BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(Icons.settings),
              )
            ],
          ),
          body: pageList[currentPage],
        ),
      ),
    );
  }
}
