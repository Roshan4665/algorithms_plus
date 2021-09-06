import 'package:algorithms_plus/screens/social_screens/scan_screens/image_result.dart';
import 'package:algorithms_plus/screens/social_screens/shared_space.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../welcome_screen.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late PickedFile pickedImage;
  late var cameras;
  late var firstCamera;
  Future<void> getCamera() async {
    cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    firstCamera = cameras.first;
  }

  final SnackBar snackBar = SnackBar(content: Text("Some error Occured"));
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(20),
            elevation: 20,
            // color: Colors.pinkAccent,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.camera,
                  size: 32,
                ),
              ),
              Text(
                "OCR",
                style: GoogleFonts.publicSans(fontSize: screenSize.width / 8),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "You can upload your notes either by importing or scanning with camera.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.publicSans(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          pickedImage = (await ImagePicker.platform
                              .pickImage(source: ImageSource.gallery))!;
                          Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ImageResult(img: pickedImage)));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style:
                          ElevatedButton.styleFrom(primary: Colors.pinkAccent),
                      child: Text('Upload')),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.pinkAccent),
                      onPressed: () async {
                        try {
                          pickedImage = (await ImagePicker.platform
                              .pickImage(source: ImageSource.camera))!;
                          Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ImageResult(img: pickedImage)));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        {}
                      },
                      child: Text('Camera'))
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              )
            ]),
          ),
          TextInputBlock()
        ],
      ),
    );
  }
}

class TextInputBlock extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: Text(
              'Your Space',
              style: GoogleFonts.loveYaLikeASister(fontSize: 32),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
          child: TextField(
            controller: titleController,
            keyboardType: TextInputType.text,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: "Title",
              filled: true,
              // fillColor: Color(0xffb7c0dc),
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
              hintText: 'Content',
              helperText:
                  "This is your place. Write something to yourself. Create Notes, write motivational quotes and if you want..",
              filled: true,
              // fillColor: Color(0xffb7c0dc),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
                  onPressed: () async {
                    CollectionReference sharedNotes =
                        FirebaseFirestore.instance.collection('shared');
                    SnackBar sbnew = SnackBar(
                        content: Text(
                            "Please wait while your post is being uploaded"));
                    ScaffoldMessenger.of(context).showSnackBar(sbnew);
                    try {
                      var status = await sharedNotes.add({
                        "content": controller.text,
                        "title": titleController.text,
                        "email": googleSignIn.currentUser!.email,
                        "dateTime": DateTime.now()
                      });
                      controller.clear();
                      titleController.clear();
                      SnackBar sb =
                          SnackBar(content: Text("Your post has been saved"));
                      ScaffoldMessenger.of(context).showSnackBar(sb);
                    } catch (e) {
                      SnackBar sb = SnackBar(content: Text(e.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(sb);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text("Share"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Icon(Icons.public),
                      )
                    ],
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Text("Personal"), Icon(Icons.lock)],
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
