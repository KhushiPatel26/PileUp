// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import 'addrem.dart';
//
// class cal extends StatefulWidget {
//   const cal({Key? key}) : super(key: key);
//
//   @override
//   State<cal> createState() => _calState();
// }
//
// class _calState extends State<cal> {
//   CalendarFormat _calendarFormat=CalendarFormat.month;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(backgroundColor: Colors.white,),
//       body: Column(
//         children: [
//           TableCalendar(
//             firstDay: DateTime.utc(2010, 10, 16),
//             lastDay: DateTime.utc(2030, 3, 14),
//             focusedDay: DateTime.now(),
//             calendarStyle: CalendarStyle(defaultTextStyle: TextStyle(color: Colors.black)),
//             calendarFormat: _calendarFormat,
//             headerStyle: HeaderStyle(
//               titleTextStyle: TextStyle(color: Colors.black),
//               formatButtonDecoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black,width: 0.7)),
//               decoration: BoxDecoration(color: Colors.grey),
//               formatButtonTextStyle: TextStyle(color: Colors.black),
//               //formatButtonVisible: false,
//             ),
//             onDaySelected: (selectedDay, focusedDay) {
//
//             },
//             onFormatChanged: (format) {
//               setState(() {
//                 _calendarFormat = _calendarFormat==CalendarFormat.month? CalendarFormat.week:CalendarFormat.month;
//               });
//             },
//             //pageAnimationCurve: Curves.bounceIn,
//           )
//         ],
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(bottom: 70.0),
//         child: FloatingActionButton(
//           onPressed: (){
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => addrem()));
//           },
//           child: Icon(Icons.add,color: Colors.white,),
//           backgroundColor: Colors.black,
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pup/DB/models.dart';
import 'package:pup/calendar/showrem.dart';
import 'package:pup/colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../DB/ApiService3.dart';
import '../home/profile.dart';
import '../strTodate.dart';
import 'addrem.dart';

class cal extends StatefulWidget {
  const cal({Key? key}) : super(key: key);

  @override
  State<cal> createState() => _calState();
}

class _calState extends State<cal> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  TextEditingController _eventController = TextEditingController();
  Map<DateTime, List<Reminder>> _events = {};
  Map<DateTime, List<dynamic>> _events2 = {};
  Icon i = Icon(
    Icons.calendar_month,
    color: Colors.black,
  );
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  String? uid;
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    uid = user?.uid;
    print("uid:" + uid!);
    _fetchData();
  }

  ApiService3 api = ApiService3();
  List<Reminder> reminders = [];
  Future<void> _fetchData() async {
    final data = await api.readRecords('Reminder');
    setState(() {
      reminders = data
          .map((json) => Reminder.fromJson(json))
          .where((element) => element.uid == uid)
          .toList();
      for(int i=0;i<reminders.length;i++){
        if(reminders[0].startDate!='null')
          print(reminders[i].startDate);
        //print(DateTime.now());
        _events[DateTime.parse(reminders[i].startDate)]= data //aare e as a string lai che
            .map((json) => Reminder.fromJson(json))
            .where((element) => element.uid == uid && element.startDate==reminders[i].startDate)
            .toList();
           //print("date....${DateTime.parse(reminders[i].startDate)}");
          // print("date....${DateFormat('dd-MM-yyyy').format(DateTime.parse(reminders[i].startDate))}");
        // DateTime dt=DateTime.parse(formatDate(DateTime.parse(reminders[i].startDate)));
        //   _events[dt]= data //aare e as a string lai che
        //       .map((json) => Reminder.fromJson(json))
        //       .where((element) => element.uid == uid && element.startDate==reminders[i].startDate)
        //       .toList();
        // _events[DateTime.parse(reminders[i].startDate)]=reminders.map((json) => Reminder.fromJson(json))
        //     .where((element) => element.uid == uid)bol
        //     .toList();//_getEventsForDay(DateTime.parse(reminders[i].startDate));
//        _events.addAll(DateFormat('yyyy-MM-dd').format(reminders[i].startDate));
      }//

    });
    print(reminders);
    print(_events);
   // mapdate(); su haa aare kairu hatu ne
  }
  Future<void> _deleteTask(int rid) async {
    await api.deleteRecord('reminder', 'rid=$rid');
    _fetchData();
  }
  List<dynamic> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 0,
        title: Text(
          'Your Calendar',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, right: 20.0, left: 8.0, bottom: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profile()));
              },
              child: CircleAvatar(
                child: Image.asset(
                  'lib/assets/profile.png',
                  height: 30,
                  width: 30,
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_selectedDay?.day} ${DateFormat('MMMM').format(DateTime(2023, _selectedDay!.month))}',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        '${reminders.length.toString()} Reminder',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.black.withOpacity(.5)),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: yellow, borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                        onPressed: () {
                          //print(_selectedDay);
                          setState(() {
                            _calendarFormat =
                                _calendarFormat == CalendarFormat.month
                                    ? CalendarFormat.week
                                    : CalendarFormat.month;
                          });
                        },
                        icon: _calendarFormat == CalendarFormat.week
                            ? Icon(
                                Icons.calendar_view_week,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.calendar_month,
                                color: Colors.black,
                              )),
                  ),
                ],
              ),

              // SizedBox(
              //   height: 30,
              // ),
              // if (_selectedDay != null) ...[
              //   Text(
              //     'Selected Day:',
              //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //   ),
              //   SizedBox(height: 10),
              //   Text(
              //     '${_selectedDay?.day} ${DateFormat('MMMM').format(DateTime(2023,_selectedDay!.month ))}',
              //     style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
              //   ),
              // ],

              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay, //DateTime.now(),
                headerVisible: true,
               eventLoader: _getEventsForDay,
                calendarStyle: CalendarStyle(
                  markerSize: 5,
                   markersAutoAligned: true,

                  // markersAnchor: 4,
                  // markerMargin: EdgeInsets.only(top: 35),
                  markersMaxCount: 1, // Set the maximum number of markers to display under each date
                  // markersBuilder: (context, date, events, holidays) {
                  //   final children = <Widget>[];
                  //
                  //   if (events.isNotEmpty) {
                  //     children.add(
                  //       Positioned(
                  //         right: 1,
                  //         bottom: 1,
                  //         child: _buildDotMarker(),
                  //       ),
                  //     );
                  //   }
                  //
                  //   return children;
                  // },

                  defaultTextStyle: TextStyle(color: Colors.black),
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: purple,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                ),
                calendarFormat: _calendarFormat,
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 17),
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.transparent, width: 0.7),
                  ),
                  // decoration: BoxDecoration(color: Colors.grey),
                  formatButtonTextStyle: TextStyle(color: Colors.transparent),
                ),
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.
                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    print(_selectedDay);
                  }
                },
                // onFormatChanged: (format) {
                //   if (_calendarFormat != format) {
                //     // Call `setState()` when updating calendar format
                //     setState(() {
                //       _calendarFormat = format;
                //
                //     });
                //   }
                // },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
              ),

              if (reminders != [])
                for (int i = 0; i < reminders.length; i++)
                  //if(_events[_selectedDay]!=[])
                  //if(DateFormat('yyyy-MM-dd').format(DateTime.parse(reminders[i].startDate))==DateFormat('yyyy-MM-dd').format(_selectedDay))
                  if(_selectedDay.isAfter(DateTime.parse(reminders[i].startDate).subtract(Duration(days: 1))) || _selectedDay.isAtSameMomentAs(DateTime.parse(reminders[i].startDate)))
                    if(reminders[i].dueDate!='null')
                     // if(_selectedDay.isBefore(DateTime.parse(reminders[i].dueDate.toString()))  || _selectedDay.isAtSameMomentAs(DateTime.parse(reminders[i].dueDate.toString())))
                      Dismissible(
                          key: Key(reminders[i].rid.toString()),
                          onDismissed: (direction) {
                            //delete code
                            _deleteTask(int.parse(reminders[i].rid.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Reminder Deleted',
                                  style: TextStyle(color: Colors.white),
                                )));
                          },
                          background: Container(
                            color: red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                              child: event_rem(context, i)
                          ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if ((_selectedDay != null) &&
                (_selectedDay!
                    .isAfter(DateTime.now().subtract(Duration(days: 1)))))
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => addrem(selecteddt: _selectedDay),
                    ),
                  );
                },
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Colors.black,
              ),
          ],
        ),
      ),
    );
  }

  Padding event_rem(BuildContext context, int i) {
    return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => showrem(
                                    reminder: reminders[i],
                                  )));
                    },
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(DateFormat('HH:mm').format(DateTime.parse(reminders[i].startDate)),style: TextStyle(color: Colors.black)),
                            if(reminders[i].dueDate.toString()!='null')
                            Text('   to\n'+DateFormat('HH:mm').format(DateTime.parse(reminders[i].dueDate.toString())),style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        SizedBox(width: 5,),
                        Container(
                         // width: double.infinity,
                          width: 280,
                          decoration: BoxDecoration(
                              color: Color(int.parse(reminders[i].color)),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(reminders[i].rname,//_events[_selectedDay]![i].rname,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18)),
                                Text(reminders[i].rdesc.toString(),//_events[_selectedDay]![i].rdesc.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
  }
}
