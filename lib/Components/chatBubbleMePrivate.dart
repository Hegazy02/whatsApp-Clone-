import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/constants.dart';
import 'package:intl/intl.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;

class chatBubbleMePrivate extends StatelessWidget {
  String? isCurrentUser;
  String? message;
  Timestamp? time;

  chatBubbleMePrivate(this.isCurrentUser, this.message, this.time);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isCurrentUser == uid ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: isCurrentUser == uid ? kSecondryColor : kThirdColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: isCurrentUser == uid
                      ? Radius.circular(20)
                      : Radius.circular(0),
                  bottomRight: isCurrentUser == uid
                      ? Radius.circular(0)
                      : Radius.circular(20),
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isCurrentUser == uid
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
