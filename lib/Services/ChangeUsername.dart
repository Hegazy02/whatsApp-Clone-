import 'package:whatsappp/Services/GetUsername.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';

changeUsername(String uid, String oldUsername, String newUsername) async {
  newUsername = Capitalize(newUsername);

  CollectionReference users =
      FirebaseFirestore.instance.collection(kUsersCollection);
  await updateMyUserName(users, uid, newUsername);
  await changeChatedWithInFireStore(users, oldUsername, newUsername);
  finalCollectionFun(oldUsername, newUsername);
}

replaceNames(String data, String oldUsername, String newUsername) {
  if (data.contains(oldUsername)) {
    List oldchatedWith = data.split("_");
    int oldIndex = oldchatedWith.indexOf(oldUsername);
    List newuserList = newUsername.split(" ");
    oldchatedWith.replaceRange(oldIndex, oldIndex + 1, newuserList);
    String newChated = oldchatedWith.join("_");
    return newChated;
  } else {
    return data;
  }
}

changeChatedWithInFireStore(users, oldUsername, newUsername) async {
  //****1****
  //هنبدأ بتغيير فيلد شاتيد ويز في كل دوكيومنتس اليوزرز
  List s = [];
  await users.get().then((QuerySnapshot value) {
    s = value.docs.map((DocumentSnapshot e) {
      return e.data();
    }).toList();
  });
//هنا جبنا كل الفيلد الي عايزنها
  s.forEach((element) async {
    String newchat =
        replaceNames(element[kChatedKey], oldUsername, newUsername);
    //هنا عملنا عليهم تشيك لو في حد فيهم عندو الاسم القديم يغيرو بالجديد او يرجع الفيلد العادي لو مفيهوش الاسم القديم

    await users
        .doc(element['uid'])
        .update({kChatedKey: newchat})
        .then((value) => print("chatedWith Updated"))
        .catchError((error) => print("updatedchatedWith error:$error"));
    //هنا رفعنا الفيلد الجديد لكل اليوزرز
    //لاحظ اننا جوا فور ايتش يعني العمليه دي هتكرر بعدد اليوزرز
  });
}

updateMyUserName(users, uid, newUsername) async {
  //*****2*****
  //هنغير اليوزرنيم بتاعنا في ملف الدوك بتاعنا
  await users
      .doc(uid)
      .update({"username": "$newUsername"})
      .then((value) => print("name Updated"))
      .catchError((error) => print("updatedUsername error:$error"));
}

getCollectionNames(oldUsername, newUsername) async {
  //****3*****
  //هنا هنجيب كل فيلدز الكوليكشن نيم الي جوا كولشن اسمو برايفت تشاتس
  CollectionReference privateChats =
      FirebaseFirestore.instance.collection(kPrivateChats);
  List chats = [];
  await privateChats.get().then((QuerySnapshot value) {
    List s = [];
    s = value.docs.map((QueryDocumentSnapshot e) {
      Map data = e.data() as Map;
      return data;
    }).toList();

    s.forEach((element) {
      List e = [];
      e.addAll(element['collectionName'].split("_"));
      if (e.contains(oldUsername)) {
        chats.add(element['collectionName']);
      }
      //هنا هناخد فيلد الكوليكشن نيم الي فيه الاسم القديم بس
      //وهنضيفها في ليست اسمها شات عشان
      //لاحظ اننا جوا فور ايتش يعني هيلف على كل الفيلدز الي جبناها
    });
  });
  return chats;
  //كدا احنا بنرجع ليست فيها كل الفيلدز القديمه (الي هي نفس اسم الكوليشنز القديمه عشان انا هدفي اسماء الكوليشنز من الاساس)
}

makeNewCollection(oldCollection, newCollection) async {
  //****4*****
  //هنا باخد اسم الكوليشن القديم والجديد وبنعمل نسخ للمفات الي في الكوليشن القديم لكوليشكن جديد بننشئها بالاسماء الجديده
  await FirebaseFirestore.instance
      .collection(oldCollection)
      .get()
      .then((QuerySnapshot snapShot) async {
    snapShot.docs.forEach((element) async {
      await FirebaseFirestore.instance
          .collection(newCollection)
          .doc(element.id)
          .set(element.data() as Map<String, dynamic>);
      //الفور ايتش دي عشان احنا بننقل ملف ملف من الكوليكشن القديمه للجديده
    });
  });
}

deletOldCollection(oldCollection) async {
  //****5****
  //هنا بنحذف الملفات الي في الكوليكشن القديم
  await FirebaseFirestore.instance
      .collection(oldCollection.toString())
      .get()
      .then((QuerySnapshot value) {
    for (DocumentSnapshot ds in value.docs) {
      ds.reference.delete();
    }
  });
}

finalCollectionFun(oldUsername, newUsername) async {
  List oldCollectionList = await getCollectionNames(oldUsername, newUsername);
//////////////////
  oldCollectionList.forEach((oldCollection) async {
    List s = oldCollection.toString().split("_");
    s.remove(oldUsername);
    s.add(newUsername);
    String newCollection = s.join("_");
    ////////////////////
    makeNewCollection(oldCollection.toString(), newCollection);
    await deletOldCollection(oldCollection);
  });
}

updateMyBio(users, uid, newBio) async {
  //*****2*****
  //هنغير اليوزرنيم بتاعنا في ملف الدوك بتاعنا
  await users
      .doc(uid)
      .update({"bio": "$newBio"})
      .then((value) => print("bio Updated"))
      .catchError((error) => print("updatedBio error:$error"));
}
