import 'package:flutter/material.dart';

var passwordVisible = true;
var confirmpasswordVisible = true;

class customTextField extends StatefulWidget {
  String? hintText;
  Widget? icon;
  bool? isSecured = false;
  Function? updateui;
  Function(String)? onchaged;
  String? Function(String?)? validator;
  EdgeInsets? margin;

  customTextField(
      {this.hintText,
      this.icon,
      this.isSecured,
      this.updateui,
      this.onchaged,
      this.validator,
      this.margin});

  @override
  State<customTextField> createState() => _customTextFieldState();
}

class _customTextFieldState extends State<customTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin == null ? EdgeInsets.all(12) : widget.margin,
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        validator: widget.validator,
        onChanged: widget.onchaged,
        obscureText: widget.isSecured == null ? false : widget.isSecured!,
        decoration: InputDecoration(
          fillColor: Colors.white,
          // fillColor: Colors.black,
          filled: true,

          hintText: widget.hintText,
          suffixIcon: IconButton(
              color: Colors.grey,
              onPressed: () {
                widget.updateui!();
              },
              icon: widget.icon!),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.circular(50),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
