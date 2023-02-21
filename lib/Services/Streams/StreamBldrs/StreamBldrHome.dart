import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/Components/ListTileHomPage.dart';
import 'package:whatsappp/Services/Streams/Usercollecion.dart';
import 'package:whatsappp/constants.dart';

class strmBHome extends StatelessWidget {
  strmBHome({super.key});
  getUsercollecion usercol = getUsercollecion();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: usercol.streamUId,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("chat has Error"));
        }
        if (snapshot.hasData) {
          ///////////////
          List chatedList1 =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return data[kChatedKey];
          }).toList();

          ////////////////
          print("*******Chated with**********");
          print(chatedList1);
          List chatedList2 = chatedList1.join('').split('_');
          return ListView.builder(
            itemCount: chatedList2.length,
            itemBuilder: (context, index) {
              print("*******Chated with index**********");
              print(chatedList2[index]);

              return ListTileHomeChats(
                usercolstream: usercol.stream,
                fName: chatedList2[index],
              );
            },
          );
        } else {
          return Center(
              child: Image.asset(
            "assets/images/loading.gif",
            scale: 2.5,
          ));
        }
      },
    );
  }
}
