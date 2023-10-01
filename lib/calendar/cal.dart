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
  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
  import 'package:table_calendar/table_calendar.dart';

  import 'addrem.dart';

  class cal extends StatefulWidget {
    const cal({Key? key}) : super(key: key);

    @override
    State<cal> createState() => _calState();
  }

  class _calState extends State<cal> {
    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime? _selectedDay;//=DateTime.now();
    DateTime _focusedDay=DateTime.now();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,//DateTime.now(),
              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(color: Colors.black),
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
              calendarFormat: _calendarFormat,
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.black),
                formatButtonDecoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 0.7),
                ),
                decoration: BoxDecoration(color: Colors.grey),
                formatButtonTextStyle: TextStyle(color: Colors.black),
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
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
            ),
            SizedBox(height: 20),
            if (_selectedDay != null) ...[
              Text(
                'Selected Day:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '${_selectedDay?.day} ${DateFormat('MMMM').format(DateTime(2023,_selectedDay!.month ))}',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if(( _selectedDay!=null) && (_selectedDay!.isAfter(DateTime.now().subtract(Duration(days: 1)))))
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => addrem(),
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
  }
