import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  var dark = 'darktheme';
  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(dark, value);
    print("dark : $value");
  }

  getDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(dark);
  }
}

class DarkThemeProvider extends ChangeNotifier {
  DarkThemePreference d = DarkThemePreference();
  //عرفت البريفرنس هنا عشان احطو في الانشال ستات عشان ياخد القيمه لما الابليكشين يبدأ
  //واستخدمت متغير دارك مود عشان اديلو قيمه بالبروفايدر عشان انادي عليه بعد كدا ويظهر التغيير اول ما يحصل
  var darkmood = false;
  set darkTheme(bool val) {
    darkmood = val;
//اديت قيمه للبرنفنسز برضو اهو عشان الانشال ستيت
    d.setDarkTheme(val);
    notifyListeners();
    //وفي الانشال ستيت هستخدم البروفايدر عشان اكسس البرفرنس وانادي على فنكشن الجيت بتاتها
    //اما لما اعوز يحصل تغيير وقتي هدي قيمه لسيت البروفايدر وهرجع القيمه من  الجيت بتاتعها
  }

  bool get darkTheme => darkmood;

  sss() async {
    return await d.getDarkTheme();
  }
}
