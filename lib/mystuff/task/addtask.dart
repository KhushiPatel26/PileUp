import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addtask extends StatefulWidget {
  const addtask({Key? key}) : super(key: key);

  @override
  State<addtask> createState() => _addtaskState();
}

class _addtaskState extends State<addtask> {
  DateTime _selectedDate = DateTime.now();
  TextEditingController title = new TextEditingController();
  TextEditingController note = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController starttime = new TextEditingController();
  TextEditingController endtime = new TextEditingController();
  TextEditingController remind = new TextEditingController();
  TextEditingController repeat = new TextEditingController();
  int _selectedcolor=0;
  String st = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String et = "9:30PM";
  int _remind = 5;
  List<int> remindlist = [5, 10, 15, 20];
  List<Color> impcolors = [Color(0xFFDA1240), Color(0xFFF33870),Color(0xFFFD86A2),Color(0xFFEDE0EA)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Add Task",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle_outlined,color: Colors.black,),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textf(mtitle: "Task", title: title, hint: "Add title here"),
            textf(
              mtitle: "Note",
              title: note,
              hint: "Add Note here",
            ),

            textf(
              mtitle: "Date",
              hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.black54,
                ),
                onPressed: () {
                  getDate();
                  //DatePickerDialog(initialDate: _selectedDate, firstDate: _selectedDate,);
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: textf(
                  mtitle: "Start Time",
                  title: starttime,
                  hint: st,
                  widget: IconButton(
                    icon: Icon(
                      Icons.access_time,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      gettime(isStartTime: false);
                    },
                  ),
                )),
                Expanded(
                  child: textf(
                    mtitle: "End Time",
                    title: endtime,
                    hint: et,
                    widget: IconButton(
                      icon: Icon(
                        Icons.access_time,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        gettime(isStartTime: false);
                      },
                    ),
                  ),
                ),
              ],
            ),
            textf(
              mtitle: "Remind",
              title: remind,
              hint: "$_remind mins early",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                iconSize: 32,
                elevation: 4,
                onChanged: (String? newvalue) {
                  setState(() {
                    _remind = int.parse(newvalue!);
                  });
                },
                items: remindlist.map<DropdownMenuItem<String>>((int value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
            textf(
              mtitle: "Repeat",
              title: repeat,
              hint: "Add title here",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Colors",style: TextStyle
                        (color: Colors.black),),
                      Wrap(
                        children: List<Widget>.generate(
                          4,
                            (int index){
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  _selectedcolor=index;
                                });

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius:14,
                                  backgroundColor:impcolors[index],//index==0?Color(0xFFEDE0EA):index==1?Colors.pink:Color(0xFFEDE0EA),
                                  child:_selectedcolor==index?Icon(Icons.done,
                                  color: Colors.black,
                                  size: 16,)

                                      :Container(),
                                ),
                              ),
                            );

                            }
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(height: 40, width: 120,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: ElevatedButton(onPressed: (){}, child:Text("Create task",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getDate() async {
    DateTime? _pickerdate = await showDatePicker(
        context: (context),
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2024),

    );
    if (_pickerdate != null) {
      setState(() {
        _selectedDate = _pickerdate;
      });
      print(_selectedDate);
    }
  }

  sttimepicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(hour: 9, minute: 10));
  }

  gettime({required bool isStartTime}) {
    var pickedtime = sttimepicker();
    String formattedtime = pickedtime.format(context);
    if (pickedtime == null) {
    } else if (isStartTime == true) {
      st = formattedtime;
    } else if (isStartTime == false) {
      et = formattedtime;
    }
  }
}

class textf extends StatelessWidget {
  final TextEditingController? title;
  final String mtitle;
  final String hint;
  final Widget? widget;

  const textf({
    Key? key,
    this.title,
    required this.mtitle,
    required this.hint,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
          child: Text(
            mtitle,
            style: TextStyle(color: Colors.black),
          ),
        ),
        Container(
          height: 52,
          margin: EdgeInsets.only(right: 15, left: 15),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black54, width: 1.0),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: widget == null ? false : true,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  autofocus: false,
                  cursorColor: Colors.grey,
                  controller: title,
                  decoration: InputDecoration(
                      hintText: hint,
                      contentPadding: EdgeInsets.all(10.0),
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 22,
                      ),
                      focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              widget == null
                  ? Container()
                  : Container(
                      child: widget,
                    )
            ],
          ),
        ),
      ],
    );
  }
}
