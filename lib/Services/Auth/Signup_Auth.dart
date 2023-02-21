import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsappp/Helpers/snackBar.dart';
import 'package:whatsappp/Pages/SignUpPages/SetAvatar&Bio_Page.dart';
import 'package:whatsappp/Services/Notifications.dart';
import 'package:whatsappp/constants.dart';

String firebase = "https://console.firebase.google.com/u/0/";
String AuthSite = "https://firebase.flutter.dev/docs/auth/usage/";
UserCredential? userCredential;
var newuid;

signUpfun(String email, password, phone, username, BuildContext context) async {
  try {
    await register(email, password, phone, username);
    subscribeToTopic();
    Navigator.of(context).pushReplacementNamed(Avatar_Bio().id);
    print("success");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showBar(context, "The password provided is too weak");
    } else if (e.code == 'email-already-in-use') {
      showBar(context, "email-already-in-use");
    }
  } catch (e) {
    showBar(context, "Error");

    print("eeeeeeeeeeeeeeeeeeeeeeeerror");
    print(e);
  }
}

Future<void> register(String email, password, phone, username) async {
  CollectionReference users =
      FirebaseFirestore.instance.collection(kUsersCollection);
  userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
  newuid = userCredential!.user!.uid;
  var token = await getToken();
  print("tttttttttttttttttttttttttttttoken $token");

  await users.doc(newuid).set({
    "username": username,
    "email": email,
    "password": password,
    "number": phone,
    "uid": newuid,
    kChatedKey: username,
    kTokenKey: token,
    'Avatar': "",
    'bio': "hey there!"
  });
}
