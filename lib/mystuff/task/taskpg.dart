import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pup/mystuff/task/addtask.dart';
import 'package:pup/mystuff/mystuff.dart';
import 'package:pup/mystuff/task/showTask.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pup/mystuff/task/stats_hist.dart';
import '../../DB/ip.dart';
import '../../DB/models.dart';
import '../../colors.dart';
import '../../home/profile.dart';
import '../../homepg.dart';
import '../../main.dart';
import 'package:pup/notif/notification.dart';
class ToDoTaskUpdater {
  static Future<void> updatePercentage(int taskId, double newPercentage) async {
    final response = await http.put(
      Uri.parse('http://$ip:3000/updatePercentage/$taskId'),
      body: {'newPercentage': newPercentage},
    );

    if (response.statusCode == 200) {
      print('Percentage updated successfully');
    } else {
      throw Exception('Failed to update percentage');
    }
  }
}
class taskpg extends StatefulWidget {
  const taskpg({Key? key}) : super(key: key);

  @override
  State<taskpg> createState() => _taskpgState();
}
List<bool> checked = [true, true, false, false, true];
int _selectedIndex = 0;
int _selected = 0;
class _taskpgState extends State<taskpg> {
  Future<void> updatePercentage(int taskId, double newPercentage) async {
    try {
      double percentage = newPercentage;
      print("ok$percentage");

      // Construct the request body as a JSON string
      String requestBody = jsonEncode({'newPercentage': percentage.toString()});

      final response = await http.put(
        Uri.parse('http://$ip:3000/updatePercentage/$taskId'),
        headers: {'Content-Type': 'application/json'}, // Set the request headers
        body: requestBody,
      );

      if (response.statusCode == 200) {
        print('Percentage updated successfully');
        print('Response body: ${response.body}');
        fetchTaskData();
      } else {
        print('Failed to update percentage. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update percentage. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating percentage: $error');
    }
  }


  Map<String, List<String>> _tags = {
    "All": [],
    "Personal": ["1", "2", "3"],
    "College": ["Project", "b", "c"]
  };

  int All=0;
  int Personal=0;
  int College=0;
  late User? user;
  late String? uid;
  List<Userstb> login = [];
  List<ToDoTask> todotask = [];
  List<ToDoTask> tgrp = [];
  List<ToDoTask> tprog = [];
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = _auth.currentUser;
    uid=user!.uid;
    print("uid:"+uid!);
    fetchUserData();
    fetchTaskData();
    // fetchPostsById(uid);
  }
  Map<String, int> _tags2={};

  Future<void> fetchUserData() async {
    final response = await http.get(Uri.parse('http://$ip:3000/user?email=${user?.email}'));

    if (response.statusCode == 200) {
      setState(() {

        Iterable list = json.decode(response.body);
        login=list
            .map((model) => Userstb.fromJson(model)) // Add a null check here
            .where((user) => user.uid == uid) // Filter out null users
            .toList();
        print(login[0].name);
      });
    } else {
      throw Exception('Failed to load user data'+response.statusCode.toString());
    }
  }
  Future<void> fetchTaskData() async {
    final response = await http.get(Uri.parse('http://$ip:3000/Tasks'));
    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        //tasks
        All=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid) // Filter out null users
            .toList().length;
        College=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.category=='College') // Filter out null users
            .toList().length;
        Personal=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.category=='Personal') // Filter out null users
            .toList().length;
        todotask=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.precent==0.0 && task.subtask==0) // Filter out null users
            .toList();
        print(todotask);
        //task groups
        tgrp=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.subtask>0) // Filter out null users
            .toList();
        print("tgrp");
        print(tgrp);
        //in progress
        tprog=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.precent>0.0 ) // Filter out null users
            .toList();
        print("tgrp");
        print(tprog);
        _tags2 = {
          "All": All,
          "Personal":Personal,
          "College": College
        };
        // _tags = {
        //   "All": ,
        //   "Personal": ["1", "2", "3"],
        //   "College": ["Project", "b", "c"]
        // };
        for (int i=0;i<todotask.length;i++) {
          print(todotask[i].toJson());
          // Add your code to process the retrieved data
        }
      });
    } else {
      throw Exception('Failed to load user data'+response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return login.length==0? Scaffold(backgroundColor: Colors.white,body: Center(child: CircularProgressIndicator())) : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(
              top: 15.0, right: 20.0, left: 8.0, bottom: 8.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => profile()));
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
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 70.0),
                child: Text(
                  'Hello!',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontSize: 15),
                ),
              ),
              Text(
                login[0].name,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 5),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => stats_hist()));
                },
                icon: Icon(
                  Icons.query_stats,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body:
      SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 16.0, right: visible ? 100 : 150, left: 20),
                  child: Text(
                    "My Tasks",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => addtask()));
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),

            // todotask.length==0?
            // Center(
            //   child: Column(
            //     children: [
            //       SizedBox(height: 50,),
            //       Image.asset('lib/assets/img_2.png',width: 250,height: 270,),
            //       Text('There are no tasks, you are up-to date!', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),)
            //     ],
            //   ),
            // ) :

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, top: 15),
                      child: Container(
                        width: 370,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Color(0xFFDEECEC),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, top: 10, bottom: 12),
                                child: Text(
                                  "Your today's task\n"
                                  "almost done!",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Readex Pro',
                                      fontWeight: FontWeight.w300,
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => homepg()),
                                    // );
                                    // NotificationAppLaunchDetails? notificationAppLaunchDetails = null;
                                    //  HomePage homePageInstance = HomePage(notificationAppLaunchDetails);


                                  },
                                  child: Text(
                                    "View Tasks",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    //primary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    elevation: 4.0,
                                  )),
                            ]),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularPercentIndicator(
                                radius: 35.0,
                                lineWidth: 8.0,
                                percent: (32.toDouble()) / 100,
                                center: Text("32%",
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                                progressColor: Colors.black,
                                backgroundWidth: 8,
                                backgroundColor: Colors
                                    .black12, //Color(0xFFF9EB95),//Colors.yellow.shade200,
                                //fillColor: Colors.yellow.shade400,
                                animation: true,
                                // animationDuration: ,
                                // header: Padding(
                                //   padding: const EdgeInsets.all(12.0),
                                //   child: Text("${(_count.toDouble())}"),
                                // ),
                                // footer: Padding(
                                //   padding: const EdgeInsets.all(12.0),
                                //   child: Text("${(_count.toDouble())}"),
                                // ),
                                // linearGradient: LinearGradient(
                                //   colors: [Colors.white,Colors.black],
                                // ),
                                circularStrokeCap: CircularStrokeCap.round,
                                startAngle: 0.0,
                                // animateFromLastPercent: true,
                                //   addAutomaticKeepAlive: true,
                                // arcType: ArcType.HALF,
                                // arcBackgroundColor: Colors.green.shade200,
                                // reverse: true,
                                //maskFilter: MaskFilter.blur(BlurStyle.normal, 5.0),
                                // curve: Curves.linear,
                                // restartAnimation: true,
                                // onAnimationEnd: (){print('progress...');},
                                // widgetIndicator: Text('V'),
                                // rotateLinearGradient: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 10),
                        child: Row(
                          children: [
                            Wrap(
                              spacing: 1,
                              direction: Axis.horizontal,
                              children: choiceChips(_tags2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          //if(tprog.length!=0)
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16.0,
                                right: visible ? 130 : 180,
                                left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "In Progress ",
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
                                      " 4 ",
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
                         // if(tprog.length!=0)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  taskProg(perc: 40, title: "Title 1", desc: "Description...", col: Color(0xFFEDEBDE)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  taskProg(perc: 60, title: "Title 2", desc: "Description...", col: Color(0xFFE0EBDD)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  taskProg(perc: 98, title: "Title 3", desc: "Description...", col: Color(0xFFEBE3FB)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  taskProg(perc: 20, title: "Title 4", desc: "Description...", col: Color(0xFFEDE0EA)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if(tgrp.length!=0)
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16.0,
                                right: visible ? 100 : 150,
                                left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Tasks Groups ",
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
                                      tgrp.length.toString(),
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
                          if(tgrp.length!=0)
                            for(int i=0;i<tgrp.length;i++)
                          taskGrp(
                            date: tgrp[i].createDate.split('/')[0],
                            mon: DateFormat('MMM').format(DateFormat('dd/MM/yyyy').parse(tgrp[i].createDate)),
                            taskName: tgrp[i].taskName,
                            noSubT: tgrp[i].subtask,
                            tag: tgrp[i].category,
                            desc: tgrp[i].taskDesc,
                            col: tgrp[i].precent==100? Colors.black.withOpacity(0.2):tgrp[0].priority=='High'? red
                                : tgrp[0].priority=='Medium'? orange
                                : yellow,
                            per: 0.3,
                            todotask: tgrp, index: i,
                          ),
                          // taskGrp(
                          //   date: '29',
                          //   mon: 'Sep',
                          //   taskName: 'Kerberos PPT',
                          //   noSubT: 2,
                          //   tag: 'College',
                          //   desc: 'Presentation...',
                          //   col: brown,
                          //   per: 0.01,
                          // ),
                          if(todotask.length!=0)
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16.0,
                                right: visible ? 100 : 150,
                                left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Tasks ",
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
                                      todotask.length.toString(),
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
                          for(int i=0;i<todotask.length;i++)
                            taskslist(context,i,todotask[i].taskName,todotask[i].taskDesc,todotask[i].createDate, todotask[i].precent, todotask[i].taskId, todotask[i].priority),

                          // taskslist(context),
                          // taskslist(context),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //       right: 20.0, left: 20, top: 10),
                          //   child: Container(
                          //       decoration: BoxDecoration(
                          //         color: checked[1]
                          //             ? Colors.black.withOpacity(0.1)
                          //             : orange,
                          //         borderRadius: BorderRadius.circular(10),
                          //         // border: Border(right: BorderSide(color: Colors.red, width: 1))
                          //       ),
                          //       child: Container(
                          //         margin: EdgeInsets.all(10),
                          //         child: Row(
                          //           children: [
                          //             Checkbox(
                          //               value: checked[1],
                          //               onChanged: (bool? value) {
                          //                 setState(() {
                          //                   checked[1] = value!;
                          //                 });
                          //               },
                          //               //splashRadius: 210.0,
                          //               activeColor: Colors
                          //                   .black, // Color when checkbox is checked
                          //               checkColor: Colors
                          //                   .white, // Color of the checkmark
                          //               materialTapTargetSize: MaterialTapTargetSize
                          //                   .shrinkWrap, // Remove extra padding
                          //               visualDensity: VisualDensity.compact,
                          //               side: BorderSide(
                          //                   color: Colors
                          //                       .black), // Reduce the checkbox size
                          //               shape: CircleBorder(),
                          //             ),
                          //             Padding(
                          //               padding: EdgeInsets.only(left: 8.0),
                          //               child: Column(
                          //                 crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //                 children: [
                          //                   Row(
                          //                     children: [
                          //                       Text(
                          //                         "taskName",
                          //                         style: TextStyle(
                          //                           color: Colors.black,
                          //                           fontSize: 18,
                          //                           decoration: checked[0]
                          //                               ? TextDecoration
                          //                               .lineThrough
                          //                               : TextDecoration.none,
                          //                         ),
                          //                       ),
                          //                       SizedBox(
                          //                         width: visible?80:120,
                          //                       ),
                          //                       Text(
                          //                         "26 Sept",
                          //                         style: TextStyle(
                          //                             color: Colors.black
                          //                                 .withOpacity(0.5),
                          //                             fontWeight:
                          //                             FontWeight.w300),
                          //                       )
                          //                     ],
                          //                   ),
                          //                   Text(
                          //                     "desc",
                          //                     style: TextStyle(
                          //                         color: Colors.black
                          //                             .withOpacity(0.6),
                          //                         fontWeight: FontWeight.w300),
                          //                   )
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       )),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //       right: 20.0, left: 20, top: 10),
                          //   child: Container(
                          //       decoration: BoxDecoration(
                          //         color: checked[2]
                          //             ? Colors.black.withOpacity(0.1)
                          //             : yellow,
                          //         borderRadius: BorderRadius.circular(10),
                          //         // border: Border(right: BorderSide(color: Colors.red, width: 1))
                          //       ),
                          //       child: Container(
                          //         margin: EdgeInsets.all(10),
                          //         child: Row(
                          //           children: [
                          //             Checkbox(
                          //               value: checked[2],
                          //               onChanged: (bool? value) {
                          //                 setState(() {
                          //                   checked[2] = value!;
                          //                 });
                          //               },
                          //               //splashRadius: 210.0,
                          //               activeColor: Colors
                          //                   .black, // Color when checkbox is checked
                          //               checkColor: Colors
                          //                   .white, // Color of the checkmark
                          //               materialTapTargetSize: MaterialTapTargetSize
                          //                   .shrinkWrap, // Remove extra padding
                          //               visualDensity: VisualDensity.compact,
                          //               side: BorderSide(
                          //                   color: Colors
                          //                       .black), // Reduce the checkbox size
                          //               shape: CircleBorder(),
                          //             ),
                          //             Padding(
                          //               padding: EdgeInsets.only(left: 8.0),
                          //               child: Column(
                          //                 crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //                 children: [
                          //                   Row(
                          //                     children: [
                          //                       Text(
                          //                         "taskName",
                          //                         style: TextStyle(
                          //                           color: Colors.black,
                          //                           fontSize: 18,
                          //                           decoration: checked[0]
                          //                               ? TextDecoration
                          //                               .lineThrough
                          //                               : TextDecoration.none,
                          //                         ),
                          //                       ),
                          //                       SizedBox(
                          //                         width: visible?80:120,
                          //                       ),
                          //                       Text(
                          //                         "26 Sept",
                          //                         style: TextStyle(
                          //                             color: Colors.black
                          //                                 .withOpacity(0.5),
                          //                             fontWeight:
                          //                             FontWeight.w300),
                          //                       )
                          //                     ],
                          //                   ),
                          //                   Text(
                          //                     "desc",
                          //                     style: TextStyle(
                          //                         color: Colors.black
                          //                             .withOpacity(0.6),
                          //                         fontWeight: FontWeight.w300),
                          //                   )
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       )),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      height: 130,
                    )
                  ],
                ),
              ),
            ),

            // Container(
            //   color: Colors.transparent,
            //   child: SizedBox(
            //     height: 80,
            //     // child: Container(
            //     //   color: Colors.transparent,
            //     // ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  GestureDetector taskslist(BuildContext context,int i, String taskName, String taskDesc, String duedate, double taskper, int taskid, String priority) {
    return GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => showTask(todotask: todotask[i],)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0, left: 20, top: 10),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: taskper==100? Colors.black.withOpacity(0.2):priority=='High'? red
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
                                        value: false,
                                        onChanged: (bool? value) {

                                            double per = value! ? 100.0 : 0.0;
                                            updatePercentage(taskid, per);
                                            print(per);


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
                                                  taskName.length<8?taskName:taskName.substring(0,6)+'...',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    decoration: taskper == 100
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none,
                                                  ),
                                                ),

                                                Text(
                                                  duedate,
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontWeight:
                                                          FontWeight.w300),
                                                )
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
                          ),
                        );
  }


  List<Widget> choiceChips(_choiceChipsList) {
    List<Widget> chips = [];
    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 2),
            child: ChoiceChip(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
              label: Row(
                children: [
                  Text(
                    _tags2.keys.elementAt(i), //_choiceChipsList[],
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 6.0, left: 10, top: 4),
                    child: Container(
                      height: 22,
                      width: 22,
                      child: Center(
                        child: Text(
                          _tags2.values.elementAt(i).toString(),
                          style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.black,
                              fontSize: 10),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: _selectedIndex == i
                              ? Colors.white
                              : Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30)),
                      // backgroundColor: _selectedIndex==i?
                      // Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.5) ,
                      // smallSize: 25,
                    ),
                  ),
                ],
              ),
              labelStyle: const TextStyle(color: Colors.white),
              backgroundColor: Colors.white70,
              selected: _selectedIndex == i,
              selectedColor: Colors.black,
              onSelected: (bool value) {
                setState(() {
                  _selectedIndex = i;
                });
              },
            ),
          ),
          if (_tags[_tags.keys.elementAt(_selectedIndex)]?.length != 0)
            Visibility(
              visible: _selectedIndex == i,
              child: Wrap(
                spacing: 1,
                direction: Axis.horizontal,
                children: child_choiceChips(_tags),
              ),
            ),
        ],
      );
      chips.add(item);
    }
    return chips;
  }

  List<Widget> child_choiceChips(_choiceChipsList) {
    List<Widget> chips = [];
    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 5, right: 2),
        child: ChoiceChip(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
          label: Row(
            children: [
              Text(
                _tags[_tags.keys.elementAt(_selectedIndex)]!
                    .elementAt(i), //_choiceChipsList[],
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0, left: 10, top: 4),
                child: Container(
                  height: 22,
                  width: 22,
                  child: Center(
                    child: Text(
                      '5',
                      style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize: 9),
                    ),
                  ),

                  decoration: BoxDecoration(
                    color: _selected == i
                        ? Colors.white
                        : Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  // backgroundColor: _selectedIndex==i?
                  // Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.5) ,
                  // smallSize: 25,
                ),
              ),
            ],
          ),
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.white70,
          selected: _selected == i,
          selectedColor: Colors.black,
          onSelected: (bool value) {
            setState(() {
              _selected = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}

class taskProg extends StatelessWidget {
  const taskProg({
    super.key,
    required this.perc,
    required this.title,
    required this.desc,
    required this.col,
  });

  final int perc;
  final String title;
  final String desc;
  final Color col;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => showTask()));
      },
      child: Container(
        width: 120,
        height: 140,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: CircularPercentIndicator(
                  radius: 25.0,
                  lineWidth: 3.0,
                  percent: (perc.toDouble()) / 100,
                  center: Text("$perc%", //"32%",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  progressColor: Colors.black,
                  backgroundWidth: 3,
                  backgroundColor: Colors
                      .black12, //Color(0xFFF9EB95),//Colors.yellow.shade200,
                  //fillColor: Colors.yellow.shade400,
                  animation: true,
                  // animationDuration: ,
                  // header: Padding(
                  //   padding: const EdgeInsets.all(12.0),
                  //   child: Text("${(_count.toDouble())}"),
                  // ),
                  // footer: Padding(
                  //   padding: const EdgeInsets.all(12.0),
                  //   child: Text("${(_count.toDouble())}"),
                  // ),
                  // linearGradient: LinearGradient(
                  //   colors: [Colors.white,Colors.black],
                  // ),
                  circularStrokeCap: CircularStrokeCap.round,
                  startAngle: 0.0,
                  // animateFromLastPercent: true,
                  //   addAutomaticKeepAlive: true,
                  // arcType: ArcType.HALF,
                  // arcBackgroundColor: Colors.green.shade200,
                  // reverse: true,
                  //maskFilter: MaskFilter.blur(BlurStyle.normal, 5.0),
                  // curve: Curves.linear,
                  // restartAnimation: true,
                  // onAnimationEnd: (){print('progress...');},
                  // widgetIndicator: Text('V'),
                  // rotateLinearGradient: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      title, //'Title',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        desc, //'description...',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w200,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: col, //Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
    );
  }
}

class taskGrp extends StatelessWidget {
  final String date;
  final String mon;
  final String taskName;
  final int noSubT;
  final String tag;
  final String desc;
  final Color col;
  final double per;
  final List<ToDoTask> todotask;
  final int index;
  const taskGrp(
      {super.key,
      required this.date,
      required this.mon,
      required this.taskName,
      required this.noSubT,
      required this.tag,
      required this.desc,
      required this.col,
      required this.per, required this.todotask, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: 10.0, left: visible ? 5 : 20, right: visible ? 10 : 20),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => showTask(todotask: todotask[index],)));
          },
          child: Container(
            width: visible ? 305 : 350,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        mon,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 0.7,
                  height: 95,
                  color: Colors.grey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 8, right: visible ? 70 : 10),
                      child: Container(
                        width: visible ? 185 : 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              taskName,
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Text(
                              "$noSubT Subtasks",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: visible ? 220 : 220.0, bottom: 5),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 3.0, bottom: 3.0, left: 4, right: 4),
                          child: Text(
                            tag,
                            style: TextStyle(color: Colors.black, fontSize: 8),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadiusDirectional.all(Radius.circular(20)),
                            border: Border.all(color: Colors.black, width: 1),
                            color: Colors.black.withOpacity(0.1)),
                      ),
                    ),
                    Container(
                        width: 250,
                        height: 50,
                        child: Text(
                          desc,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w300),
                        )),
                    Padding(
                      padding: EdgeInsets.only(right: visible ? 45.0 : 0),
                      child: LinearPercentIndicator(
                          width: visible ? 220 : 276,
                          animation: true,
                          animationDuration: 100,
                          lineHeight: 3.0,
                          percent: per,
                          //center: Text("20.0%"),
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: Colors.black,
                          backgroundColor: Colors.transparent //Colors.red,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: col,
                borderRadius: BorderRadiusDirectional.all(Radius.circular(10))),
          ),
        ));
  }
}


// Container(
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.all(Radius.circular(10)),
// ),
// child: ListView(
// padding: EdgeInsets.zero,
// shrinkWrap: true,
// scrollDirection: Axis.vertical,
// children: [
// Padding(
// padding:
// EdgeInsetsDirectional.fromSTEB(
// 5, 2, 5, 2),
// child: Theme(
// data: ThemeData(
// checkboxTheme:
// CheckboxThemeData(
// visualDensity:
// VisualDensity.compact,
// materialTapTargetSize:
// MaterialTapTargetSize
//     .shrinkWrap,
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.circular(
// 25),
// ),
// ),
// unselectedWidgetColor:
// Color(0xFF81EF39),
// ),
// child: ListTile(
// title: Text(
// 'Title',
//
// ),
// subtitle: Text(
// 'Subtitle goes here...',
//
// ),
// tileColor: Colors.pinkAccent,
// // activeColor: Color(0xFF81EF39),
// //checkColor:FlutterFlowTheme.of(context).info,
// dense: false,
// // controlAffinity:
// // ListTileControlAffinity
// //     .leading,
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.circular(10),
// ),
// ),
// ),
// ),
// Padding(
// padding:
// EdgeInsetsDirectional.fromSTEB(
// 5, 2, 5, 2),
// child: Theme(
// data: ThemeData(
// checkboxTheme:
// CheckboxThemeData(
// visualDensity:
// VisualDensity.compact,
// materialTapTargetSize:
// MaterialTapTargetSize
//     .shrinkWrap,
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.circular(
// 25),
// ),
// ),
// unselectedWidgetColor:
// Color(0xFF81EF39),
// ),
// child: ListTile(
// title: Text(
// 'Title',
//
// ),
// subtitle: Text(
// 'Subtitle goes here...',
//
// ),
// tileColor: Colors.pinkAccent,
// // activeColor: Color(0xFF81EF39),
// //checkColor:FlutterFlowTheme.of(context).info,
// dense: false,
// // controlAffinity:
// // ListTileControlAffinity
// //     .leading,
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.circular(10),
// ),
// ),
// ),
// ),
// Padding(
// padding:
// EdgeInsetsDirectional.fromSTEB(
// 5, 2, 5, 2),
// child: Theme(
// data: ThemeData(
// checkboxTheme:
// CheckboxThemeData(
// visualDensity:
// VisualDensity.compact,
// materialTapTargetSize:
// MaterialTapTargetSize
//     .shrinkWrap,
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.circular(
// 25),
// ),
// ),
// unselectedWidgetColor:
// Color(0xFF81EF39),
// ),
// child: ListTile(
// title: Text(
// 'Title',
//
// ),
// subtitle: Text(
// 'Subtitle goes here...',
//
// ),
// tileColor: Colors.pinkAccent,
// // activeColor: Color(0xFF81EF39),
// //checkColor:FlutterFlowTheme.of(context).info,
// dense: false,
// // controlAffinity:
// // ListTileControlAffinity
// //     .leading,
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.circular(10),
// ),
// ),
// ),
// ),
// ],
// ),
// ),
