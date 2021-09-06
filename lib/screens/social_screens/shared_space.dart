import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedSpace extends StatefulWidget {
  const SharedSpace({Key? key}) : super(key: key);

  @override
  _SharedSpaceState createState() => _SharedSpaceState();
}

class _SharedSpaceState extends State<SharedSpace> {
  CollectionReference<Map<String, dynamic>> sharedNotes =
      FirebaseFirestore.instance.collection('shared');
  getData() {}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: sharedNotes.orderBy('dateTime', descending: true).snapshots(),
        builder: (context, snapshots) {
          List<PostBox> posts = [];
          if (snapshots.hasData) {
            try {
              var postDetails = snapshots.data!.docs;

              for (var post in postDetails) {
                var email = post['email'].toString();
                var date = post['dateTime'].toString();
                var title = post['title'].toString();
                var content = post['content'].toString();
                posts.add(PostBox(
                    email: email, date: date, title: title, content: content));
              }
            } catch (e) {
              print(e);
            }
          } else {
            return Center(child: Icon(Icons.cloud_download_rounded));
          }
          print(posts.length);
          return ListView(
            children: posts.length != 0
                ? posts
                : [
                    Container(
                        margin: EdgeInsets.all(20),
                        child: Image.asset('assets/images/spinner.gif'))
                  ],
          );
        });
  }
}

class PostBox extends StatefulWidget {
  PostBox(
      {required this.email,
      required this.date,
      required this.title,
      required this.content});
  final String email;
  String date;
  final String title;
  final String content;
  // var date = DateTime.fromMillisecondsSinceEpoch(date * 1000);

  @override
  _PostBoxState createState() => _PostBoxState();
}

class _PostBoxState extends State<PostBox> {
  @override
  Widget build(BuildContext context) {
    Size ss = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: EdgeInsets.only(bottom: 20, left: 8, right: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Center(
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.loveYaLikeASister(
                    fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.all(8),
            child: Text(
              widget.content,
              style: GoogleFonts.loveYaLikeASister(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.all(8),
            child: Text("Created by: " + widget.email,
                style: GoogleFonts.loveYaLikeASister()),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.all(8),
            child: Text("Date: " + getTime(widget.date),
                style: GoogleFonts.loveYaLikeASister()),
          )
        ],
      ),
    );
  }
}

String getTime(String timestamp) {
  String temp = "";
  for (int i = 0; i < timestamp.length; i++) {
    if (timestamp[i] == '=') {
      for (int j = i + 1; j < timestamp.length; j++) {
        if (timestamp[j] == ',') break;
        temp = temp + timestamp[j];
      }
      int timeInInt = int.parse(temp);
      var dt = DateTime.fromMillisecondsSinceEpoch(timeInInt * 1000)
          .toIso8601String();
      var date = "";
      for (int k = 0; k < dt.length; k++) {
        if (dt[k] == 'T') {
          String str = "Time: ";
          for (int m = k + 1; m < k + 6; m++) str += dt[m];
          return date + "   " + str;
        }
        date = date + dt[k];
      }
    }
  }
  return "Eternity";
}
