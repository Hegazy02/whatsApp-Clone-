import 'package:whatsappp/Pages/Home_Page.dart';
import 'package:whatsappp/Services/GetUsername.dart';
import 'package:whatsappp/Services/Notifications.dart';
import 'package:whatsappp/Services/Send&RecieveMessages.dart';
import 'package:whatsappp/Services/Auth/Signup_Auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/constants.dart';

class ChatPage extends StatefulWidget {
  String id = "chatPAge";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController? control = new TextEditingController();
  String message = '';

  updateUi() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // getToken();

    // getMessage(context);
    // onTapNotificationBackgroundAndTerminated(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //بستقبل البيانات الي جايه من النافيجاتور الي كان رايح الصفحه دي
    return Scaffold(
      appBar: AppBar(
        //دي بتلغي السهم الي بيرجع لورا لو عامل بوش نايمد
        // automaticallyImplyLeading: false,

        title: Text("Main Chat"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessageBuilder()),
            Container(
              margin: EdgeInsets.all(12),
              child: Form(
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    message = value;
                  },
                  controller: control,
                  decoration: InputDecoration(
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
                            String oneUid = newuid ?? homeUid;
                            setState(() {});
                            if (message != "") {
                              // chatList.add(message);
                              control!.clear();
                              // controller
                              //     .jumpTo(controller.position.maxScrollExtent);
                              String? myusername = await getDataWithUid(
                                  doc_id: oneUid, type: 'username');
                              print("object0000000000");
                              print("object0000000000");
                              print(newuid);
                              print(myusername);
                              print(message);

                              addMessage(myusername!, message, oneUid);
                              sendnotify(myusername, message);
                              message = '';
                            }
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
  }
}
