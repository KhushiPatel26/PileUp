import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:pup/colors.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:toggle_switch/toggle_switch.dart';

class assigntask extends StatefulWidget {
  const assigntask({Key? key}) : super(key: key);

  @override
  State<assigntask> createState() => _assigntaskState();
}

class _assigntaskState extends State<assigntask> {
  late QuillEditorController controller;
  TextEditingController tasktopic = TextEditingController();
  TextEditingController taskdesc = TextEditingController();
  DateTime? duedate;
  List<String> assignToPeople = [];
  String priority = "Medium";
  String status = "In Progress";
  List<String> subtasks = [];

  Color _backgroundColor = Color(0xFF212121);
  final _toolbarColor = Colors.black; //grey.shade200;
  //final _backgroundColor = Colors.black.withOpacity(0.5);
  final _toolbarIconColor = Colors.white30;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);
  final texteditingTools = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.strike,
    ToolBarStyle.underline,
    ToolBarStyle.color,
    ToolBarStyle.background,
  ];
  final alignTools = [
    ToolBarStyle.align,
    ToolBarStyle.directionLtr,
    ToolBarStyle.directionRtl,
    ToolBarStyle.indentAdd,
    ToolBarStyle.indentMinus,
  ];
  final formatTools = [ToolBarStyle.blockQuote, ToolBarStyle.codeBlock];
  final sizeTools = [
    ToolBarStyle.size,
    ToolBarStyle.headerOne,
    ToolBarStyle.headerTwo
  ];
  final unreTools = [ToolBarStyle.undo, ToolBarStyle.redo];
  final strucTools = [
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];
  final cleanTools = [ToolBarStyle.clean, ToolBarStyle.clearHistory];
  final fileTools = [ToolBarStyle.image, ToolBarStyle.video, ToolBarStyle.link];

  bool _hasFocus = false;
  bool maintoolbox = true;
  List<ToolBarStyle> toolList = [];
  @override
  void initState() {
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    // controller.onEditorLoaded(() {
    //   debugPrint('Editor Loaded :)');
    // });
    super.initState();
  }

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Assign Task",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.cancel_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.white,
                      content: Text(
                        'Message Posted',
                        style: TextStyle(color: Colors.black),
                      )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 3.0, bottom: 3.0, left: 3.0, right: 3.0),
                  child: Text(
                    "SEND",
                    style: TextStyle(
                        wordSpacing: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
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
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10.0, bottom: 10, left: 15, right: 15),
          child: Column(
            children: [
              textf(
                  mtitle: "Task Name", title: tasktopic, hint: "Task Name..."),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Assign to:",
                      style: TextStyle(color: Colors.black),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 0.7)),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 15,
                            weight: 0.7,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                width: 300,
                child: chipList(),
              ),
              Container(
                color: Colors.white12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Text(
                        "Task Description",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    QuillHtmlEditor(
                      //  text: "<h1>Hello</h1>This is a <b>quill</b> html editor example 😊",
                      hintText: 'Write description',
                      controller: controller,
                      isEnabled: true,
                      //ensureVisible: false,
                      minHeight: 150,
                      //autoFocus: false,
                      textStyle: _editorTextStyle,
                      hintTextStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black38,
                          fontWeight: FontWeight.normal),
                      hintTextAlign: TextAlign.start,
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      hintTextPadding: const EdgeInsets.only(left: 20),
                      backgroundColor: Colors.white12, //_backgroundColor,
                      //inputAction: InputAction.newline,
                      // onEditingComplete: (s) => debugPrint('Editing completed $s'),
                      //  loadingBuilder: (context) {
                      //    return const Center(
                      //        child: CircularProgressIndicator(
                      //          strokeWidth: 1,
                      //          color: Colors.red,
                      //        ));
                      //  },
                      onFocusChanged: (focus) {
                        debugPrint('has focus $focus');
                        setState(() {
                          _hasFocus = focus;
                        });
                      },
                      onTextChanged: (text) =>
                          debugPrint('widget text change $text'),
                      onEditorCreated: () {
                        debugPrint('Editor has been loaded');
                        //setHtmlText('Testing text on load');
                      },
                      onEditorResized: (height) =>
                          debugPrint('Editor resized $height'),
                      onSelectionChanged: (sel) =>
                          debugPrint('index ${sel.index}, range ${sel.length}'),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.all(7),
                      child: Column(
                        children: [
                          Visibility(
                            visible: !maintoolbox,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 250,
                                    child: ToolBar(
                                        toolBarColor: _toolbarColor,
                                        padding: const EdgeInsets.all(8),
                                        iconSize: 25,
                                        iconColor:
                                            Colors.grey, //_toolbarIconColor,
                                        activeIconColor: Colors
                                            .white, //greenAccent.shade100,
                                        controller: controller,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        toolBarConfig:
                                            toolList //fileTools//cleanTools//strucTools//unreTools//sizeTools//formatTools//texteditingTools//alignTools,
                                        ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        maintoolbox = true;
                                      });
                                    },
                                    icon: Icon(Icons.cancel_rounded))
                              ],
                            ),
                          ),
                          Visibility(
                            visible: maintoolbox,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        maintoolbox = false;
                                        toolList = unreTools;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.alt_route_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        maintoolbox = false;
                                        toolList = texteditingTools;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.text_format,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        maintoolbox = false;
                                        toolList = strucTools;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.format_list_bulleted,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        maintoolbox = false;
                                        toolList = alignTools;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.format_align_center,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        maintoolbox = false;
                                        toolList = sizeTools;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.format_size,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        maintoolbox = false;
                                        toolList = formatTools;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.format_quote,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        maintoolbox = false;
                                        toolList = cleanTools;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.layers_clear_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        maintoolbox = false;
                                        toolList = fileTools;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.attachment,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Due Date:",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text("$duedate",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.5)))
                      ],
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.black, width: 0.7),
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                            onPressed: () async {
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
  duedate=dateTime;
});
                              print("dateTime: $dateTime");
                            },
                            icon: Icon(
                              LineIcons.calendarAlt,
                              color: Colors.black,
                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0, left: 10, bottom: 0),
                      child: Text(
                        "Priority:",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: ToggleSwitch(
                        minWidth: 70.0,
                        minHeight: 30.0,
                        fontSize: 12.0,
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
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Status:",style: TextStyle(color: Colors.black)),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: Row(
                        children: [
                          Icon(Icons.circle,color: Colors.green.withOpacity(0.6),size: 10,),
                          Text("   In Progress",style: TextStyle(color: Colors.green.withOpacity(0.6))),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: green.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.withOpacity(0.6))
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_outlined,color: Colors.black,)),
                  Text("Add Subtask",style: TextStyle(color: Colors.black))
                ],
              ),
              //for(int i=0;i<subtasks.length;i++)
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (bool? value) { },
                          side: BorderSide(
                              color: Colors
                                  .black), // Reduce the checkbox size
                          shape: CircleBorder(),
                        ),
                        Text("Subtask 1",style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.close,color: Colors.black,size: 18,))
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_outlined,color: Colors.black,)),
                  Text("Attach Files",style: TextStyle(color: Colors.black))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  chipList() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 4.0,
      children: <Widget>[
        _buildChip('Gamer', pink),
        _buildChip('Hacker', blue),
        _buildChip('Developer', brown),
        _buildChip('Racer', orange),
        _buildChip('Traveller', green),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      ),
      onDeleted: () {
        // Do something when the chip is deleted
      },
      side: BorderSide(color: color),
      backgroundColor: color.withOpacity(0.9),
      elevation: 0.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }

  ///[getHtmlText] to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await controller.getText();
    debugPrint(htmlText);
  }

  ///[setHtmlText] to set the html text to editor
  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  ///[insertNetworkImage] to set the html text to editor
  void insertNetworkImage(String url) async {
    await controller.embedImage(url);
  }

  ///[insertVideoURL] to set the video url to editor
  ///this method recognises the inserted url and sanitize to make it embeddable url
  ///eg: converts youtube video to embed video, same for vimeo
  void insertVideoURL(String url) async {
    await controller.embedVideo(url);
  }

  /// to set the html text to editor
  /// if index is not set, it will be inserted at the cursor postion
  void insertHtmlText(String text, {int? index}) async {
    await controller.insertText(text, index: index);
  }

  /// to clear the editor
  void clearEditor() => controller.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => controller.enableEditor(enable);

  /// method to un focus editor
  void unFocusEditor() => controller.unFocus();
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
            border: Border(
              bottom: BorderSide(color: Colors.black54, width: 0.3),
            ),
            //borderRadius: BorderRadius.circular(12)
          ),
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
                  ),
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

/*
ElevatedButton(
                onPressed: () async {
                  DateTime? dateTime = await showOmniDateTimePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime(1600).subtract(const Duration(days: 3652)),
                    lastDate: DateTime.now().add(
                      const Duration(days: 3652),
                    ),
                    is24HourMode: false,
                    isShowSeconds: false,
                    minutesInterval: 1,
                    secondsInterval: 1,
                    isForce2Digits: true,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                    transitionDuration: const Duration(milliseconds: 200),
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

                  print("dateTime: $dateTime");
                },
                child: const Text(
                  "Show DateTime Picker",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  List<DateTime>? dateTimeList =
                      await showOmniDateTimeRangePicker(
                    context: context,
                    startInitialDate: DateTime.now(),
                    startFirstDate:
                        DateTime(1600).subtract(const Duration(days: 3652)),
                    startLastDate: DateTime.now().add(
                      const Duration(days: 3652),
                    ),
                    endInitialDate: DateTime.now(),
                    endFirstDate:
                        DateTime(1600).subtract(const Duration(days: 3652)),
                    endLastDate: DateTime.now().add(
                      const Duration(days: 3652),
                    ),
                    is24HourMode: false,
                    isShowSeconds: false,
                    minutesInterval: 1,
                    secondsInterval: 1,
                    isForce2Digits: true,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                    transitionDuration: const Duration(milliseconds: 200),
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

                  print("Start dateTime: ${dateTimeList?[0]}");
                  print("End dateTime: ${dateTimeList?[1]}");
                },
                child: const Text(
                  "Show DateTime Range Picker",
                  style: TextStyle(color: Colors.white),
                ),
              ),
* */