import 'package:flutter/material.dart';
import '../../Components/switch.dart';

class setting extends StatefulWidget {
  setting({super.key});
  String id = 'tet';
  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, children: [swit()]),
      ),
    );
  }
}
