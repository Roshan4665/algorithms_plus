import 'package:algorithms_plus/screens/animated_algorithms/animated_home.dart';
import 'package:algorithms_plus/screens/social_screens/bottom_tab_bar_generator.dart';
import 'package:algorithms_plus/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AlgoPage extends StatefulWidget {
  static const id = 'AlgoPage id';

  @override
  _AlgoPageState createState() => _AlgoPageState();
}

class _AlgoPageState extends State<AlgoPage> {
  var currentUser = googleSignIn.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
          ),
          backgroundColor: Colors.black,
          // appBar: AppBar(
          //   //backgroundColor: Colors.black,
          //   title: Text('Learn Algorithms'),
          // ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          //TODO navigate to social
                          Navigator.pushNamed((context), HomePage.id);
                        },
                        child: Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('assets/images/goku.jpg'))),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                currentUser!.displayName.toString(),
                                style: GoogleFonts.aladin(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                "Tasks remaining for the day : 5",
                                style: GoogleFonts.aladin(
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PageRouter(
                          image: 'animated.jpg',
                          topic: 'Animated',
                          path: AnimatedHome.id,
                        ),
                        PageRouter(
                          image: 'articles.jpg',
                          topic: 'Articles',
                          path: AnimatedHome.id,
                        ),
                        PageRouter(
                          image: 'challenge.jpg',
                          topic: 'Challenge',
                          path: AnimatedHome.id,
                        ),
                        PageRouter(
                          image: 'learn.jpg',
                          topic: 'Learn',
                          path: AnimatedHome.id,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class PageRouter extends StatelessWidget {
  final image;
  final topic;
  final path;
  PageRouter({@required this.image, @required this.topic, @required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 20,
        shadowColor: Colors.white,
        child: GestureDetector(
          child: TextButton(
              onPressed: () {
                Navigator.pushNamed((context), path);
              },
              child: Stack(
                children: [
                  Container(
                    child: FadeInImage(
                      image: AssetImage("assets/images/$image"),
                      placeholder: AssetImage("assets/images/loading.gif"),
                    ),
                    height: 200,
                    padding: EdgeInsets.all(6),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(
                        child: Text(
                      topic,
                      textScaleFactor: 1.3,
                      style: GoogleFonts.loveYaLikeASister(color: Colors.black),
                    )),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
