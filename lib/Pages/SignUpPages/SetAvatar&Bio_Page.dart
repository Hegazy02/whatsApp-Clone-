import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/Components/customTextField.dart';
import 'package:whatsappp/Pages/Home_Page.dart';
import 'package:whatsappp/Services/Auth/Signup_Auth.dart';
import 'package:whatsappp/Services/imagePicker.dart';
import 'package:whatsappp/constants.dart';
import '../../Components/bottom.dart';
import '../../Helpers/bottomSheet.dart';
import '../../Services/ChangeUsername.dart';

class Avatar_Bio extends StatefulWidget {
  String id = "Avatar&bio";
  Avatar_Bio({super.key});

  @override
  State<Avatar_Bio> createState() => _Avatar_BioState();
}

class _Avatar_BioState extends State<Avatar_Bio> {
  String? bio;
  CollectionReference userBio =
      FirebaseFirestore.instance.collection(kUsersCollection);
  Stream<QuerySnapshot> s = FirebaseFirestore.instance
      .collection(kUsersCollection)
      .where('uid', isEqualTo: newuid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      child: Column(children: [
        Spacer(
          flex: 2,
        ),
        Container(
          height: 150,
          width: 150,
          child: StreamBuilder(
            stream: s,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List s = [];
                s = snapshot.data!.docs.map((DocumentSnapshot e) {
                  Map data = e.data() as Map;
                  return data["Avatar"];
                }).toList();
                return Container(
                  child: image == null
                      ? CircleAvatar(
                          radius: 73,
                          backgroundColor: Colors.grey,
                          child: IconButton(
                              onPressed: () {
                                bottomSheet(context);
                              },
                              icon: Icon(Icons.add_a_photo)))
                      : CircleAvatar(
                          radius: 73,
                          backgroundImage: NetworkImage(imageurl),
                        ),
                );
              } else {
                return CircleAvatar(
                    radius: 73,
                    backgroundColor: Colors.grey,
                    child: IconButton(
                        onPressed: () {
                          bottomSheet(context);
                        },
                        icon: Icon(Icons.photo)));
              }
            },
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: customTextField(
              hintText: "Bio",
              icon: Icon(Icons.info),
              onchaged: (val) {
                bio = val;
              },
            )),
        Spacer(
          flex: 3,
        ),
        customBottom(
          text: "Start",
          onpress: () {
            updateMyBio(userBio, newuid, bio);
            Navigator.of(context).pushReplacementNamed(homePage().id);
          },
        ),
        Spacer(
          flex: 1,
        ),
      ]),
    ));
  }
}
