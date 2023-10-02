import 'package:flutter/material.dart';
import 'package:pup/DB/models.dart';

class showrem extends StatefulWidget {
  final Reminder reminder;

  const showrem({Key? key, required this.reminder}) : super(key: key);

  @override
  State<showrem> createState() => _showremState();
}

class _showremState extends State<showrem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(widget.reminder.rname),
          Text(widget.reminder.rdesc.toString()),
          Text(widget.reminder.startDate),
          Text(widget.reminder.dueDate.toString()),
          if(widget.reminder.isEvent=='true')
            Text(widget.reminder.isEvent),
          Icon(Icons.circle,color:Color(int.parse(widget.reminder.color))),
        ],
      ),
    );
  }
}
