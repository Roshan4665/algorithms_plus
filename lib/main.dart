import 'dart:async';

import 'package:algorithms_plus/screens/animated_algorithms/animated_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'screens/algo_page.dart';
import 'screens/social_screens/bottom_tab_bar_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
              //theme: ThemeData.dark(),
              initialRoute: WelcomeScreen.id,
              routes: {
                WelcomeScreen.id: (context) => WelcomeScreen(),
                AlgoPage.id: (context) => AlgoPage(),
                HomePage.id: (context) => HomePage(),
                AnimatedHome.id: (context) => AnimatedHome()
              },
            );
          }
          return LoadingScreen();
        });
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int imgOpacity = 1;
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        imgOpacity ^= 1;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      opacity: imgOpacity.toDouble(),
      child: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage("assets/images/goku.jpg"))),
      ),
    );
  }
}
