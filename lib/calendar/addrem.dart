import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:pup/colors.dart';

class addrem extends StatefulWidget {
  const addrem({Key? key}) : super(key: key);

  @override
  State<addrem> createState() => _addremState();
}

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
  int _remind = 0;
  List<int> remindlist = [0, 5, 10, 15, 20];
  DateTime _selectedDate = DateTime.now();
  String selectDate = '';
  Color remcolor = brown;
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
          "Add Task",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textf(mtitle: "Reminder", title: remName, hint: "Add title here"),
          textf(
            mtitle: "Reminder Note",
            title: remNote,
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
                  selectDate = DateFormat('dd/MM/yyyy').format(_selectedDate);
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.black,
                      content: Text(
                        'NoteBook Added',
                        style: TextStyle(color: Colors.white),
                      )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 3.0, right: 3.0),
                  child: Text(
                    "Set Reminder",
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
