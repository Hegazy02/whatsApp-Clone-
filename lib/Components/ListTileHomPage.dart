import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/Pages/ChatPages/SomeoneChat_Page.dart';
import 'package:whatsappp/Pages/Home_Page.dart';
import 'package:whatsappp/Services/GetUsername.dart';
import 'package:whatsappp/Services/Send&RecieveMessagesPrivate.dart';
import 'package:whatsappp/constants.dart';

class ListTileHomeChats extends StatelessWidget {
  var usercolstream;
  var friendName;
  ListTileHomeChats({this.usercolstream, this.friendName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: StreamBuilder(
          stream: usercolstream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List userList =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                Map d = document.data()! as Map;

                return d;
              }).toList();

              userList.retainWhere((element) {
                return element[kusername] == friendName;
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
        ),
      ),
      title: Text(friendName, style: TextStyle(fontWeight: FontWeight.bold)),
      onTap: () async {
        mine = await getDataWithUid(doc_id: uidp, type: kusername);

        collectionUsers = await getData(
            collection: "${mine}_$friendName",
            key: "collection",
            val: "${mine}_$friendName");

        Navigator.of(context).pushNamed(someOneChatPage().id,
            arguments: "${mine}1${friendName}1${collectionUsers}");
      },
    );
  }
}
