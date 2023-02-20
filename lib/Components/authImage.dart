import 'package:flutter/material.dart';

class authImage extends StatelessWidget {
  String? image;
  void Function()? onTap;

  authImage({this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: onTap,
        child: Image.asset(image!),
      ),
    );
  }
}
