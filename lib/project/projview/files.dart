import 'package:flutter/material.dart';

class files extends StatefulWidget {
  const files({Key? key}) : super(key: key);

  @override
  State<files> createState() => _filesState();
}

class _filesState extends State<files> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        height: MediaQuery.of(context).size.height - 175,
        child: Text("Files")
    );
  }
}
