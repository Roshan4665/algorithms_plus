import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import 'greedy.dart';

int cardThemeNo = 1;
List<String> notes = [];
List<bool> isPublic = [];
List<String> titles = [];
List<String> algoDetails = [];
Color textColor = Colors.white;

class AnimatedHome extends StatefulWidget {
  static const id = 'AnimatedHome.id';

  @override
  _AnimatedHomeState createState() => _AnimatedHomeState();
}

class _AnimatedHomeState extends State<AnimatedHome> {
  TextEditingController controller = TextEditingController();
  TextEditingController controllert = TextEditingController();

  @override
  void initState() {
    algoDetails = createAlgoList();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    controllert.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Color(0xff04060b)])),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: TextButton(
                            style: ButtonStyle(),
                            onPressed: () {
                              Navigator.pop((context));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Algorithms",
                          style: GoogleFonts.loveYaLikeASister(
                              color: Colors.white, fontSize: 32),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Hero(
                            tag: 'goku',
                            child: Container(
                              height: MediaQuery.of(context).size.height / 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/goku.jpg'))),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    height: (MediaQuery.of(context).size.width <
                            MediaQuery.of(context).size.height)
                        ? MediaQuery.of(context).size.width / 1.2
                        : MediaQuery.of(context).size.height / 1.4,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        GroupBox(),
                        GroupBox(),
                        GroupBox(),
                        GroupBox(),
                        GroupBox(),
                        GroupBox(),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                cardThemeNo = 1;
                              });
                            },
                            child: ThemeChangeButton(color: Color(0xff4e5562))),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                cardThemeNo = 2;
                              });
                            },
                            child: ThemeChangeButton(color: Colors.white)),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                cardThemeNo = 3;
                              });
                            },
                            child: ThemeChangeButton(
                                color: Colors.lightBlueAccent)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              cardThemeNo = 4;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.purpleAccent,
                                  Colors.pinkAccent,
                                  Colors.greenAccent
                                ]),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.3,
                minChildSize: 0.05,
                maxChildSize: 0.88,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Center(
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              size: 36,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Center(
                            child: Text(
                              'Your Space',
                              style:
                                  GoogleFonts.loveYaLikeASister(fontSize: 32),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 8, right: 8, top: 3, bottom: 3),
                          child: TextField(
                            controller: controllert,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: "Title",
                              filled: true,
                              fillColor: Color(0xffb7c0dc),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: TextField(
                            controller: controller,
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                            decoration: InputDecoration(
                              hintText:
                                  'Write something here to your future self...',
                              helperText:
                                  "This is your place. Write something to yourself. Create Notes, write motivational quotes and if you ean t",
                              filled: true,
                              fillColor: Color(0xffb7c0dc),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4, bottom: 4),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isPublic.add(true);
                                      notes.add(controller.value.text);
                                      titles.add(controllert.value.text);
                                      controllert.clear();
                                      controller.clear();
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Text("Share"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Icon(Icons.public),
                                      )
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4, bottom: 4),
                              child: ElevatedButton(
                                  style: ButtonStyle(),
                                  onPressed: () {
                                    setState(() {
                                      isPublic.add(false);
                                      notes.add(controller.value.text);
                                      titles.add(controllert.value.text);
                                      controllert.clear();
                                      controller.clear();
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Personal"),
                                      Icon(Icons.lock)
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Column(
                          children: notes.length != null
                              ? widgetMaker()
                              : [
                                  Container(
                                    child: Image.asset('assets/empty.jpg'),
                                  )
                                ],
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

int algoNo = 0;

class GroupBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          // shape: ,
          padding: EdgeInsets.symmetric(horizontal: 16),
          primary: Colors.transparent),
      onPressed: () {
        Navigator.push(
            (context), MaterialPageRoute(builder: (context) => Greedy()));
      },
      child: AnimatedContainer(
          duration: Duration(seconds: 2),
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.width / 1.3,
          width: MediaQuery.of(context).size.width / 1.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: giveColors())),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    algoDetails[algoNo++ % algoDetails.length],
                    style: GoogleFonts.darkerGrotesque(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    algoDetails[algoNo++ % algoDetails.length],
                    style: GoogleFonts.darkerGrotesque(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tap to learn More...',
                    style: GoogleFonts.darkerGrotesque(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

Random random = Random();
List<Color> giveColors() {
  List<Color> l1 = [Color(0xfff40076), Color(0xffdf98fa)];
  List<Color> l2 = [Color(0xffd6ff7f), Color(0xff00b3cc)]; //
  List<Color> l3 = [Color(0xff9055ff), Color(0xff13e2da)];
  List<Color> l4 = [Color(0xffdf98fa), Color(0xff6699ff)];
  List<Color> l5 = [Color(0xffed7b84), Color(0xff9055ff)];
  List<Color> l6 = [Color(0xffe233ff), Color(0xffff6b00)];

  List<List<Color>> l = [l1, l2, l3, l4, l5, l6];
  Color sc = l[random.nextInt(6)][random.nextInt(2)];
  if (cardThemeNo == 1) {
    return [Color(0xff4e5562), Color(0xff4e5562)];
  } else if (cardThemeNo == 2) {
    textColor = Colors.black;
    return [Colors.white, Colors.white];
  } else if (cardThemeNo == 3) {
    textColor = Colors.black;
    return [sc, sc];
  } else {
    textColor = Colors.black;
    return l[colSelector++ % 6];
  }
}

class ThemeChangeButton extends StatelessWidget {
  final color;
  ThemeChangeButton({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
    );
  }
}

int colSelector = 0;
List<Widget> widgetMaker() {
  List<Widget> wlist = [];
  for (int i = notes.length - 1; i >= 0; i--) {
    colSelector = i;
    if (titles[i].length == 0 && notes[i].length == 0) continue;
    if (titles[i] == null || titles[i].length == 0) titles[i] = "No Title";
    if (notes[i] == null || notes[i].length == 0) notes[i] = "Nothing here...";
    wlist.add(TextContainer(
      content: notes[i],
      title: titles[i],
      public: isPublic[i],
    ));
  }
  return wlist;
}

//
class TextContainer extends StatelessWidget {
  TextContainer(
      {required this.content, required this.title, required this.public});
  final String content;
  final bool public;
  final String title;
  final List<Color> lc = [
    Color(0xff9ad6f2),
    Color(0xfffadeb2),
    Color(0xfff8bbd0),
    Color(0xffFCE6F1),
    Color(0xfff1f8e9)
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: lc[0]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(
                        8.0), //TODO use amterial and elevate these containers
                    child: Text(
                      title,
                      textScaleFactor: 1.3,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(public == true ? Icons.public : Icons.lock),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(content),
            )
          ],
        ));
  }
}

List<String> createAlgoList() {
  List<String> sl = [];
  sl.add("Greedy Algorithm");
  sl.add(
      "Greedy is an algorithmic paradigm that builds up a solution piece by piece, always choosing the next piece that offers the most obvious and immediate benefit. So the problems where choosing locally optimal also leads to global solution are best fit for Greedy.");
  sl.add("Recursive Algorithm");
  sl.add(
      "A recursive algorithm is an algorithm which calls itself with smaller (or simpler) input values, and which obtains the result for the current input by applying simple operations to the returned value for the smaller (or simpler) input.");
  sl.add("Divide & Conquer Algorithm");
  sl.add(
      "A divide-and-conquer algorithm recursively breaks down a problem into two or more sub-problems of the same or related type, until these become simple enough to be solved directly.");
  sl.add("Dynamic Programming Algorithm");
  sl.add(
      "Dynamic Programming (DP) is an algorithmic technique for solving an optimization problem by breaking it down into simpler subproblems and utilizing the fact that the optimal solution to the overall problem depends upon the optimal solution to its subproblems.");
  sl.add("Backtracking Algorithm");
  sl.add(
      "Backtracking is a general algorithm for finding solutions to some computational problems, notably constraint satisfaction problems, that incrementally builds candidates to the solutions, and abandons a candidate as soon as it determines that the candidate cannot possibly be completed to a valid solution.");
  sl.add("Brute Force");
  sl.add(
      "A Brute Force Algorithm is the straightforward approach to a problem i.e., the first approach that comes to our mind on seeing the problem. More technically it is just about iterating every possibility available to solve that problem.");
  return sl;
}
