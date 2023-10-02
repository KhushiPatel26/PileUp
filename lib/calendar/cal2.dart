// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class cal2 extends StatefulWidget {
//   @override
//   _cal2State createState() => _cal2State();
// }
//
// class _cal2State extends State<cal2> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//
//   Map<DateTime, List<String>> _events = {
//     DateTime.utc(2023, 9, 20): ['Event A'],
//     DateTime.utc(2023, 9, 22): ['Event B', 'Event C'],
//     DateTime.utc(2023, 9, 25): ['Event D'],
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Calendar with Events'),
//       ),
//       body: Column(
//         children: [
//           TableCalendar(
//             firstDay: DateTime.utc(2023, 9, 1),
//             lastDay: DateTime.utc(2023, 9, 30),
//             focusedDay: _focusedDay,
//             calendarFormat: _calendarFormat,
//             eventLoader: (day) => _events[day] ?? [],
//             calendarStyle: CalendarStyle(
//
//               eventDecorationMargin: EdgeInsets.all(2.0),
//               //eventDecorationForDay:
//               selectedDecoration: const  _events.isNotEmpty? BoxDecoration(
//     color: Colors.blue.withOpacity(0.5),
//     shape: BoxShape.circle,
//     ) : null
//             ),
//             onDaySelected: (selectedDay, focusedDay) {
//               setState(() {
//                 _selectedDay = selectedDay;
//               });
//             },
//             onFormatChanged: (format) {
//               setState(() {
//                 _calendarFormat = format;
//               });
//             },
//             onPageChanged: (focusedDay) {
//               _focusedDay = focusedDay;
//             },
//           ),
//           SizedBox(height: 20),
//           if (_selectedDay != null) ...[
//             Text(
//               'Events for ${_selectedDay?.day}/${_selectedDay?.month}/${_selectedDay?.year}:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             ...(_events[_selectedDay] ?? []).map((event) => Text(event)),
//           ],
//         ],
//       ),
//     );
//   }
// }
