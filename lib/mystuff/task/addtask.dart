import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pup/homepg.dart';
import 'package:pup/mystuff/task/taskpg.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../DB/ip.dart';
class addtask extends StatefulWidget {
  const addtask({Key? key}) : super(key: key);

  @override
  State<addtask> createState() => _addtaskState();
}

class _addtaskState extends State<addtask> {

  String? uid;
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    uid = user?.uid;
    print("uid:" + uid!);
    // fetchPostsById(uid);
  }

  DateTime _selectedDate = DateTime.now();
  String selectDate='';
  String priority='Medium';
  TextEditingController taskName = new TextEditingController();
  TextEditingController taskDesc = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController starttime = new TextEditingController();
  TextEditingController endtime = new TextEditingController();
  TextEditingController remind = new TextEditingController();
  TextEditingController repeat = new TextEditingController();
  TextEditingController category = new TextEditingController();
  TextEditingController label = new TextEditingController();
 // int _selectedcolor=0;
  String st = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String et = DateFormat("hh:mm a").format(DateTime.now()).toString();
  //String et = "9:30PM";
  int _remind = 0;
  bool doremind=false;
  List<int> remindlist = [0,5, 10, 15, 20];
  List<Color> impcolors = [Color(0xFFDA1240), Color(0xFFF33870),Color(0xFFFD86A2),Color(0xFFEDE0EA)];
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;
  void insertTask() async {
    var url = 'http://$ip:3000/insertData';

    var data = {
      'usId': uid.toString(),
      'taskName': taskName.text,
      'taskDesc': taskDesc.text,
      'percent': 0.0,
      'startDate': st,
      'dueDate': et,
      'priority': priority,
      'remind': doremind?'never':_remind.toString(),
      'status': 'in progress',
      'category': category.text,
      'labels': label.text,
      'subtask': 0,
      'createDate': DateFormat('dd/MM/yyyy').format(_selectedDate),
    };

    var response = await http.post(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: json.encode(data));

    if (response.statusCode == 200) {
      print(data);
      print('Data sent successfully');
    } else {
      print('Error sending data: ${response.statusCode}');
    }
  }

  String _chosenValue="Please choose a Category";
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
            textf(mtitle: "Task", title: taskName, hint: "Add title here"),
            textf(
              mtitle: "Description",
              title: taskDesc,
              hint: "Add Note here",
            ),

            textf(
              mtitle: "Date",
              hint: DateFormat('dd/MM/yyyy').format(_selectedDate),
              widget: IconButton(
                icon: Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.black54,
                ),
                onPressed: () {
                  getDate();
                  setState(() {
                    selectDate=DateFormat('dd/MM/yyyy').format(_selectedDate);
                  });
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
                      gettime(isStartTime: true);
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
            // Visibility(
            //   visible: !doremind,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
            //         child: Text(
            //           "Remind",
            //           style: TextStyle(color: Colors.black),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left:20.0),
            //         child: ToggleSwitch(
            //           minWidth: 90.0,
            //           minHeight: 50.0,
            //           fontSize: 16.0,
            //           initialLabelIndex: 1,
            //           activeBgColor: [Colors.black],
            //           activeFgColor: Colors.white,
            //           inactiveBgColor: Colors.black26,
            //           inactiveFgColor: Colors.grey[900],
            //           totalSwitches: 2,
            //           animate: true,
            //           changeOnTap: true,
            //           animationDuration: 250,
            //           labels: ['Yes', 'No'],
            //           onToggle: (index) {
            //             // setState(() {
            //             //   priority= index==0?'High':(index==1?'Medium':'Low');
            //             // });
            //             doremind=!doremind;
            //             print('switched to: $doremind');
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Checkbox(
                    value: doremind,
                    onChanged: (bool? value) {
                      setState(() {
                        doremind = value!;
                      });
                    },
                    //splashRadius: 210.0,
                    activeColor: Colors
                        .black, // Color when checkbox is checked
                    checkColor: Colors
                        .white, // Color of the checkmark
                    materialTapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Remove extra padding
                    visualDensity: VisualDensity.compact,
                    side: BorderSide(
                        color: Colors
                            .black), // Reduce the checkbox size
                    shape: CircleBorder(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Do you want reminder?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                // decoration: doremind
                                //     ? TextDecoration
                                //     .lineThrough
                                //     : TextDecoration.none,
                              ),
                            ),
                            // SizedBox(
                            //   width: visible?80:120,
                            // ),
                            // Text(
                            //   "26 Sept",
                            //   style: TextStyle(
                            //       color: Colors.black
                            //           .withOpacity(0.5),
                            //       fontWeight:
                            //       FontWeight.w300),
                            // )
                          ],
                        ),
                        Text(
                          "you will be notified as per your selected time",
                          style: TextStyle(
                            fontSize: 10,
                              color: Colors.black
                                  .withOpacity(0.6),
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: doremind,
              child: textf(
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
            ),



            // textf(
            //   mtitle: "Repeat",
            //   title: repeat,
            //   hint: "Add title here",
            // ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
              child: Text(
                "Priority",
                style: TextStyle(color: Colors.black),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: ToggleSwitch(
                minWidth: 90.0,
                minHeight: 50.0,
                fontSize: 16.0,
                initialLabelIndex: 1,
                activeBgColor: [Colors.black],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.black26,
                inactiveFgColor: Colors.grey[900],
                totalSwitches: 3,
                animate: true,
                changeOnTap: true,
                animationDuration: 250,
                labels: ['High', 'Medium', 'Low'],
                onToggle: (index) {
                  // setState(() {
                  //   priority= index==0?'High':(index==1?'Medium':'Low');
                  // });
                  priority= index==0?'High':(index==1?'Medium':'Low');
                  print('switched to: $priority');
                },
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                  value: item,
                 // height: 40,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
                    .toList(),
                value: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                //
                // buttonStyleData: const ButtonStyleData(
                //   padding: EdgeInsets.symmetric(horizontal: 16),
                //   height: 40,
                //   width: 140,
                // ),
              ),
            ),

            textf(
              mtitle: "Category",
              title: category,
              hint: "Personal / Office",
            ),
            textf(
              mtitle: "Label",
              title: label,
              hint: "Any label",
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text("Colors",style: TextStyle
                //         (color: Colors.black),),
                //       Wrap(
                //         children: List<Widget>.generate(
                //           4,
                //             (int index){
                //             return GestureDetector(
                //               onTap: (){
                //                 setState(() {
                //                   _selectedcolor=index;
                //                 });
                //
                //               },
                //               child: Padding(
                //                 padding: const EdgeInsets.only(right: 8.0),
                //                 child: CircleAvatar(
                //                   radius:14,
                //                   backgroundColor:impcolors[index],//index==0?Color(0xFFEDE0EA):index==1?Colors.pink:Color(0xFFEDE0EA),
                //                   child:_selectedcolor==index?Icon(Icons.done,
                //                   color: Colors.black,
                //                   size: 16,)
                //
                //                       :Container(),
                //                 ),
                //               ),
                //             );
                //
                //             }
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(height: 40, width: 120,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: ElevatedButton(onPressed: (){
                        insertTask();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => homepg()));
                      }, child:Text("Create task",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),))),
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
      print('switched to: $priority');
    }
  }

  sttimepicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute));
  }

  gettime({required bool isStartTime}) async {
    // var pickedtime = sttimepicker();
    // String formattedtime = pickedtime.format(context);
    // if (pickedtime == null) {
    // } else if (isStartTime == true) {
    //   st = formattedtime;
    // } else if (isStartTime == false) {
    //   et = formattedtime;
    // }
    TimeOfDay? pickedTime = await sttimepicker();

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);

      if (isStartTime) {
        setState(() {
          st = formattedTime;
        });
      } else {
        setState(() {
          et = formattedTime;
        });
      }
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
                        fontSize: 17, fontWeight: FontWeight.w300
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
