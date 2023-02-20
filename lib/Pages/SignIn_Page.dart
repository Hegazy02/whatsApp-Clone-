import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:whatsappp/Components/customTextField.dart';
import 'package:whatsappp/Components/authImage.dart';
import 'package:whatsappp/Components/bottom.dart';
import 'package:whatsappp/Pages/SignUp_Page.dart';
import 'package:whatsappp/Services/SignIn_Auth.dart';
import '../constants.dart';

empty() {}

class SignIn extends StatefulWidget {
  String id = 'Signin';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isloading = false;
////////////////////////
  GlobalKey<FormState> formKey = new GlobalKey();
  validation() async {
    if (formKey.currentState!.validate()) {
      isloading = true;
      setState(() {});
      await signInfun(email!, password, context);
      isloading = false;
      setState(() {});
    }
  }

////////////////////////
  String? email;
  String? password;
//////////////////////
  UpdateUi() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

/////////////////////////

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 2,
            ),
            Image.asset(
              kLogo,
              scale: 0.7,
            ),
            Spacer(
              flex: 3,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  customTextField(
                    hintText: "Email",
                    icon: Icon(Icons.email),
                    isSecured: false,
                    updateui: empty,
                    onchaged: (data) {
                      email = data;
                    },
                    validator: (val) {
                      List v = val!.split("");
                      if (!v.contains("@")) {
                        return "please Type your email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  customTextField(
                    hintText: "Password",
                    icon: passwordVisible == false
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    isSecured: passwordVisible,
                    updateui: UpdateUi,
                    onchaged: (data) {
                      password = data;
                    },
                    validator: (val) {
                      if (val!.length < 6) {
                        return "please type more than 5 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                padding: EdgeInsets.only(right: 12),
                alignment: Alignment.centerRight,
                child: InkWell(onTap: () {}, child: Text("Forgot password?"))),
            customBottom(
              text: "Sign in",
              onpress: () {
                validation();
              },
            ),
            Container(
                margin: EdgeInsets.only(top: 20, bottom: 5),
                child: Text("Or continue with")),
            Container(
              height: 25,
              child: Row(
                children: [
                  Spacer(),
                  authImage(
                    image: "assets/images/google.png",
                    onTap: () => null,
                  ),
                  authImage(
                    image: "assets/images/facebook.png",
                    onTap: () => null,
                  ),
                  authImage(
                    image: "assets/images/Twitter2.png",
                    onTap: () => null,
                  ),
                  Spacer(),
                ],
              ),
            ),
            Row(
              children: [
                Spacer(),
                Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Text(
                      "Don't have an account ? please ",
                      style: TextStyle(color: Color.fromARGB(182, 54, 54, 54)),
                    )),
                Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(SignUp().id);
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    )),
                Spacer(),
              ],
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
