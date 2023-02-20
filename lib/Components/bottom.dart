import 'package:flutter/material.dart';
import '../constants.dart';

class customBottom extends StatelessWidget {
  String? text;
  double? top = 0;
  double? bottom = 0;
  double? left = 0;
  double? right = 0;
  String? route;
  Function()? onpress;
  customBottom(
      {this.text,
      this.top,
      this.bottom,
      this.left,
      this.right,
      this.route,
      this.onpress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        backgroundColor: kSecondryColor,
        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        textStyle: TextStyle(fontSize: 16),
      ),
      child: Text(text!),
    );
  }
}
