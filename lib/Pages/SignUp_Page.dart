import 'package:whatsappp/Services/GetUsername.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:whatsappp/Components/bottom.dart';
import 'package:whatsappp/Components/customTextField.dart';
// import 'package:chato/Components/phoneTextField.dart';
import 'package:whatsappp/Pages/SignIn_Page.dart';
import 'package:whatsappp/Services/Signup_Auth.dart';
import '../constants.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class SignUp extends StatefulWidget {
  String id = "Signup";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  ///////////////////////
  String? username;
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;

  ////////////////////////////
  GlobalKey<FormState> formKey = GlobalKey();
  validation() async {
    //لو الفورم مطابقه للي انا عايزو اعمل دا
    if (formKey.currentState!.validate()) {
      isloading = true;
      setState(() {});
      UserCredential? userCred;

      await signUpfun(email!, password, phone, Capitalize(username!),
          scaffoldKey.currentContext!);
      isloading = false;
    }
    isloading = false;
    setState(() {});
  }

////////////////////////
  PassUpdateUi() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  ComfirmPassUpdateUi() {
    setState(() {
      confirmpasswordVisible = !confirmpasswordVisible;
    });
  }

//////////////////////////
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        key: scaffoldKey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 2,
            ),
            Image.asset(
              kLogo,
              scale: 0.6,
            ),
            Spacer(
              flex: 3,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  customTextField(
                    hintText: "Username",
                    icon: Icon(Icons.person),
                    isSecured: false,
                    updateui: empty,
                    onchaged: (data) {
                      username = data;
                      print(data);
                    },
                    validator: (val) {
                      List v = val!.split("");
                      if (v.contains(" ") || v.contains("_") || val == null) {
                        print(v);
                        return "type a username and dont use spaces or '_'";
                      } else {
                        return null;
                      }
                    },
                  ),
                  customTextField(
                    hintText: "Email",
                    icon: Icon(Icons.email),
                    isSecured: false,
                    updateui: empty,
                    onchaged: (data) {
                      email = data;
                      print(data);
                    },
                    validator: (val) {
                      List v = val!.split("");
                      if (!v.contains("@") || v.contains(" ")) {
                        return " Type your email and dont put spaces";
                      } else {
                        return null;
                      }
                    },
                  ),
                  // phonetextfield(
                  //   onchaged: (data) {
                  //     phone = data;
                  //   },
                  //   validator: (val) {
                  //     if (val!.length < 6) {
                  //       return "please type your number";
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // ),
                  customTextField(
                    hintText: "Password",
                    icon: passwordVisible == false
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    isSecured: passwordVisible,
                    updateui: PassUpdateUi,
                    onchaged: (data) {
                      password = data;
                      print(data);
                    },
                    validator: (val) {
                      if (val!.length < 6) {
                        return "please type more than 5 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  customTextField(
                    hintText: "Confirm Password",
                    icon: confirmpasswordVisible == false
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    isSecured: confirmpasswordVisible,
                    updateui: ComfirmPassUpdateUi,
                    onchaged: (data) {
                      confirmPassword = data;
                    },
                    validator: (val) {
                      if (password != confirmPassword) {
                        return "please confirm your password";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            customBottom(
              text: "Sign up",
              onpress: () {
                validation();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text("You already have an account? ",
                        style:
                            TextStyle(color: Color.fromARGB(182, 54, 54, 54)))),
                Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(SignIn().id);
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Text("Or sign up with")),
            Container(
              height: 30,
              child: Row(
                children: [
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: () {},
                      child: Image.asset("assets/images/google.png"),
                    ),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {},
                      child: Image.asset("assets/images/facebook.png"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: InkWell(
                      onTap: () {},
                      child: Image.asset("assets/images/Twitter2.png"),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
