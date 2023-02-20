import 'package:cloud_firestore/cloud_firestore.dart';

class HomeSearchBar {
  String? collection;
  String? key;
  String? value;

  HomeSearchBar({this.collection, this.key, this.value});

  fetchInfo() async {
    var friendInfo;
    try {
      friendInfo = await FirebaseFirestore.instance
          .collection(collection!)
          .where(key!, isEqualTo: value)
          .get()
          .then((QuerySnapshot snapshot) async {
        if (snapshot.docs[0][key as String] == value) {
          return snapshot.docs[0][key as String];
        }
      });
    } catch (e) {
      print("*******fetchInfo Error**************");
      print(e);
      friendInfo = 'Error';
    }

    return friendInfo;
  }
}

fetchuid({String? collection, key, value, returned}) async {
  var dataa;
  try {
    dataa = await FirebaseFirestore.instance
        .collection(collection!)
        .where(key!, isEqualTo: value)
        .get()
        .then((QuerySnapshot snapshot) async {
      return snapshot.docs[0][returned as String];
    });
  } catch (e) {
    print("*******fetchUid Error**************");
    print(e);
    dataa = 'error';
  }

  return dataa;
}
