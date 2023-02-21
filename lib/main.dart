import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsappp/Pages/ChatPages/Chat_Page.dart';
import 'package:whatsappp/Pages/ChatPages/SomeoneChat_Page.dart';
import 'package:whatsappp/Pages/SignUpPages/SetAvatar&Bio_Page.dart';
import 'firebase_options.dart';
import 'package:whatsappp/Pages/SignIn_Page.dart';
import 'package:whatsappp/Pages/SignUpPages/SignUp_Page.dart';
import 'package:whatsappp/Pages/Home_Page.dart';
import 'Pages/DropDownPages/ProfilePage.dart';
import 'package:whatsappp/Pages/DropDownPages/settingPage.dart';
import 'package:provider/provider.dart';
import 'Services/darkThemPref&Prov.dart';
import 'Components/darkThemeColors.dart';

bool isSigned = false;
DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
User? u = FirebaseAuth.instance.currentUser;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  User? ss = FirebaseAuth.instance.currentUser;

  if (ss == null) {
    isSigned = false;
  } else {
    isSigned = true;
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.d.getDarkTheme() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            theme: Styles.themeData(
                Provider.of<DarkThemeProvider>(context).darkTheme, context),
            home: isSigned == true ? homePage() : SignIn(),
            routes: {
              SignIn().id: (context) => SignIn(),
              SignUp().id: (context) => SignUp(),
              ChatPage().id: (context) => ChatPage(),
              homePage().id: (context) => homePage(),
              someOneChatPage().id: (context) => someOneChatPage(),
              setting().id: (context) => setting(),
              prof().id: (context) => prof(),
              Avatar_Bio().id: (context) => Avatar_Bio(),
            },
          );
        },
      ),
    );
  }
}
