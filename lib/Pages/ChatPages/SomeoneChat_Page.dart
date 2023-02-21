import 'package:flutter/material.dart';
import 'package:whatsappp/Pages/Home_Page.dart';
import 'package:whatsappp/Services/Auth/Signup_Auth.dart';
import 'package:whatsappp/Services/HomeSearchBar.dart';
import 'package:whatsappp/Services/Notifications.dart';
import 'package:whatsappp/Services/Send&RecieveMessagesPrivate.dart';
import 'package:whatsappp/Services/Streams/StreamBldrs/StreamBldrImage.dart';
import 'package:whatsappp/Services/Streams/Usercollecion.dart';
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
  getUsercollecion col = getUsercollecion();

  @override
  Widget build(BuildContext context) {
    var minehis = ModalRoute.of(context)!.settings.arguments;
    List mh = minehis.toString().split("1");
    print(mh);
    String m = mh[0];
    String h = mh[1];
    String collec = mh[2];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: streamBImage(
                userstream: col.stream,
                name: h,
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
              coll: collec,
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
                            print(newuid ?? homeUid);
                            print("*****uid******");

                            if (message != "") {
                              // chatList.add(message);
                              control!.clear();
                              // controller
                              //     .jumpTo(controller.position.maxScrollExtent);

                              await addMessage(m, h, message);
                              await ChatedWith(
                                  name: h, doc_id: newuid ?? homeUid);

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
