import 'package:whatsappp/Components/chatBubbleMe.dart';
import 'package:whatsappp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/main.dart';
import '../Pages/Home_Page.dart';
import 'package:whatsappp/Services/Auth/Signup_Auth.dart';

var value;
var value2;

class myBioclass extends StatefulWidget {
  String? type;
  myBioclass({this.type});

  @override
  State<myBioclass> createState() => _myBioclassState();
}

class _myBioclassState extends State<myBioclass> {
  Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection(kUsersCollection).snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: usersStream,
      builder: (context, snapshot) {
        List l = [];
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.hasData) {
          l = snapshot.data!.docs.map((DocumentSnapshot document) {
            Map data = document.data() as Map;

            print("000000000000 ${data['uid']}");
            var u = newuid ?? homeUid;
            if (data['uid'] == u) {
              print("uid $uid");
              print("username ${data[widget.type]}");
              return data[widget.type];
            }
          }).toList();
          // print("l $l");
          l.removeWhere(
            (element) {
              return element == null;
            },
          );
          print("l $l");
          print("valuee ${l[0]}");
          value = l[0];
          return Text(
            l[0] ?? "My Name",
            style: TextStyle(
                fontSize: 18,
                color: themeChangeProvider.darkmood == true
                    ? Colors.white
                    : Colors.black),
          );
        } else {
          return Text("");
        }
      },
    );
  }
}

class myusernameclass extends StatefulWidget {
  String? type;
  myusernameclass({this.type});

  @override
  State<myusernameclass> createState() => _myusernameclassState();
}

class _myusernameclassState extends State<myusernameclass> {
  Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection(kUsersCollection).snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: usersStream,
      builder: (context, snapshot) {
        List l = [];
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.hasData) {
          l = snapshot.data!.docs.map((DocumentSnapshot document) {
            Map data = document.data() as Map;

            print("000000000000 ${data['uid']}");
            var u = newuid ?? homeUid;
            if (data['uid'] == u) {
              print("uid $uid");
              print("username ${data[widget.type]}");
              return data[widget.type];
            }
          }).toList();
          // print("l $l");
          l.removeWhere(
            (element) {
              return element == null;
            },
          );
          print("l $l");
          print("valuee ${l[0]}");
          value2 = l[0];
          return Text(
            l[0] ?? "My Name",
            style: TextStyle(
                fontSize: 18,
                color: themeChangeProvider.darkmood == true
                    ? Colors.white
                    : Colors.black),
          );
        } else {
          return Text("");
        }
      },
    );
  }
}
