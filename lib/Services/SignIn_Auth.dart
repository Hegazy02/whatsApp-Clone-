import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsappp/Pages/Home_Page.dart';
import '../Helpers/snackBar.dart';
import 'Signup_Auth.dart';

signInfun(String email, password, BuildContext context) async {
  try {
    userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    //دي طريقه تانيه عشان اباصي داتا من خلال النافيجاتور
    Navigator.pushReplacementNamed(context, homePage().id, arguments: email);
    print("success");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showBar(context, "user-not-found");
    } else if (e.code == 'wrong-password') {
      showBar(context, "wrong-password");
    }
  } catch (e) {
    showBar(context, "Error");
    print("Sign in error : $e");
  }
}
