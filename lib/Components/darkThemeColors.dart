import 'package:whatsappp/constants.dart';
import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: isDarkTheme ? dark : light,
      primaryColor: isDarkTheme ? kPrimaryColor : kPrimaryColor,
      backgroundColor: isDarkTheme ? kPrimaryColor : Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? kDarkThemeColor : Color(0xffCBDCF8),
      hintColor: isDarkTheme ? kPrimaryColor : Colors.grey,
      highlightColor: kPrimaryColor,
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Color(0xFF121B22) : kPrimaryColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),
    );
  }
}

MaterialColor dark = MaterialColor(
  da,
  {
    50: Color.fromARGB(255, 34, 54, 70),
    100: Color.fromARGB(255, 150, 159, 167),
    200: Color.fromARGB(255, 150, 191, 223),
    300: Color.fromARGB(255, 54, 66, 75),
    400: Color.fromARGB(255, 69, 75, 80),
    500: Color.fromARGB(255, 132, 156, 173),
    600: Color.fromARGB(255, 35, 93, 138),
    700: Color.fromARGB(255, 91, 123, 148),
    800: Color.fromARGB(255, 114, 168, 209),
    900: Color.fromARGB(255, 77, 135, 179),
  },
);
const int da = 0xFF033F6C;

MaterialColor light = MaterialColor(
  li,
  {
    50: Color(0xFF404AD4),
    100: Color(0xFF404AD4),
    200: Color(0xFF404AD4),
    300: Color(0xFF404AD4),
    400: Color(0xFF404AD4),
    500: Color(0xFF404AD4),
    600: Color(0xFF404AD4),
    700: Color(0xFF404AD4),
    800: Color(0xFF404AD4),
    900: Color(0xFF404AD4),
  },
);
const int li = 0xFF404AD4;
