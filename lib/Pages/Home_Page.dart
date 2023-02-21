import 'package:whatsappp/Pages/ChatPages/Chat_Page.dart';
import 'package:whatsappp/Pages/ChatPages/SomeoneChat_Page.dart';
import 'package:whatsappp/Services/GetUsername.dart';
import 'package:whatsappp/Services/Auth/Signup_Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/constants.dart';
import '../Components/DropDown.dart';
import '../Services/HomeSearchBar.dart';
import '../Services/Send&RecieveMessagesPrivate.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

var collectionUsers;
var mine;
var his;

String? homeUid = FirebaseAuth.instance.currentUser?.uid;

class homePage extends StatefulWidget {
  String id = 'homePage';
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String? hisUsername;

  Stream<QuerySnapshot> chatStream = FirebaseFirestore.instance
      .collection(kUsersCollection)
      .where('uid', isEqualTo: newuid ?? homeUid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                CustomButtonTest(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Chato",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            actions: [
              Form(
                  child: Container(
                margin: EdgeInsets.only(top: 5),
                width: 200,
                child: TextFormField(
                    cursorColor: Colors.white,
                    onChanged: (value) {
                      hisUsername = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                            onPressed: () async {
                              hisUsername = Capitalize(hisUsername!);
                              HomeSearchBar search = HomeSearchBar(
                                  collection: kUsersCollection,
                                  key: 'username',
                                  value: hisUsername!.replaceAll(" ", ""));
                              his = await search.fetchInfo();

                              if (his == 'Error') {
                                AwesomeDialog(
                                  btnOkColor: kThirdColor,
                                  btnCancelColor: kSecondryColor,
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'Wrong username',
                                  desc: 'please try again',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                )..show();
                              } else {
                                mine = await getDataWithUid(
                                    doc_id: newuid ?? homeUid,
                                    type: 'username');

                                print("@@@@@@@@");
                                print("mine: $mine");
                                print("@@@@@@@@");
                                print("his: $his");
                                ///////////
                                Navigator.of(context).pushNamed(
                                    someOneChatPage().id,
                                    arguments: "${mine}1${his}1");
                              }
                              //////////////
                            },
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            )))),
              )),
            ],
            bottom: TabBar(
                labelPadding: EdgeInsets.only(bottom: 10),
                indicatorWeight: 3,
                indicatorColor: Colors.white,
                tabs: [
                  Text(
                    "Chats",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    "Groups",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ]),
          ),
          body: TabBarView(
            children: [
              Container(
                  // color: Colors.red,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 5),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: StreamBuilder(
                          stream: chatStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text("chat has Error"));
                            }
                            if (snapshot.hasData) {
                              ///////////////
                              List a = snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return data[kChatedKey];
                              }).toList();

                              ////////////////
                              print("aaaaaaaaaaaaaaaaaaaaa");
                              print(a);
                              List cc = a.join('').split('_');
                              return ListView.builder(
                                itemCount: cc.length,
                                itemBuilder: (context, index) {
                                  Stream lastMessageStream = FirebaseFirestore
                                      .instance
                                      .collection('${cc[index]}_${mine}')
                                      .snapshots();

                                  Stream<QuerySnapshot> imageCollection =
                                      FirebaseFirestore.instance
                                          .collection(kUsersCollection)
                                          .snapshots();
                                  print("cc[index]]]]]]]]]]]]]]]]]");
                                  print(cc[index]);

                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: StreamBuilder(
                                        stream: imageCollection,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            List myImagename = snapshot
                                                .data!.docs
                                                .map((DocumentSnapshot
                                                    document) {
                                              Map d = document.data()! as Map;
                                              print("ddddddddddddddd");
                                              print(d);
                                              return d;
                                            }).toList();

                                            print("eeeeeeeeeeeeeeeee");
                                            // print(myImagename);
                                            myImagename.retainWhere((element) {
                                              return element['username'] ==
                                                  cc[index];
                                            });
                                            Map s = {"asd": "asd"};
                                            myImagename.add(s);
                                            print(myImagename);
                                            print(cc[index]);

                                            return myImagename[0]['Avatar'] ==
                                                    null
                                                ? CircleAvatar(
                                                    radius: 73,
                                                    backgroundImage:
                                                        AssetImage(kLogo),
                                                  )
                                                : CircleAvatar(
                                                    radius: 73,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            myImagename[0]
                                                                ['Avatar']),
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
                                    title: Text(cc[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    // subtitle: StreamBuilder(stream: ,builder: (context, snapshot) {
                                    //   return Text("data");
                                    // },),
                                    onTap: () async {
                                      his = cc[index];

                                      //////////////
                                      mine = await getDataWithUid(
                                          doc_id: uidp, type: 'username');
                                      print("@@@@@@@@");
                                      print("mine: $mine");
                                      print("@@@@@@@@");
                                      print("his: $his");
                                      ///////////
                                      collectionUsers = await getData(
                                          collection: "${mine}_$his",
                                          key: "collection",
                                          val: "${mine}_$his");
                                      Navigator.of(context).pushNamed(
                                          someOneChatPage().id,
                                          arguments:
                                              "${mine}1${his}1${collectionUsers}");
                                    },
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
                        ),
                      ),
                      // Text("What's next ?",
                      //     style: TextStyle(
                      //         fontSize: 18,
                      //         color: kSecondryColor,
                      //         fontWeight: FontWeight.bold)),
                      // Text("- Choose your avatar",
                      //     style: TextStyle(fontSize: 14)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
              Container(
                child: Column(
                  children: [
                    ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset(kLogo),
                        ),
                        title: Text(
                          "Main Chat",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(ChatPage().id);
                        }),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
