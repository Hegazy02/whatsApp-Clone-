import 'package:whatsappp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Components/changeUsernameDialog.dart';
import '../../Components/showMyUsername.dart';
import '../../Helpers/bottomSheet.dart';
import '../../Services/ChangeUsername.dart';
import '../../Services/Signup_Auth.dart';
import '../../main.dart';
import '../Home_Page.dart';

class prof extends StatefulWidget {
  String id = 'prof';
  prof({super.key});

  @override
  State<prof> createState() => _profState();
}

class _profState extends State<prof> {
  var username;
  Future<DocumentSnapshot<Map<String, dynamic>>> mydocname = FirebaseFirestore
      .instance
      .collection(kUsersCollection)
      .doc(newuid ?? homeUid)
      .get();
  Stream<QuerySnapshot> uu = FirebaseFirestore.instance
      .collection(kUsersCollection)
      .where('uid', isEqualTo: newuid ?? homeUid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                StreamBuilder(
                  stream: uu,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    List myImagename = [];
                    if (snapshot.hasData) {
                      myImagename =
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> d =
                            document.data()! as Map<String, dynamic>;
                        print("ddddddddddddddd");
                        print(d);
                        return d['Avatar'];
                      }).toList();
                      return myImagename[0] == null
                          ? CircleAvatar(
                              radius: 73,
                              backgroundImage: AssetImage(kLogo),
                            )
                          : CircleAvatar(
                              radius: 73,
                              backgroundImage:
                                  NetworkImage("${myImagename[0]}"),
                            );
                    } else {
                      return CircleAvatar(
                          // radius: 73,
                          // backgroundImage: AssetImage(kLogo),
                          );
                    }
                  },
                ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: GestureDetector(
                    onTap: () {
                      bottomSheet(context);
                    },
                    child: Container(
                      child: Icon(
                        Icons.photo_camera,
                        color: themeChangeProvider.darkmood == true
                            ? kDarkThemeColor
                            : kSecondryColor,
                        size: 32,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              35,
                            ),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 4),
                              color: Colors.black.withOpacity(
                                0.3,
                              ),
                              blurRadius: 3,
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            ListTile(
              onTap: () {
                String? newValue;
                print("value $value2");

                changeValueDialog(context, value2, "Enter Your Username",
                    (value) {
                  newValue = value;
                }, () {
                  changeUsername(newuid ?? homeUid, value2, newValue!);
                  Navigator.pop(context);
                });
              },
              title: Row(
                children: [
                  Spacer(
                    flex: 6,
                  ),
                  myusernameclass(type: 'username'),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.edit,
                      color: themeChangeProvider.darkmood == true
                          ? Color.fromARGB(255, 168, 168, 168)
                          : kSecondryColor),
                  Spacer(
                    flex: 5,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Ink(
                child: ListTile(
                  onTap: () {
                    CollectionReference users =
                        FirebaseFirestore.instance.collection(kUsersCollection);
                    String? newValue;
                    changeValueDialog(context, value, "Enter Your Bio",
                        (value) {
                      newValue = value;
                    }, () {
                      updateMyBio(users, newuid ?? homeUid, newValue!);
                      Navigator.pop(context);
                    });
                  },
                  leading: Icon(Icons.info,
                      color: themeChangeProvider.darkmood == true
                          ? Color.fromARGB(255, 168, 168, 168)
                          : Color.fromARGB(255, 112, 112, 112)),
                  title: Text(
                    "Bio",
                    style: TextStyle(
                        color: themeChangeProvider.darkmood == true
                            ? Color.fromARGB(255, 168, 168, 168)
                            : Color.fromARGB(255, 112, 112, 112)),
                  ),
                  subtitle: myBioclass(type: 'bio'),
                  trailing: Icon(Icons.edit,
                      color: themeChangeProvider.darkmood == true
                          ? Color.fromARGB(255, 168, 168, 168)
                          : kSecondryColor),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}