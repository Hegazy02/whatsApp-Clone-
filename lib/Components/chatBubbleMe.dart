import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/constants.dart';
import 'package:intl/intl.dart';
import '../Pages/Home_Page.dart';
import 'package:whatsappp/Services/Auth/Signup_Auth.dart';

String uid = newuid == null ? homeUid : newuid;

class chatBubbleMe extends StatelessWidget {
  String? isCurrentUser;
  String? message;
  Timestamp? time;
  String? name;
  chatBubbleMe(this.isCurrentUser, this.message, this.name, this.time);
  @override
  Widget build(BuildContext context) {
    String oneUid = newuid ?? homeUid;
    return Align(
      alignment: isCurrentUser == oneUid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              isCurrentUser == oneUid ? "" : name!,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: isCurrentUser == oneUid ? kSecondryColor : kThirdColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: isCurrentUser == oneUid
                      ? Radius.circular(20)
                      : Radius.circular(0),
                  bottomRight: isCurrentUser == oneUid
                      ? Radius.circular(0)
                      : Radius.circular(20),
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isCurrentUser == oneUid
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message!,
                  style: TextStyle(color: Colors.white),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat.jm().format(time!.toDate()),
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
