import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/Pages/ChatPages/SomeoneChat_Page.dart';
import 'package:whatsappp/Services/Streams/Usercollecion.dart';
import 'package:whatsappp/constants.dart';

class streamBImage extends StatelessWidget {
  var userstream;
  String? name;
  streamBImage({this.userstream, this.name});
  getUsercollecion usercol = getUsercollecion();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userstream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List userList = snapshot.data!.docs.map((DocumentSnapshot document) {
            Map d = document.data()! as Map;

            return d;
          }).toList();

          userList.retainWhere((element) {
            return element[kusername] == name;
          });
          Map s = {"asd": "asd"};
          userList.add(s);
          print("****************userImageData**********");
          print(userList);
          print(friendName);

          return userList[0]['Avatar'] == null
              ? CircleAvatar(
                  radius: 73,
                  backgroundImage: AssetImage(kLogo),
                )
              : CircleAvatar(
                  radius: 73,
                  backgroundImage: NetworkImage(userList[0]['Avatar']),
                );
        } else {
          return CircleAvatar();
        }
      },
    );
  }
}
