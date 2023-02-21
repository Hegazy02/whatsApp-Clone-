import 'package:flutter/material.dart';
import '../Pages/Home_Page.dart';
import '../Services/ChangeUsername.dart';
import 'package:whatsappp/Services/Auth/Signup_Auth.dart';

changeValueDialog(con, initialValue, text, Function(String)? onChanged,
    Function()? onPressed) {
  String? newValue;
  showDialog(
      context: con,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          // contentPadding: EdgeInsets.only(top: 10.0),
          title: Text(text),
          content: Form(
            child:
                TextFormField(initialValue: initialValue, onChanged: onChanged),
          ),
          // backgroundColor: Color.fromARGB(255, 73, 42, 185),
          actions: [
            TextButton(onPressed: onPressed, child: Text("OK")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
          ],
        );
      });
}
