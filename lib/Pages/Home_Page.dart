import 'package:whatsappp/Pages/ChatPages/Chat_Page.dart';
import 'package:whatsappp/Pages/ChatPages/SomeoneChat_Page.dart';
import 'package:whatsappp/Services/GetUsername.dart';
import 'package:whatsappp/Services/Auth/Signup_Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/Services/Send&RecieveMessagesPrivate.dart';
import 'package:whatsappp/Services/Streams/StreamBldrs/StreamBldrHome.dart';
import 'package:whatsappp/Services/Streams/Usercollecion.dart';
import 'package:whatsappp/constants.dart';
import '../Components/DropDown.dart';
import '../Services/HomeSearchBar.dart';
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
  @override
  String? hisUsername;
  getUsercollecion usercol = getUsercollecion();

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
                  "Clone",
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
                              hisUsername = hisUsername!.replaceAll(" ", "");
                              HomeSearchBar search = HomeSearchBar(
                                  collection: kUsersCollection,
                                  key: kusername,
                                  value: hisUsername);
                              his = await search.fetchInfo();
                              mine = await getDataWithUid(
                                  doc_id: newuid ?? homeUid, type: kusername);

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
                                collectionUsers = await getData(
                                    collection: "${mine}_$his",
                                    key: "collection",
                                    val: "${mine}_$his");

                                Navigator.of(context).pushNamed(
                                    someOneChatPage().id,
                                    arguments:
                                        "${mine}1${his}1${collectionUsers}");
                              }
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
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Expanded(child: strmBHome()),
                  ],
                ),
              ),
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

mfun() async {
  mine = await getDataWithUid(doc_id: newuid ?? homeUid, type: kusername);
}
