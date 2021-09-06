import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'screens/algo_page.dart';

final googleSignIn = GoogleSignIn();

class WelcomeScreen extends StatefulWidget {
  static String id = "WelcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  GoogleSignInAccount? currentUser;
  Color bgColor = Colors.black;
  double boardOpacity = 0.0;
  bool isChecking = true;
  animate() async {
    Timer(Duration(milliseconds: 10), () {
      setState(() {
        bgColor = Color(0xffD4B1B6);
        boardOpacity = 1.0;
      });
    });
    await googleSignIn.signInSilently(suppressErrors: true);

    setState(() {
      currentUser = googleSignIn.currentUser;
      //if (currentUser != null) Navigator.pushNamed((context), AlgoPage.id);

      isChecking = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    currentUser = googleSignIn.currentUser;

    // precacheImage(AssetImage('assets/images/animated.jpg'), context);
    // precacheImage(AssetImage('assets/images/articles.jpg'), context);
    // precacheImage(AssetImage('assets/images/challenge.jpg'), context);
    // precacheImage(AssetImage('assets/images/learn.jpg'), context);

    animate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var devHeight = MediaQuery.of(context).size.height;
    var devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 2),
        color: bgColor,
        child: AnimatedOpacity(
          duration: Duration(seconds: 2),
          opacity: boardOpacity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                height: devHeight / 3.6,
                decoration: BoxDecoration(
                    color: Color(0xff44504E),
                    border: Border.all(color: Colors.black, width: 10)),
                child: Container(
                  child: Center(
                    child: Image.asset("assets/images/network.png"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Algorithms Plus...",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(8),
                      primary: Colors.pinkAccent.shade100),
                  onPressed: () async {
                    if (currentUser == null) {
                      try {
                        await googleSignIn.signIn();
                        setState(() {
                          currentUser = googleSignIn.currentUser;
                        });
                        print(googleSignIn.currentUser);
                      } catch (e) {
                        SnackBar snackBar = SnackBar(
                          content: Text(e.toString()),
                          duration: Duration(seconds: 5),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      Navigator.pushNamed((context), AlgoPage.id);
                    }
                  },
                  child: isChecking == false
                      ? currentUser != null
                          ? Container(
                              height: 55,
                              child: Center(
                                  child: Text(
                                "You are logged in. Continue ->",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    height: 55,
                                    child: Image.asset(
                                        'assets/images/google_logo.png')),
                                Container(
                                    child: Text("Continue with Google",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)))
                              ],
                            )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Text("Checking User ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold))),
                            Container(
                                padding: EdgeInsets.all(6),
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator()),
                          ],
                        ),
                ),
              ),
              currentUser == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // primary: Colors.grey.shade600
                              ),
                          onPressed: () async {
                            await googleSignIn.signOut();
                            setState(() {
                              currentUser = null;
                            });
                            SnackBar snackBar = SnackBar(
                              content: Text("You have been logged out."),
                              duration: Duration(seconds: 5),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Container(
                            height: 55,
                            child: Center(
                                child: Text(
                              "Sign Out",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            )),
                          )),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
