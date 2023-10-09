import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:pup/DB/models.dart';
import 'package:pup/colors.dart';
import 'package:pup/homepg.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../DB/ApiService3.dart';

class addrem extends StatefulWidget {
  final DateTime selecteddt;
  const addrem({Key? key, required this.selecteddt}) : super(key: key);

  @override
  State<addrem> createState() => _addremState();
}
DateTime? duedate;
DateTime? stdate;
int _remind = 0;
class _addremState extends State<addrem> {
  TextEditingController remName = TextEditingController();
  TextEditingController remNote = TextEditingController();
  TextEditingController remtime = TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController starttime = new TextEditingController();
  TextEditingController endtime = new TextEditingController();
  bool doremind = false;
  String st = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String et = DateFormat("hh:mm a").format(DateTime.now()).toString();

  List<int> remindlist = [1, 5, 10, 15, 20];
  DateTime _selectedDate = DateTime.now();
  String selectDate = '';
  Color remcolor = brown;
  bool isevent=true;


  ApiService3 api = ApiService3();

  Future<void> _insert() async {
    final record = Reminder(uid: uid.toString(),
      rname: remName.text,
      rdesc: remNote.text,
      isEvent: isevent.toString(),
      startDate: stdate.toString(),
      dueDate: duedate.toString(),
      doRem: doremind.toString(),
      remTime: _remind.toString(),
      color: remcolor.value.toString(),
    );
    await api.createRecord('Reminder', record.toJson());
    print("done");
  }

  String? uid;
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    uid = user?.uid;
    print("uid:" + uid!);
    stdate=widget.selecteddt;
    // fetchPostsById(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Add Reminder / Event",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textf(mtitle: "Name", title: remName, hint: "Add title here"),
          textf(
            mtitle: "Reminder Note",
            title: remNote,
            hint: "Add Note here",
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Checkbox(
                  value: isevent,
                  onChanged: (bool? value) {
                    setState(() {
                      isevent = value!;
                      stdate=widget.selecteddt;
                    });
                  },
                  //splashRadius: 210.0,
                  activeColor: Colors.black, // Color when checkbox is checked
                  checkColor: Colors.white, // Color of the checkmark
                  materialTapTargetSize:
                  MaterialTapTargetSize.shrinkWrap, // Remove extra padding
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
                            "Do you want to set due date?",
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
                        "event will occur all day so it will not have a due date",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Seleted Date:",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text("Start: $stdate",
                        style: TextStyle(color: Colors.black.withOpacity(0.5))),
                    Visibility(
                      visible: isevent,
                      child: Text("End: $duedate",
                          style: TextStyle(color: Colors.black.withOpacity(0.5))),
                    )
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black, width: 0.7),
                        borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                        onPressed: () async {
                          if(isevent){
                            List<DateTime>? dateTimeList =
                            await showOmniDateTimeRangePicker(
                              context: context,
                              startInitialDate: DateTime.now(),
                              startFirstDate: DateTime(1600)
                                  .subtract(const Duration(days: 3652)),
                              startLastDate: DateTime.now().add(
                                const Duration(days: 3652),
                              ),
                              endInitialDate: DateTime.now(),
                              endFirstDate: DateTime(1600)
                                  .subtract(const Duration(days: 3652)),
                              endLastDate: DateTime.now().add(
                                const Duration(days: 3652),
                              ),
                              is24HourMode: false,
                              isShowSeconds: false,
                              minutesInterval: 1,
                              secondsInterval: 1,
                              isForce2Digits: true,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                              constraints: const BoxConstraints(
                                maxWidth: 350,
                                maxHeight: 650,
                              ),
                              transitionBuilder: (context, anim1, anim2, child) {
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
                              const Duration(milliseconds: 200),
                              barrierDismissible: true,
                              selectableDayPredicate: (dateTime) {
                                // Disable 25th Feb 2023
                                if (dateTime == DateTime(2023, 2, 25)) {
                                  return false;
                                } else {
                                  return true;
                                }
                              },
                            );
                            setState(() {
                              stdate=dateTimeList![0];
                              duedate=dateTimeList?[1];
                            });
                            print("Start dateTime: ${dateTimeList?[0]}");
                            print("End dateTime: ${dateTimeList?[1]}");
                          }
                          else{
                            DateTime? dateTime = await showOmniDateTimePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1600)
                                  .subtract(const Duration(days: 3652)),
                              lastDate: DateTime.now().add(
                                const Duration(days: 3652),
                              ),
                              is24HourMode: false,
                              isShowSeconds: false,
                              minutesInterval: 1,
                              secondsInterval: 1,
                              isForce2Digits: true,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                              constraints: const BoxConstraints(
                                maxWidth: 350,
                                maxHeight: 650,
                              ),
                              transitionBuilder:
                                  (context, anim1, anim2, child) {
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
                              const Duration(milliseconds: 200),
                              barrierDismissible: true,
                              selectableDayPredicate: (dateTime) {
                                // Disable 25th Feb 2023
                                if (dateTime == DateTime(2023, 2, 25)) {
                                  return false;
                                } else {
                                  return true;
                                }
                              },
                            );
                            setState(() {
                              stdate=dateTime!;
                            });
                            print("dateTime: $dateTime");
                          }
                        },
                        icon: Icon(
                          LineIcons.calendarAlt,
                          color: Colors.black,
                        )))
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
          //         selectDate = DateFormat('dd/MM/yyyy').format(_selectedDate);
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
                  materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // Remove extra padding
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
              title: endtime,
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
          Padding(
              padding: const EdgeInsets.only(top: 8, left: 20),
              child: ElevatedButton(
                onPressed: () async {
                  await showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Pick a color"),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: Color(0xff443a49),
                                paletteType: PaletteType.hueWheel,
                                onColorChanged: (Color value) {
                                  setState(() {
                                    remcolor = value;
                                  });
                                  print(remcolor);
                                },
                              ),
                            ),
                          ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8.0, left: 3.0, right: 3.0),
                  child: Text(
                    "Choose a Color",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w200,
                        fontSize: 12),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  //primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 0.0,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(top: 8, left: 230),
              child: ElevatedButton(
                onPressed: () {


    if (remName.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('Please enter event or reminder name'),
    duration: Duration(seconds: 2),
    ),
    );
    }
    else if (stdate==null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select the start date'),
          duration: Duration(seconds: 2),
        ),
      );
    }
    else if (stdate!.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select future date'),
          duration: Duration(seconds: 2),
          closeIconColor: Colors.redAccent,
        ),
      );
    }
    else if (duedate==null && isevent==true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select the due date'),
          duration: Duration(seconds: 2),
        ),
      );
    }
    else if (duedate!.isBefore(DateTime.now()) && isevent==true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Due date cannot be before start date'),
          duration: Duration(seconds: 2),
          closeIconColor: Colors.redAccent,
        ),
      );
    }
    else {
       _insert();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'Reminder Added',
            style: TextStyle(color: Colors.white),
          )));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => homepg()));
       if(doremind){
         _showNotification(remName.text,remNote.text);
         _showNotificationDue(remName.text,remNote.text);
       }
       Navigator.push(
           context,
           MaterialPageRoute(
               builder: (context) => homepg(gotoIndex: 3,)));
    }



                  // _insert();
                  //
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     backgroundColor: Colors.black,
                  //     content: Text(
                  //       'Reminder Added',
                  //       style: TextStyle(color: Colors.white),
                  //     )));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => homepg()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 3.0, right: 3.0),
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  //primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 0.0,
                ),
              )),
        ]),
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
void _showNotification(String name, String desc) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );
//aare mane topic chnage karvu che ne
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: null,
  );

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
    stdate!.year,
    stdate!.month,
    stdate!.day,
    stdate!.hour,
    stdate!.minute-_remind
  );
//
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    name,
    desc,
    scheduledTime,
    platformChannelSpecifics,
    payload: 'item x',
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
  );
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
