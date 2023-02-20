import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:whatsappp/Pages/Home_Page.dart';
import 'package:whatsappp/Services/Signup_Auth.dart';
import 'dart:io';
import 'dart:math';

import 'package:whatsappp/constants.dart';

File? image;
final piker = ImagePicker();
var imageurl;
Reference? refrance;
photofromCamera() async {
  XFile? piked = await piker.pickImage(source: ImageSource.camera);
  if (piked != null) {
    image = File(piked.path);
    int rand = Random().nextInt(1000000000);
    String imagename = "$rand${basename(piked.path)}";
    refrance = FirebaseStorage.instance.ref("images").child(imagename);
    ///////////
    await refrance?.putFile(image!);
    imageurl = await refrance!.getDownloadURL();
    //////////
    CollectionReference users =
        FirebaseFirestore.instance.collection(kUsersCollection);
    updateMyAvatar(users, newuid ?? homeUid, imageurl);
  }
}

photofromGallery() async {
  XFile? piked = await piker.pickImage(source: ImageSource.gallery);
  if (piked != null) {
    image = File(piked.path);
    int rand = Random().nextInt(1000000000);
    String imagename = "$rand${basename(piked.path)}";
    refrance = FirebaseStorage.instance.ref("images").child(imagename);
    //////////
    await refrance?.putFile(image!);
    imageurl = await refrance!.getDownloadURL();
    ///////////
    CollectionReference users =
        FirebaseFirestore.instance.collection(kUsersCollection);
    updateMyAvatar(users, newuid ?? homeUid, imageurl);
  }
}

updateMyAvatar(users, uid, imageUrl) async {
  //*****2*****
  //هنغير اليوزرنيم بتاعنا في ملف الدوك بتاعنا
  await users
      .doc(uid)
      .update({"Avatar": imageUrl})
      .then((value) => print("Avatar Updated"))
      .catchError((error) => print("updatedAvatar error:$error"));
}
