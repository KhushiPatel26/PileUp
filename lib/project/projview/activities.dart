import 'package:flutter/material.dart';

class activities extends StatefulWidget {
  const activities({Key? key}) : super(key: key);

  @override
  State<activities> createState() => _activitiesState();
}

class _activitiesState extends State<activities> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        height: MediaQuery.of(context).size.height - 175,
        child: Text("Activities")
    );
  }
}
