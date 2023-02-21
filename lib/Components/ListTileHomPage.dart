import 'package:flutter/material.dart';
import 'package:whatsappp/Pages/ChatPages/SomeoneChat_Page.dart';
import 'package:whatsappp/Pages/Home_Page.dart';
import 'package:whatsappp/Services/Auth/Signup_Auth.dart';
import 'package:whatsappp/Services/GetUsername.dart';
import 'package:whatsappp/Services/Send&RecieveMessagesPrivate.dart';
import 'package:whatsappp/Services/Streams/StreamBldrs/StreamBldrImage.dart';
import 'package:whatsappp/constants.dart';

class ListTileHomeChats extends StatelessWidget {
  var usercolstream;
  String? fName;
  ListTileHomeChats({this.usercolstream, this.fName});

  @override
  Widget build(BuildContext context) {
    print("*******usercolstream**********");
    print(usercolstream);
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: streamBImage(
            userstream: usercolstream,
            name: fName,
          )),
      title: Text(fName!, style: TextStyle(fontWeight: FontWeight.bold)),
      onTap: () async {
        mine = await getDataWithUid(doc_id: newuid ?? homeUid, type: kusername);

        collectionUsers = await getData(
            collection: "${mine}_$fName",
            key: "collection",
            val: "${mine}_$fName");

        Navigator.of(context).pushNamed(someOneChatPage().id,
            arguments: "${mine}1${fName}1${collectionUsers}");
      },
    );
  }
}
