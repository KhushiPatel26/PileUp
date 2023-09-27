import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pup/DB/fetch.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pup/home/homeall.dart';
import 'package:pup/homepg.dart';
import 'package:pup/mystuff/task/showTask.dart';

import '../../DB/ip.dart';
import '../../DB/models.dart';
import '../../colors.dart';

class stats_hist extends StatefulWidget {
  const stats_hist({Key? key}) : super(key: key);

  @override
  State<stats_hist> createState() => _stats_histState();
}

class _stats_histState extends State<stats_hist> {

  late User? user;
  late String? uid;
  List<ToDoTask> todotask = [];
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = _auth.currentUser;
    uid=user!.uid;
    print("uid:"+uid!);
    fetchTaskData();
    // fetchPostsById(uid);
  }

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

  Future<void> fetchTaskData() async {
    final response = await http.get(Uri.parse('http://$ip:3000/Tasks'));
    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        todotask=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.precent==100.0) // Filter out null users
            .toList();
        print(todotask);
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => homepg()));
          },
          icon:  Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: Text('Your Stats',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:  todotask.length==0? Center(child:Text('Completed Tasks are visible here', style: TextStyle(color: Colors.black),)) :
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 16.0,
                right: 100,
                left: 20),
            child: Row(
              children: [
                Text(
                  "Completed Tasks ",
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
        ],
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
                    value: true,
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

}
