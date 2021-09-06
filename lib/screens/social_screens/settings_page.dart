import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../welcome_screen.dart';

class SettingsPage extends StatefulWidget {
  static String id = "SettingsPage";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var controller = TextEditingController();
  int ageVal = 18;
  String genderVal = "Male";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("assets/images/goku.jpg"))),
          ),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: "Name",
              icon: Icon(
                Icons.person,
                size: 40,
              ),
              filled: true,
              //fillColor: Color(0xffb7c0dc),
              border: OutlineInputBorder(),
            ),
          ),
        )),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: "City",
              icon: Icon(
                Icons.location_city_outlined,
                size: 40,
              ),
              filled: true,
              //fillColor: Color(0xffb7c0dc),
              border: OutlineInputBorder(),
            ),
          ),
        )),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: "About",
              icon: Icon(
                Icons.favorite,
                size: 40,
              ),
              filled: true,
              //fillColor: Color(0xffb7c0dc),
              border: OutlineInputBorder(),
            ),
          ),
        )),
        Container(
          height: 80,
          padding: const EdgeInsets.all(10.0),
          margin: EdgeInsets.symmetric(horizontal: 60),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
              onPressed: () async {
                await googleSignIn.signOut();
                Navigator.pushNamed((context), WelcomeScreen.id);
              },
              child: Container(
                height: 40,
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
    );
  }
}

//Expanded(
//             flex: 1,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Material(
//                   child: Container(
//                     //color: Colors.pinkAccent,
//                     child: Column(
//                       children: [
//                         Text(
//                           "Age",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 24),
//                         ),
//                         Text(ageVal.toString(),
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 24)),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             ElevatedButton(
//
//
//                               style: ElevatedButton.styleFrom(
//                                   primary: Colors.pinkAccent),
//                               onPressed: () {},
//                               child: Icon(Icons.add),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {},
//                               child: Icon(Icons.remove),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   //color: Colors.black12,
//                   child: Column(
//                     children: [
//                       Text(
//                         "Gender",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(genderVal,
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       Row(
//                         children: [
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(),
//                             onPressed: () {},
//                             child: Icon(Icons.male_outlined),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {},
//                             child: Icon(Icons.female_outlined),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ))
