import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:pup/colors.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../DB/ApiService3.dart';
import '../../DB/models.dart';

class assigntask extends StatefulWidget {
  final int projid;
  const assigntask({Key? key, required this.projid}) : super(key: key);

  @override
  State<assigntask> createState() => _assigntaskState();
}

class _assigntaskState extends State<assigntask> {

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    controller.dispose();
    mem.clear();
    subtasks.clear();
    checkboxListTiles.clear();
    _subtaskController.clear();
    _titleController.clear();
    selectedMembers.clear();
    super.dispose();
  }

  late QuillEditorController controller;
  TextEditingController tasktopic = TextEditingController();
  TextEditingController taskdesc = TextEditingController();
  DateTime? duedate;
  List<String> assignToPeople = [];
  String priority = "Medium";
  String status = "In Progress";
  List<String> subtasks = [];
  TextEditingController _subtaskController = TextEditingController();
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
  List<String> files=[];
  String desc='';
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
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    uid = user?.uid;
    print("uid:" + uid!);
    _fetchData();
  }
  ApiService3 api = ApiService3();

  List<Project> proj=[];
  List<Comp_Mem> compmem=[];
  List<Userstb> users=[];
  List<AssTask> asstask=[];
  String compCode="";
  Future<void> _fetchData() async {
    final data2 = await api.readRecords('Comp_Mem');
    final projdata = await api.readRecords('Project');
    setState(() {
      compmem = data2.map((json) => Comp_Mem.fromJson(json)).where((element) => element.uid==uid).toList();
      compCode=compmem[0].companyCode;
      compmem = data2.map((json) => Comp_Mem.fromJson(json)).where((element) => element.companyCode==compCode).toList();
      proj = projdata.map((json) => Project.fromJson(json)).where((element) => element.projectId==widget.projid).toList();
    });
    print("Comp_Mem:");
    print(compmem);

    final data3 = await api.readRecords('Users');
    setState(() {
      for(int i=0;i<compmem.length;i++){
        users = data3.map((json) => Userstb.fromJson(json)).where((element) => element.uid==compmem[i].uid).toList();
        mem.putIfAbsent(users[0].name, () => _getRandomColor());
        name_id.putIfAbsent(users[0].name, () => users[0].uid!);
      }
    });
    print("Users:");
    print(users);
  }


  Future<void> _insert() async {
    final record = AssTask(
      pid: widget.projid,
        postedBy: uid.toString(),
        msg: tasktopic.text,
        issubtask: subtasks.length==0?'false':'true',
        isfile: files.length==0?'false':'true',
        desc:desc,
        duedate:duedate.toString(),
        priority:priority,
      timing: DateTime.now().toString()
    );
    await api.createRecord('AssTask', record.toJson());
    print("Successfully row added in Assign Task");
    _fetchAssT();
  }
  int? taskId;
  List<ToDoTask> todo=[];
  Future<void> _fetchAssT() async{
    print("in");
    final data = await api.readRecords('Asstask');
    final datatid = await api.readRecords('ToDoTasks');
    setState(() {
      asstask = data.map((json) => AssTask.fromJson(json)).where((element) => element.pid==widget.projid && element.msg==tasktopic.text).toList();
      todo = datatid.map((json) => ToDoTask.fromJson(json)).where((element) => element.usId==uid).toList();//[0].taskId!;
      taskId=todo[0].taskId;
    });
    print("Ass Task:");
    print(asstask);
    print(taskId);
    _insertAssTData();
  }

  Future<void> _insertAssTData() async{

    //await api.createRecord('Assmem', record2.toJson());
    for(int i=0;i<selectedMembers.length;i++) {
      var record2= Assmem(
          assid: asstask[0].assid!,
          uid: name_id[selectedMembers[i]]!
      );
      await api.createRecord('Assmem', record2.toJson());
      print("Successfully row added in Assign Members");
      //--- insert in task table--------
      var task_data = ToDoTask(
        usId: name_id[selectedMembers[i]]!,
        taskName: tasktopic.text,
        taskDesc: desc,
        precent: 0.0,
        startDate: DateTime.now().toString(),
        dueDate: duedate.toString(),
        priority: priority,
        remind: 'yes',//doremind ? 'never' : _remind.toString(),
        status: 'in progress',
        category: 'Work',
        labels: proj[0].name,
        subtask: subtasks.length,
        createDate: DateTime.now().toString(),
    );
      await api.createRecord('ToDoTasks', task_data.toJson());
      print("Successfully row added in ToDoTasks");
    }
    for(int i=0;i<subtasks.length;i++) {
      var record2= Asssubtask(
          assid: asstask[0].assid!,
          subtask: subtasks[i],
          isCompleted: 'false'
      );
      await api.createRecord('Asssubtask', record2.toJson());
      print("Successfully row added in Asssubtask");

        var subtaskdata= Subtask(
            taskId: taskId!,
            subtaskName: subtasks[i],
            priority: priority,
            isCompleted: 'false'
        );
        await api.createRecord('Subtasks', subtaskdata.toJson());
        print("Successfully row added in Subtasks");


    }
  }



  List<Widget> checkboxListTiles = [];
  TextEditingController _titleController = TextEditingController();

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
                  descText();
                  _insert();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.white,
                      content: Text(
                        'Task Assigned',
                        style: TextStyle(color: Colors.black),
                      )));
                  Navigator.pop(context);
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
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              enableDrag: true,
                              context: context,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(25),
                                  topStart: Radius.circular(25),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return SingleChildScrollView(child: MemberListBottomSheet());
                              },
                            );
                          },
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
                        Text(duedate != null?"${DateFormat('dd/MM/yyyy HH:mm').format(duedate!)}":"Select Due Date -",
                            style:
                            TextStyle(color: Colors.black.withOpacity(0.5))),
                        Visibility(
                          visible:duedate!=null?duedate!.isBefore(DateTime.now()):false ,
                          child: Text(
                            "Set future date timing!",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.red.withOpacity(0.6),
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: duedate!=null?(duedate!.isBefore(DateTime.now())?Colors.red:Colors.black):Colors.black, width: duedate!=null?(duedate!.isBefore(DateTime.now())?0.7:0.2):0.2),
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                            onPressed: () async {
                              DateTime? dateTime = await showOmniDateTimePicker(
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
                              color: duedate!=null?(duedate!.isBefore(DateTime.now())?Colors.red:Colors.black):Colors.black,
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
                      padding: const EdgeInsets.only(left: 20.0),
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
                          priority = index == 0
                              ? 'High'
                              : (index == 1 ? 'Medium' : 'Low');
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
                    child:
                        Text("Status:", style: TextStyle(color: Colors.black)),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.green.withOpacity(0.6),
                            size: 10,
                          ),
                          Text("   In Progress",
                              style: TextStyle(
                                  color: Colors.green.withOpacity(0.6))),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: green.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.green.withOpacity(0.6))),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _addSubtask();
                      },
                      icon: Icon(
                        Icons.add_circle_outlined,
                        color: Colors.black,
                      )),
                  Text("Add Subtask", style: TextStyle(color: Colors.black))
                ],
              ),
              for(int i=0;i<subtasks.length;i++)
        Container(
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (bool? value) {},
                side: BorderSide(color: Colors.black), // Reduce the checkbox size
                shape: CircleBorder(),
              ),
              SizedBox(width: 8),
              Container(
                width: 200,
                child: Text(
                  subtasks[i],style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              setState(() {
                subtasks.remove(subtasks[i]);
              });
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 18,
            ),
          )
        ],
      ),
    ),


              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: false,
              //             onChanged: (bool? value) {},
              //             side: BorderSide(
              //                 color: Colors.black), // Reduce the checkbox size
              //             shape: CircleBorder(),
              //           ),
              //           Text("Subtask 1",
              //               style: TextStyle(color: Colors.black)),
              //         ],
              //       ),
              //       IconButton(
              //           onPressed: () {},
              //           icon: Icon(
              //             Icons.close,
              //             color: Colors.black,
              //             size: 18,
              //           ))
              //     ],
              //   ),
              // ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle_outlined,
                        color: Colors.black,
                      )),
                  Text("Attach Files", style: TextStyle(color: Colors.black))
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
        for(int i=0;i<selectedMembers.length;i++)
          _buildChip(selectedMembers[i], mem[selectedMembers[i]]!),
        // _buildChip('Hacker', blue),
        // _buildChip('Developer', brown),
        // _buildChip('Racer', orange),
        // _buildChip('Traveller', green),
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
        print("delete");
        selectedMembers.remove(label);// Do something when the chip is deleted
      },
      side: BorderSide(color: color),
      backgroundColor: color.withOpacity(0.9),
      elevation: 0.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }


  void _addSubtask()async {
    await showDialog<void>(
        context: context,
        builder: (context) => Container(
          height: 600,
          width: 720,
          child: AlertDialog(
            backgroundColor: Colors.white,
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  left: -40,
                  top: -40,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      backgroundColor:
                      Colors.black,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          top: 10.0,
                          left: 20,
                          bottom: 10),
                      child: Text(
                        'Add Subtask',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color:
                          Color(0xFF101213),
                          fontSize: 25,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),


                    Padding(
                      padding:
                      EdgeInsetsDirectional
                          .fromSTEB(
                          10, 0, 10, 16),
                      child: Container(
                        width: 370,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius
                              .circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(
                                  0.3),
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset:
                              Offset(0, 7),
                            ),
                          ],
                        ),
                        child: TextFormField(
                            controller:
                            _subtaskController,
                            autofocus: true,
                            autofillHints: [
                              AutofillHints.email
                            ],
                            obscureText: false,
                            decoration:
                            InputDecoration(
                              labelText:
                              'Add Subtask',
                              labelStyle:
                              TextStyle(
                                fontFamily:
                                'Plus Jakarta Sans',
                                color: Color(
                                    0xFF57636C),
                                fontSize: 14,
                                fontWeight:
                                FontWeight
                                    .w300,
                              ),
                              enabledBorder:
                              OutlineInputBorder(
                                borderSide:
                                BorderSide(
                                  color: Color(
                                      0xFFF1F4F8),
                                  width: 2,
                                ),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    50),
                              ),
                              focusedBorder:
                              OutlineInputBorder(
                                borderSide:
                                BorderSide(
                                  color: Colors
                                      .black,
                                  width: 1,
                                ),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    50),
                              ),
                              errorBorder:
                              OutlineInputBorder(
                                borderSide:
                                BorderSide(
                                  color: Color(
                                      0xFFFF5963),
                                  width: 2,
                                ),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    50),
                              ),
                              focusedErrorBorder:
                              OutlineInputBorder(
                                borderSide:
                                BorderSide(
                                  color: Color(
                                      0xFFFF5963),
                                  width: 2,
                                ),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    50),
                              ),
                              filled: true,
                              fillColor: Color(
                                  0xFFF1F4F8),
                            ),
                            style: TextStyle(
                              fontFamily:
                              'Plus Jakarta Sans',
                              color: Color(
                                  0xFF101213),
                              fontSize: 14,
                              fontWeight:
                              FontWeight.w400,
                            ),
                            keyboardType:
                            TextInputType
                                .text),
                      ),
                    ),
                    Padding(
                        padding:
                        const EdgeInsets.all(
                            8),
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(
                                context)
                                .showSnackBar(
                                SnackBar(
                                    backgroundColor:
                                    Colors
                                        .white,
                                    content:
                                    Text(
                                      'Subtask Added',
                                      style: TextStyle(
                                          color:
                                          Colors.black),
                                    )));

                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets
                                .only(
                                top: 5.0,
                                bottom: 5.0,
                                left: 3.0,
                                right: 3.0),
                            child: Text(
                              "Add Subtask",
                              style: TextStyle(
                                  color: Colors
                                      .white,
                                  fontWeight:
                                  FontWeight
                                      .w400,
                                  fontSize: 12),
                            ),
                          ),
                          style: ElevatedButton
                              .styleFrom(
                            backgroundColor:
                            Colors.black,
                            //primary: Colors.black,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors
                                        .black),
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    30)),
                            elevation: 0.0,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));

    setState(() {
      subtasks.add(_subtaskController.text);
      _subtaskController.clear();
    });
  }
  ///[getHtmlText] to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await controller.getText();
    debugPrint(htmlText);
  }

  void descText() async {
    //projdesc
    String htmlString = await controller.getText();
    final document = parse(htmlString);
    String parsedString = parse(document.body!.text).documentElement!.text;
    desc = parsedString;
    //debugPrint(htmlText);
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
String? uid;
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
Random _random = Random();
Color _getRandomColor() {
  int r = _random.nextInt(250);
  int g = _random.nextInt(250);
  int b = _random.nextInt(250);
  return Color.fromRGBO(r, g, b, 1.0);
}
Map<String, Color> mem = {};
Map<String, String> name_id = {};
List<String> selectedMembers = [];

class MemberListBottomSheet extends StatefulWidget {
  @override
  _MemberListBottomSheetState createState() => _MemberListBottomSheetState();
}

class _MemberListBottomSheetState extends State<MemberListBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Add Members",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontSize: 20)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                if(selectedMembers.length==0)
                  CircleAvatar(
                    child: Icon(Icons.person_add_alt_sharp),
                    backgroundColor: Colors.transparent,
                  ),

                if(selectedMembers.length>0)
                  for(int i=0;i<selectedMembers.length;i++)
                    Padding(
                      padding: EdgeInsets.only(left: i.toDouble()*10.0),
                      child: CircleAvatar(
                        backgroundColor: mem[selectedMembers[i]],
                        child: Text(selectedMembers[i][0]),
                      ),
                    )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mem.length,
              itemBuilder: (context, index) {
                return name_id[mem.keys.elementAt(index)]!=uid? ListTile(
                  leading: CircleAvatar(child: Text(mem.keys.elementAt(index)[0]),
                    backgroundColor: mem.values.elementAt(index),
                  ),
                  title: Text(mem.keys.elementAt(index),
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Checkbox(
                    side: BorderSide(color: Colors.black),
                    shape: CircleBorder(),
                    activeColor: Colors.black,
                    value: selectedMembers.contains(mem.keys.elementAt(index)),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedMembers.add(mem.keys.elementAt(index));
                        } else {
                          selectedMembers.remove(mem.keys.elementAt(index));
                        }
                      });
                    },
                  ),
                ) : Container();
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Do something with the selected members
              setState(() {
                selectedMembers=selectedMembers;
              });
              print('Selected Members: $selectedMembers');
              Navigator.pop(context);
            },
            child: Text('Add Members',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}