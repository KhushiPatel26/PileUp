import 'package:flutter/material.dart';

class settingUp extends StatefulWidget {
  const settingUp({Key? key}) : super(key: key);

  @override
  State<settingUp> createState() => _settingUpState();
}

class _settingUpState extends State<settingUp> {
  //late FlutterGifController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // GifImage(
          //   controller: controller,
          //   image: AssetImage("lib/assets/Loading.gif"),
          // ),
          Image.asset('lib/assets/Loading.gif'),
          Text("setting up page loading..."),
        ],
      ),
    );
  }
}
