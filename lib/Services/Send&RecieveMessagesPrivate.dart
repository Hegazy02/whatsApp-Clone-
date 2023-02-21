import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsappp/Pages/Home_Page.dart';
import 'package:whatsappp/Services/Auth/Signup_Auth.dart';
import 'package:whatsappp/Services/GetUsername.dart';
import '../Components/chatBubbleMePrivate.dart';
import '../constants.dart';
import 'HomeSearchBar.dart';

String firestoreSitep = "https://firebase.flutter.dev/docs/firestore/usage/";

class MessageBuilderp extends StatelessWidget {
  Function? updatep;
  String? coll;
  String? my_username;
  String? his_username;

  var scrollp = ScrollController();

  MessageBuilderp(
      {this.coll, this.my_username, this.his_username, this.updatep});

  @override
  Widget build(BuildContext context) {
    print("++++++++++++mine and his++++++++++++++++++++++++");
    print("mine ## ${my_username} his ## ${his_username}");
    print("+++++++++++++++mine and his+++++++++++++++++++++");
    print("+++++++++++++++coll+++++++++++++++++++++");
    print("$coll");
    if (coll == "${my_username}_${his_username}") {
      final Stream<QuerySnapshot> usersStreamp = FirebaseFirestore.instance
          .collection("${my_username}_${his_username}")
          .orderBy('date', descending: true)
          // .where(
          //   'uid',
          //   isEqualTo: uid,
          // )
          .snapshots();
////////////////////////

      return StreamBuilder<QuerySnapshot>(
        stream: usersStreamp,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.hasData) {
            return ListView(
                controller: scrollp,
                reverse: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return chatBubbleMePrivate(
                      data['uid'], data['message'], data['date']);
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
    } else {
      final Stream<QuerySnapshot> usersStreamp = FirebaseFirestore.instance
          .collection("${his_username}_${my_username}")
          .orderBy('date', descending: true)
          // .where(
          //   'uid',
          //   isEqualTo: uid,
          // )
          .snapshots();
      ////////////////////

      var collection = FirebaseFirestore.instance.collection;
      return StreamBuilder<QuerySnapshot>(
        stream: usersStreamp,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.hasData) {
            return ListView(
                controller: scrollp,
                reverse: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return chatBubbleMePrivate(
                      data['uid'], data['message'], data['date']);
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
      ;
    }
  }
}

Future<void> addMessage(String m, h, message) async {
  var col =
      await getData(collection: "${m}_$h", key: "collection", val: "${m}_$h");
  if (col == "${m}_$h") {
    CollectionReference messages =
        FirebaseFirestore.instance.collection("${m}_$h");
    messages
        .add({
          'username': m,
          'message': message,
          'uid': newuid ?? homeUid,
          'date': DateTime.now(),
          'collection': "${m}_$h",
        })
        .then((value) => print("message Added"))
        .catchError((error) => print("Failed to add message: $error"));
    ////////////
    CollectionReference privateChats =
        FirebaseFirestore.instance.collection(kPrivateChats);
    privateChats
        .add({
          'username': m,
          'uid': newuid ?? homeUid,
          'date': DateTime.now(),
          'collectionName': "${m}_$h",
        })
        .then((value) => print("message Added"))
        .catchError((error) => print("Failed to add message: $error"));
  } else {
    CollectionReference messages =
        FirebaseFirestore.instance.collection("${h}_$m");
    messages
        .add({
          'username': m,
          'message': message,
          'uid': newuid ?? homeUid,
          'date': DateTime.now(),
          'collection': "${h}_$m",
        })
        .then((value) => print("message Added"))
        .catchError((error) => print("Failed to add message: $error"));
    CollectionReference privateChats =
        FirebaseFirestore.instance.collection(kPrivateChats);
    privateChats
        .add({
          'username': m,
          'uid': newuid ?? homeUid,
          'date': DateTime.now(),
          'collectionName': "${h}_$m",
        })
        .then((value) => print("message Added"))
        .catchError((error) => print("Failed to add message: $error"));
  }
}

getData({collection, key, val}) async {
  HomeSearchBar t = HomeSearchBar(collection: collection, key: key, value: val);
  String hisUsername = await t.fetchInfo();
  return hisUsername;
}

ChatedWith({String? name, doc_id}) async {
  String? chatedWithData =
      await getDataWithUid(doc_id: doc_id, type: kChatedKey);
  print("text $chatedWithData");

  List l = chatedWithData!.split("_");
  print("first list : $l");
  l = l.reversed.toList();
  l.add("$name");
  l = l.reversed.toList();
  print("added list : $l");

  Set s = l.toSet();
  print(" set : $s");

  l = s.toList();
  print("last list : $l");

  var finalData = l.join('_');
  print(" String : $finalData");

  CollectionReference users =
      FirebaseFirestore.instance.collection(kUsersCollection);
  return users
      .doc(doc_id)
      .update({kChatedKey: "$finalData"})
      .then((value) => print("User Updated"))
      .catchError((error) => print("chated with error:$error"));
}
