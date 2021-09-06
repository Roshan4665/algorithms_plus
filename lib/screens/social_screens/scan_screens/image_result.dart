import 'dart:io';

import 'package:algorithms_plus/screens/social_screens/shared_space.dart';
import 'package:algorithms_plus/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ImageResult extends StatefulWidget {
  ImageResult({required this.img});
  final PickedFile img;

  @override
  _ImageResultState createState() => _ImageResultState();
}

class _ImageResultState extends State<ImageResult> {
  final ScrollController scrollController = ScrollController();
  bool detected = false;
  late TextEditingController textEditingController;
  final TextEditingController titleTextEditingController =
      TextEditingController();
  String detectedText = 'Nothing Till Now...';
  callToOCR() async {
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText data = await textDetector
        .processImage(InputImage.fromFile(File(widget.img.path)));
    setState(() {
      detectedText = data.text;
      var singleline = detectedText.replaceAll("\n", " ");
      textEditingController = TextEditingController(text: singleline);
      detected = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    callToOCR();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    titleTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Scan Result"),
        ),
        body: Stack(
          children: [
            Container(
              height: screenSize.height * 0.8,
              width: screenSize.width,
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Image.file(
                File(widget.img.path),
                fit: BoxFit.fill,
              ),
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.2,
                minChildSize: 0.1,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade700,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                "EDITOR",
                                style: GoogleFonts.lobster(
                                    fontSize: screenSize.width / 12,
                                    //color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_up_outlined,
                              size: 48,
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: TextField(
                              controller: titleTextEditingController,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  labelText: "Title/Topic",
                                  labelStyle: TextStyle(color: Colors.black),
                                  contentPadding: EdgeInsets.all(8),
                                  border: InputBorder.none,
                                  filled: true),
                            )),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          child: detected
                              ? TextField(
                                  controller: textEditingController,
                                  maxLines: 20,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(8),
                                      border: InputBorder.none,
                                      filled: true),
                                )
                              : Container(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4, bottom: 4),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.pinkAccent),
                                  onPressed: () async {
                                    SnackBar sbnew = SnackBar(
                                        content: Text(
                                            "Please wait while your post is being uploaded"));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(sbnew);
                                    CollectionReference sharedNotes =
                                        FirebaseFirestore.instance
                                            .collection('shared');
                                    try {
                                      var status = await sharedNotes.add({
                                        "content": textEditingController.text,
                                        "title":
                                            titleTextEditingController.text,
                                        "email":
                                            googleSignIn.currentUser!.email,
                                        "dateTime": DateTime.now()
                                      });
                                      textEditingController.clear();
                                      titleTextEditingController.clear();
                                      SnackBar sb = SnackBar(
                                          content:
                                              Text("Your post has been saved"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(sb);
                                    } catch (e) {
                                      SnackBar sb =
                                          SnackBar(content: Text(e.toString()));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(sb);
                                    }
                                    setState(() {});
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
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.pinkAccent),
                                  onPressed: () {
                                    setState(() {});
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
