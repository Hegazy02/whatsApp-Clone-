import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';

Future<String?> getDataWithUid({String? doc_id, type}) async {
  CollectionReference users =
      FirebaseFirestore.instance.collection(kUsersCollection);
  DocumentReference documentReference = users.doc(doc_id);
  var mapData;
  String? data;
  await documentReference.get().then((snapshot) {
    mapData = snapshot.data();

    data = mapData[type];
  });
  return data;
}

String Capitalize(var word) {
  //النفكشن دي عشان نجيب السترينج الي قبل علامه @

  word = word[0].toUpperCase() + word.substring(1);
  return word;
}
