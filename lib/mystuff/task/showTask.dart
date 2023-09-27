import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pup/DB/fetch.dart';
import 'package:pup/DB/models.dart';
import 'package:pup/homepg.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart'as http;
import '../../DB/ip.dart';
import '../../colors.dart';


class showTask extends StatefulWidget {
  final ToDoTask todotask;
  const showTask({Key? key, required this.todotask}) : super(key: key);

  @override
  State<showTask> createState() => _showTaskState();
}

class _showTaskState extends State<showTask> {
  String priority='Medium';
  List<Subtask> subtask=[];
  List<bool> checked = [true, true, false, false, true];
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSubtasks();
  }

  Future<void> fetchSubtasks() async {
    print(widget.todotask.taskId);
    final response = await http.get(Uri.parse('http://$ip:3000/readsubtask'));
    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        subtask = list.map((model) => Subtask.fromJson(model)).where((st) => st.taskId == widget.todotask.taskId).toList();
        print(subtask);
      });
    }
    else{
      print("Error");
    }
  }
  Future<void> insertSubTask(String subtaskName, String subtaskDescription, String priority, bool isCompleted) async {
    final response = await http.post(
      Uri.parse('http://$ip:3000/subtasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'taskId': widget.todotask.taskId,
        'subtaskName': subtaskName,
        'subtaskDescription': subtaskDescription,
        'priority': priority,
        'isCompleted': isCompleted.toString(),
      }),
    );

    if (response.statusCode == 200) {
      // Subtask inserted successfully
      print('Subtask inserted successfully.');
      fetchSubtasks();
    } else {
      // Handle the case when the insertion fails
      print('Failed to insert subtask. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateCompleted(int stId, String isdone) async {
    try {
      // Construct the request body as a JSON string
      String requestBody = jsonEncode({'isdone': isdone});
print(isdone+" "+stId.toString());
      final response = await http.put(
        Uri.parse('http://$ip:3000/updateCompleted/$stId'),
        headers: {'Content-Type': 'application/json'}, // Set the request headers
        body: requestBody,
      );

      if (response.statusCode == 200) {
        print('Percentage updated successfully');
        print('Response body: ${response.body}');
        fetchSubtasks();
      } else {
        print('Failed to update percentage. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update percentage. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating percentage: $error');
    }
  }
  Future<void> updateisSubtask(int taskId, int subtask) async {
    try {
      // Construct the request body as a JSON string
      String requestBody = jsonEncode({'isSubtask': subtask});
      print(subtask.toString()+" "+taskId.toString());
      final response = await http.put(
        Uri.parse('http://$ip:3000/updateSubtask/$taskId'),
        headers: {'Content-Type': 'application/json'}, // Set the request headers
        body: requestBody,
      );

      if (response.statusCode == 200) {
        print('Percentage updated successfully');
        print('Response body: ${response.body}');
      } else {
        print('Failed to update percentage. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update percentage. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating percentage: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => homepg()));
        }, icon: Icon(Icons.arrow_back_ios),),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.todotask.taskName,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              widget.todotask.taskDesc,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              widget.todotask.startDate,
              style: TextStyle(color: Colors.black),
            ),
            Text(
                widget.todotask.dueDate,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              widget.todotask.createDate,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "days left: "+ (DateFormat('dd/MM/yyyy').parse(widget.todotask.createDate).difference(DateTime.now()).inDays).toString(),
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
                                        'Add your subtasks',
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
                                            labelText: 'Description',
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
                                            insertSubTask(titleController.text, descController.text, priority, false);
                                            updateisSubtask(widget.todotask.taskId, widget.todotask.subtask+1);
                                            Navigator.of(context).pop();
                                            titleController.clear();
                                            descController.clear();
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
              padding: EdgeInsets.only(
                  top: 16.0,
                  right: 100,
                  left: 20),
              child: Row(
                children: [
                  Text(
                    "Subtasks ",
                    style: TextStyle(
                        fontSize: 25, color: Colors.black),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 1.0,
                          bottom: 1.0,
                          left: 5,
                          right: 5),
                      child: Text(
                        subtask.length.toString(),
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10))),
                  )
                ],
              ),
            ),
            for(int i=0;i<subtask.length;i++)
              taskslist(context,i,subtask[i].subtaskName,subtask[i].subtaskDescription,subtask[i].priority, subtask[i].isCompleted),
          ],
        ),
      ),
    );
  }
  Padding taskslist(BuildContext context,int i, String taskName, String taskDesc,String priority, String isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 20.0, left: 20, top: 10),
      child: Container(
          decoration: BoxDecoration(
            color: priority==100? Colors.black.withOpacity(0.2):priority=='High'? red
                : priority=='Medium'? orange
                : yellow,
            borderRadius: BorderRadius.circular(10),
            // border: Border(right: BorderSide(color: Colors.red, width: 1))
          ),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Checkbox(
                  value: isCompleted=='true'?true:false,
                  onChanged: (bool? value) {

                    String isdone = value! ? 'true' : 'false';
                    updateCompleted(subtask[i].stId, isdone);
                    print(isdone);


                  },
                  //     (bool? value) {
                  //   setState(() {
                  //     checked[0] = value!;lll
                  //   });
                  // },
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
                            taskName.length<25?taskName:taskName.substring(0,6)+'...',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              decoration: isCompleted == 'true'
                                  ? TextDecoration
                                  .lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        taskDesc,
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
    );
  }
}
