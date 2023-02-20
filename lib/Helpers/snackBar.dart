import 'package:flutter/material.dart';

showBar(BuildContext context, String message) {
  try {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  } catch (e) {
    print(e);
  }
}
