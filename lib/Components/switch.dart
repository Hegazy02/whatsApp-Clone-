import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/darkThemPref&Prov.dart';

class swit extends StatefulWidget {
  const swit({super.key});

  @override
  State<swit> createState() => _switState();
}

class _switState extends State<swit> {
  // bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return DayNightSwitcher(
      isDarkModeEnabled:
          themeProvider.darkTheme.toString() == 'false' ? false : true,
      onStateChanged: (val) async {
        // this.isDarkModeEnabled = val;
        SharedPreferences mSharedPrefs = await SharedPreferences.getInstance();
        final provider = Provider.of<DarkThemeProvider>(context, listen: false);
        provider.darkTheme = val;
        mSharedPrefs.setBool('myThemeMode', val);
        //عرفت البرفرنسز وعرفت البروفايدر واديت قيمه لكل واحد فيهم
      },
    );
  }
}
