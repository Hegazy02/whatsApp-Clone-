import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsappp/Services/HomeSearchBar.dart';
import 'package:whatsappp/Services/Notifications.dart';
import 'package:whatsappp/Services/Send&RecieveMessagesPrivate.dart';
import 'package:whatsappp/constants.dart';

var friendName;

class someOneChatPage extends StatefulWidget {
  String id = 'someOneChatPage';

  @override
  State<someOneChatPage> createState() => _someOneChatPageState();
}

@override
void initState() {}

class _someOneChatPageState extends State<someOneChatPage> {
  TextEditingController? control = new TextEditingController();
  String message = '';

  String? searchMessage;
  Stream<QuerySnapshot> imageCollection =
      FirebaseFirestore.instance.collection(kUsersCollection).snapshots();

  @override
  Widget build(BuildContext context) {
    var minehis = ModalRoute.of(context)!.settings.arguments;
    List mh = minehis.toString().split("1");
    print(mh);
    String m = mh[0];
    String h = mh[1];
    String c = "${m}_$h";
    print("*****mine*****");
    print(m);
    print("*****his*****");
    print(h);
    print("*****collection*****");
    print(c);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: StreamBuilder(
                stream: imageCollection,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List myImagename =
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map d = document.data()! as Map;
                      print("ddddddddddddddd");
                      print(d);
                      return d;
                    }).toList();

                    print("eeeeeeeeeeeeeeeee");
                    // print(myImagename);
                    myImagename.retainWhere((element) {
                      return element['username'] == h;
                    });
                    Map s = {"asd": "asd"};
                    myImagename.add(s);
                    print(myImagename);
                    print(h);

                    return myImagename[0]['Avatar'] == null
                        ? CircleAvatar(
                            radius: 73,
                            backgroundImage: AssetImage(kLogo),
                          )
                        : CircleAvatar(
                            radius: 73,
                            backgroundImage:
                                NetworkImage(myImagename[0]['Avatar']),
                          );
                  } else {
                    return CircleAvatar(
                        // radius: 73,
                        // backgroundImage: AssetImage(kLogo),
                        );
                  }
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(h)
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: MessageBuilderp(
              coll: c,
              my_username: m,
              his_username: h,
            )),
            Container(
              margin: EdgeInsets.all(10),
              child: Form(
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    message = value;
                  },
                  controller: control,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                        color: Colors.grey,
                        onPressed: () {},
                        icon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: kSecondryColor,
                          ),
                          onPressed: () async {
                            setState(() {});
                            print("*****uid******");
                            print(uidp);
                            print("*****uid******");

                            if (message != "") {
                              // chatList.add(message);
                              control!.clear();
                              // controller
                              //     .jumpTo(controller.position.maxScrollExtent);

                              await addMessage(m, h, message);
                              await ChatedWith(name: h, doc_id: uidp);

                              var hisUid = await fetchuid(
                                  collection: kUsersCollection,
                                  key: 'username',
                                  value: h,
                                  returned: 'uid');
                              print('his uid :$hisUid');
                              await ChatedWith(name: m, doc_id: hisUid);
                              var hisToken = await fetchuid(
                                  collection: kUsersCollection,
                                  key: 'username',
                                  value: h,
                                  returned: kTokenKey);
                              print("000000000000000000000000");
                              print(h);
                              print(message);
                              print(hisToken);
                              await sendPrivatenotify(m, message, hisToken);
                            }
                            // sendnotify(
                            //     await getUsername(doc_id: uidp), message, uidp);
                          },
                        )),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
