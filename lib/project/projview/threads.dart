import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class threads extends StatefulWidget {
  const threads({Key? key}) : super(key: key);

  @override
  State<threads> createState() => _threadsState();
}

class _threadsState extends State<threads> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Column(
              children: [
                  Container(

                  )
              ],
            ),
          ),
          Container(
            height: 900,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
