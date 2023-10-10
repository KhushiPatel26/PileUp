import 'dart:convert';
import 'dart:typed_data';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
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
  String selectDate = '';
  String priority = 'Medium';
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
  String dropdownValue = 'None'; //nai
  int _remind = 0;
  bool doremind = false;
  List<int> remindlist = [0, 5, 10, 15, 20];
  List<Color> impcolors = [
    Color(0xFFDA1240),
    Color(0xFFF33870),
    Color(0xFFFD86A2),
    Color(0xFFEDE0EA)
  ];
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
      'startDate': stdate.toString(),
      'dueDate': duedate.toString(),
      'priority': priority,
      'remind': doremind ? 'never' : _remind.toString(),
      'status': 'in progress',
      'category': dropdownValue,
      'labels': label.text,
      'subtask': 0,
      'createDate': DateFormat('dd/MM/yyyy').format(_selectedDate),
    };
//black ma kar ne
    var response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: json.encode(data));

    if (response.statusCode == 200) {
      print(data);
      print('Data sent successfully');
    } else {
      print('Error sending data: ${response.statusCode}');
    }
  }

  DateTime? stdate;
  DateTime? duedate;
  String _chosenValue = "Please choose a Category";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => homepg(gotoIndex: 1)));
          },
        ),
        title: Text(
          "Add Task",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),

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
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Seleted Dates:",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.black, width: 0.2)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(

                            children: [
                              Text(stdate != null?"Start: ${DateFormat('dd/MM/yyyy HH:mm').format(stdate!)}":"Start:  - Select Start Date -",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5))),
                              SizedBox(
                                width: 65,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    // border: Border.all(color: Colors.black, width: 0.7),
                                    // borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: IconButton(
                                      onPressed: () async {
                                        DateTime? dateTime =
                                        await showOmniDateTimePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(
                                              const Duration(days: 3652),
                                            ),
                                            is24HourMode: false,
                                            isShowSeconds: false,
                                            minutesInterval: 1,
                                            secondsInterval: 1,
                                            isForce2Digits: true,
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(16)),
                                            constraints:
                                            const BoxConstraints(
                                              maxWidth: 350,
                                              maxHeight: 650,
                                            ),
                                            transitionBuilder: (context,
                                                anim1, anim2, child) {
                                              return FadeTransition(
                                                opacity: anim1.drive(
                                                  Tween(
                                                    begin: 0,
                                                    end: 1,
                                                  ),
                                                ),
                                                child: child,
                                              );
                                            },
                                            transitionDuration:
                                            const Duration(
                                                milliseconds: 200),
                                            barrierDismissible: true,
                                            selectableDayPredicate:
                                                (dateTime) {
                                              // Disable 25th Feb 2023
                                              if (dateTime ==
                                                  DateTime(2023, 2, 25)) {
                                                return false;
                                              } else {
                                                return true;
                                              }
                                            });

                                        setState(() {
                                          stdate=dateTime;
                                        });
                                      },
                                      icon: Icon(
                                        LineIcons.calendarAlt,
                                        color: Colors.black,
                                      )))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: duedate!=null?(duedate!.isBefore(stdate!)?Colors.red:Colors.black):Colors.black, width: duedate!=null?(duedate!.isBefore(stdate!)?0.7:0.2):0.2)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              Text(duedate != null?"End: ${DateFormat('dd/MM/yyyy HH:mm').format(duedate!)}":"End: - Select End Date -",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5))),
                              SizedBox(
                                width: 73,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    // border: Border.all(color: Colors.black, width: 0.7),
                                    // borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: IconButton(
                                      onPressed: () async {
                                        DateTime? dateTime =
                                        await showOmniDateTimePicker(
                                            context: context,
                                            initialDate: stdate,
                                            firstDate: stdate,
                                            lastDate: DateTime.now().add(
                                              const Duration(days: 3652),
                                            ),
                                            is24HourMode: false,
                                            isShowSeconds: false,
                                            minutesInterval: 1,
                                            secondsInterval: 1,
                                            isForce2Digits: true,
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(16)),
                                            constraints:
                                            const BoxConstraints(
                                              maxWidth: 350,
                                              maxHeight: 650,
                                            ),
                                            transitionBuilder: (context,
                                                anim1, anim2, child) {
                                              return FadeTransition(
                                                opacity: anim1.drive(
                                                  Tween(
                                                    begin: 0,
                                                    end: 1,
                                                  ),
                                                ),
                                                child: child,
                                              );
                                            },
                                            transitionDuration:
                                            const Duration(
                                                milliseconds: 200),
                                            barrierDismissible: true,
                                            selectableDayPredicate:
                                                (dateTime) {
                                              // Disable 25th Feb 2023
                                              if (dateTime ==
                                                  DateTime(2023, 2, 25)) {
                                                return false;
                                              } else {
                                                return true;
                                              }
                                            });

                                        setState(() {
                                          duedate=dateTime;
                                        });
                                      },
                                      icon: Icon(
                                        LineIcons.calendarAlt,
                                        color: Colors.black,
                                      )))
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible:duedate!=null?duedate!.isBefore(stdate!):false ,
                        child: Text(
                          "Set End date timing after the Start date timing!",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // textf(
            //   mtitle: "Date",
            //   hint: DateFormat('dd/MM/yyyy').format(_selectedDate),
            //   widget: IconButton(
            //     icon: Icon(
            //       Icons.calendar_month_outlined,
            //       color: Colors.black54,
            //     ),
            //     onPressed: () {
            //       getDate();
            //       setState(() {
            //         selectDate=DateFormat('dd/MM/yyyy').format(_selectedDate);
            //       });
            //       //DatePickerDialog(initialDate: _selectedDate, firstDate: _selectedDate,);
            //     },
            //   ),
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //         child: textf(
            //       mtitle: "Start Time",
            //       title: starttime,
            //       hint: st,
            //       widget: IconButton(
            //         icon: Icon(
            //           Icons.access_time,
            //           color: Colors.black54,
            //         ),
            //         onPressed: () {
            //           gettime(isStartTime: true);
            //         },
            //       ),
            //     )),
            //     Expanded(
            //       child: textf(
            //         mtitle: "End Time",
            //         title: endtime,
            //         hint: et,
            //         widget: IconButton(
            //           icon: Icon(
            //             Icons.access_time,
            //             color: Colors.black54,
            //           ),
            //           onPressed: () {
            //             gettime(isStartTime: false);
            //           },
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
                    activeColor: Colors.black, // Color when checkbox is checked
                    checkColor: Colors.white, // Color of the checkmark
                    materialTapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Remove extra padding
                    visualDensity: VisualDensity.compact,
                    side: BorderSide(
                        color: Colors.black), // Reduce the checkbox size
                    shape: CircleBorder(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              color: Colors.black.withOpacity(0.6),
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
              padding: const EdgeInsets.only(left: 20.0),
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
                  priority =
                  index == 0 ? 'High' : (index == 1 ? 'Medium' : 'Low');
                  print('switched to: $priority');
                },
              ),
            ),
            // DropdownButtonHideUnderline(
            //   child: DropdownButton<String>(
            //     isExpanded: true,
            //     hint: Text(
            //       'Select Item',
            //       style: TextStyle(
            //         fontSize: 14,
            //         color: Colors.black,
            //       ),
            //     ),
            //     items: items
            //         .map((String item) => DropdownMenuItem<String>(
            //       value: item,
            //      // height: 40,
            //       child: Text(
            //         item,
            //         style: const TextStyle(
            //           fontSize: 14,
            //         ),
            //       ),
            //     ))
            //         .toList(),
            //     value: selectedValue,
            //     onChanged: (String? value) {
            //       setState(() {
            //         selectedValue = value;
            //       });
            //     },
            //
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
              child: Text(
                "Category",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
                top: 3,
              ),
              child: Container(
                height: 52,
                width: 400,
                // margin: EdgeInsets.only(right: 15, left: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    elevation: 16,
                    dropdownColor: Colors.white,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Personal', 'Work', 'None']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(value,
                              style: TextStyle(color: Colors.black)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
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
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                          onPressed: () {

                            if (taskName.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter task name'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
//none kar list ma none mens koi ma nai all ma dekhase
                            } else if (stdate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please select the start date'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else if (stdate!.isBefore(DateTime.now()
                                .subtract(const Duration(days: 1)))) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please select future date'),
                                  duration: Duration(seconds: 2),
                                  // closeIconColor: Colors.redAccent,
                                ),
                              );
                            } else if (duedate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please select the due date'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else if (duedate!.isBefore(DateTime.now())) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Due date cannot be before start date'),
                                  duration: Duration(seconds: 2),
                                  //  closeIconColor: Colors.redAccent,
                                ),
                              );
                            } else {
                              // All conditions are met, navigate to next page
                              insertTask();
                              _showNotificationDue(taskName.text, taskDesc.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => homepg(
                                        gotoIndex: 1,
                                      )));
                            }
                          },
                          child: Text(
                            "Create task",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200),
                          ))),
                ),
              ],
            ),
            SizedBox(
              height: 20,
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
        initialTime: TimeOfDay(
            hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute));
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
  void _showNotificationDue(String name, String desc) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true
    );

    AndroidNotificationDetails progressiveNotificationDetails =
    AndroidNotificationDetails(
      'repeating progress channel',
      'repeating progress channel',
      // 'repeating progress channel description',
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000, 500, 1000, 500]),
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: progressiveNotificationDetails,//androidPlatformChannelSpecifics,
      iOS: null,
    );//5thai aavu juiye ej

    tz.initializeTimeZones(); // Initialize timezones
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata')); // Replace with your timezone

    // Set the desired time (in this example, it's set to 10:00 AM)
    var scheduledTime = tz.TZDateTime(
        tz.local,
        // DateTime.now().year,
        // DateTime.now().month,
        // DateTime.now().day,
        // 3, // Hours (24-hour format)
        // 22,
        duedate!.year,
        duedate!.month,
        duedate!.day,
        duedate!.hour,
        duedate!.minute-_remind
    );
//
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Due:'+name,
      desc,
      scheduledTime,
      platformChannelSpecifics,
      payload: 'item x',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );

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
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
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