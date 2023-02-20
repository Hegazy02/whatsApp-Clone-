import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/Pages/Home_Page.dart';
import 'package:whatsappp/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String notificationsSite = "https://firebase.flutter.dev/docs/messaging/usage/";
getToken() {
  var firebaseMessage = FirebaseMessaging.instance.getToken().then((token) {
    print("*******Token************");
    print(token);
    print("*******************");
    return token;
  });
  return firebaseMessage;
}

getMessage(context) {
  FirebaseMessaging.onMessage.listen((m) {
    print("********Message***********");
    print(m.notification!.title);
    print(m.notification!.body);
    print("*******************");

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(m.notification!.title!),
            content: Text(m.notification!.body!),
            backgroundColor: Color.fromARGB(255, 73, 42, 185),
            actions: [
              TextButton(
                  onPressed: () {
                    print("OK");
                  },
                  child: Text("OK")),
              TextButton(
                  onPressed: () {
                    print("Cancel");
                  },
                  child: Text("Cancel")),
            ],
          );
        });
  });
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print("message: ${message.notification!.body}");
}

NotificationOnBackground() {
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

Future<void> onTapNotificationBackgroundAndTerminated(context) async {
  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    Navigator.of(context).pushReplacementNamed(homePage().id);
  }
}

onTapNotificationBackground(context) {
  FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  Navigator.of(context).pushReplacementNamed(homePage().id);
}

subscribeToTopic() async {
  // subscribe to topic on each app start-up
  await FirebaseMessaging.instance.subscribeToTopic(topics[0]);
}

unsubscribeFromTopic() async {
  await FirebaseMessaging.instance.unsubscribeFromTopic(topics[0]);
}

var servertoken =
    "AAAAA5-vdK4:APA91bGyUo9DyWvL6nnh1hC4cjc-8GTm8Lmry_0BIhvpPJNHs97UivEpXul9-gLW9IjP3i-wJhq2mAboLKs08pJqsk7R-BkpmCKbbHBXbCmt7w90GDDPRYew4tGFh1-nViiu_t5l4o0Y";

sendnotify(String? username, String? message) async {
  print("title $username");
  print("body $message");
  await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$servertoken',
      },
      body: jsonEncode(<String, dynamic>{
        'notification': <String, dynamic>{
          'title': username,
          'body': message,
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': "asd",
          'name': "abdelrhman",
          'lastname': 'hegazy',
          'to': '/topic/${topics[0]}'
        },
        //لو عايز ابعت لحد معين
        // 'to': await FirebaseMessaging.instance.getToken(),

        //لو عايز ابعت لكل الي عامل سبسكريب
        'to': '/topics/${topics[0]}'
      }));
}

sendPrivatenotify(String? title, body, token) async {
  var servertoken =
      "AAAAW0EsB5g:APA91bE3myflhWpujyOzEej1K6TmaXD4x5HiJsppDDc-p4wYgR22OP3Mx2MLoCjNd_PqCT7_o6iwBKqVUbWHY4IupVCeT1hP8TB7YYTyEjdsdnWOWuVlRKj6U-qRBmc4aVNLKseZ8ZeU";
  print("title $title");
  print("body $body");
  print("Token $token");
  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$servertoken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "to": token,
        },
      ),
    );
    print('done');
  } catch (e) {
    print("error push notification");
  }
}
