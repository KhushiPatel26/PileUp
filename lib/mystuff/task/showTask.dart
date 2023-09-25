import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../colors.dart';


class showTask extends StatefulWidget {
  const showTask({Key? key}) : super(key: key);

  @override
  State<showTask> createState() => _showTaskState();
}

class _showTaskState extends State<showTask> {
  String priority='';
  List<bool> checked = [true, true, false, false, true];
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text(
            "Task Name",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "Task Desc",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "start date",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "due date",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "days left",
            style: TextStyle(color: Colors.black),
          ),
          ElevatedButton(
            onPressed: () async {
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
                                    backgroundColor: Colors.black,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 20, bottom: 10),
                                    child: Text(
                                      'Add SubTask',
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF101213),
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, bottom: 5),
                                    child: Text(
                                      'Invite your Team Members',
                                      style: TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF101213),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 10, 16),
                                    child: Container(
                                      width: 370,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                            offset: Offset(0, 7),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        controller: titleController,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Task Name',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFF1F4F8),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFF1F4F8),
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 10, 16),
                                    child: Container(
                                      width: 370,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                            offset: Offset(0, 7),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        controller: descController,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF57636C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFF1F4F8),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFF1F4F8),
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                    ),
                                  ),
                                  ToggleSwitch(
                                    minWidth: 70.0,
                                    minHeight: 50.0,
                                    fontSize: 12.0,
                                    initialLabelIndex: 1,
                                    activeBgColor: [Colors.black],//[priority=='High'?Colors.red:(priority=='Medium'?Colors.orange:Colors.yellowAccent)],
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
                                  Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor:
                                                      Colors.black12
                                                          .withOpacity(
                                                              0.2),
                                                  content: Text(
                                                      'Task Added')));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(
                                                  top: 5.0,
                                                  bottom: 5.0,
                                                  left: 3.0,
                                                  right: 3.0),
                                          child: Text(
                                            "Add SubTask",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                    FontWeight.w400,
                                                fontSize: 12),
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.black,
                                          //primary: Colors.black,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
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
            },
            child: Text(
              "add sub task",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 20.0, left: 20, top: 10),
            child: Container(
                decoration: BoxDecoration(
                  color: checked[0]
                      ? Colors.black.withOpacity(0.1)
                      : red,
                  borderRadius: BorderRadius.circular(10),
                  // border: Border(right: BorderSide(color: Colors.red, width: 1))
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Checkbox(
                        value: checked[0],
                        onChanged: (bool? value) {
                          setState(() {
                            checked[0] = value!;
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
                            Text(
                              "taskName",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                decoration: checked[0]
                                    ? TextDecoration
                                    .lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            Text(
                              "desc",
                              style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.6),
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
