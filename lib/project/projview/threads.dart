import 'package:flutter/material.dart';

class threads extends StatefulWidget {
  const threads({Key? key}) : super(key: key);

  @override
  State<threads> createState() => _threadsState();
}

class _threadsState extends State<threads> {
  @override
  Widget build(BuildContext context) {
    return Container(
            color: Colors.grey,
            height: MediaQuery.of(context).size.height - 175,
            child: Text("Threads")
    );
  }
}
