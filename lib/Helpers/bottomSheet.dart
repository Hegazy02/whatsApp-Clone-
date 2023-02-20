import 'package:flutter/material.dart';
import 'package:whatsappp/Services/imagePicker.dart';

bottomSheet(context) {
  return showModalBottomSheet(
      context: context,
      builder: ((context) {
        return Container(
          height: 120,
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.image,
                ),
                title: Text("Gallery"),
                onTap: () {
                  photofromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.camera,
                ),
                title: Text("Camera"),
                onTap: () {
                  photofromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }));
}
