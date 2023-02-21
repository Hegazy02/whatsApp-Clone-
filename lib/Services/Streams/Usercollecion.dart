import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsappp/Pages/Home_Page.dart';
import 'package:whatsappp/Services/Auth/Signup_Auth.dart';
import 'package:whatsappp/constants.dart';

class getUsercollecion {
  Stream<QuerySnapshot> streamUId = FirebaseFirestore.instance
      .collection(kUsersCollection)
      .where('uid', isEqualTo: newuid ?? homeUid)
      .snapshots();

  Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection(kUsersCollection).snapshots();
}

UsercollecionWhereUId() {
  Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection(kUsersCollection).snapshots();
  return stream;
}
