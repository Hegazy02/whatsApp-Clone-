import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsappp/Components/chatBubbleMe.dart';
import '../constants.dart';

String firestoreSite = "https://firebase.flutter.dev/docs/firestore/usage/";

class MessageBuilder extends StatelessWidget {
  Function? update;
  var scroll = ScrollController();

  MessageBuilder({this.update});

  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
      .collection(kMessagesCollection)
      .orderBy('date', descending: true)
      // .where(
      //   'uid',
      //   isEqualTo: uid,
      // )
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        //لو عايو اخليه يحمل في كل مره بيجيب فيها داتا
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Text("Loading");
        // }
        //  return ListView(
        //       reverse: true,
        //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //         Map<String, dynamic> data =
        //             document.data()! as Map<String, dynamic>;

        //         return chatBubbleMe(data['message']);
        //       }).toList());

        if (snapshot.hasData) {
          //بعد ما كل الداتا وصلت هعرض الحاجه

          return ListView(
              controller: scroll,
              reverse: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                return chatBubbleMe(data['uid'], data['message'],
                    data['username'], data['date']);
              }).toList());
        } else {
          return Center(
            child: Container(
              child: Image.asset(
                "assets/images/loading.gif",
                width: 80,
              ),
            ),
          );
        }
      },
    );
  }
}

CollectionReference messages =
    FirebaseFirestore.instance.collection(kMessagesCollection);

Future<void> addMessage(String username, message, uid) async {
  return await messages
      .add({
        'username': username,
        'message': message,
        'uid': uid,
        'date': DateTime.now(),
      })
      .then((value) => print("message Added"))
      .catchError((error) => print("Failed to add message: $error"));
}
