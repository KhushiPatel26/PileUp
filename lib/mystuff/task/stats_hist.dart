import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pup/DB/fetch.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pup/home/homeall.dart';
import 'package:pup/homepg.dart';
import 'package:pup/mystuff/task/showTask.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../DB/ApiService3.dart';
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
  List<ToDoTask> tasks = [];
  List<Subtask> stasks = [];
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
int work=0;
  int life=0;
  int other=0;
  int twork=0;
  int tlife=0;
  int tother=0;
  int s_c_w=0;
  int s_w=0;
  int s_c_p=0;
  int s_p=0;
  int s_c_o=0;
  int s_o=0;
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
  ApiService3 api = ApiService3();
  Future<void> _fetchData() async {
    final data = await api.readRecords('ToDoTasks');
    final data2 = await api.readRecords('Subtasks');
    setState(() {
      tasks = data.map((json) => ToDoTask.fromJson(json)).where((element) => element.usId==uid).toList();
      for(int i=0;i<tasks.length;i++)
        {
          s_c_w = data2.map((json) => Subtask.fromJson(json)).where((element) => element.taskId==tasks[i].taskId && tasks[i].category=='Work' &&element.isCompleted=='true').toList().length;
          s_w = data2.map((json) => Subtask.fromJson(json)).where((element) => element.taskId==tasks[i].taskId && tasks[i].category=='Work').toList().length;
          s_c_p = data2.map((json) => Subtask.fromJson(json)).where((element) => element.taskId==tasks[i].taskId && tasks[i].category=='Personal' &&element.isCompleted=='true').toList().length;
          s_p = data2.map((json) => Subtask.fromJson(json)).where((element) => element.taskId==tasks[i].taskId && tasks[i].category=='Personal').toList().length;
          s_c_o = data2.map((json) => Subtask.fromJson(json)).where((element) => element.taskId==tasks[i].taskId && tasks[i].category=='Other' &&element.isCompleted=='true').toList().length;
          s_o = data2.map((json) => Subtask.fromJson(json)).where((element) => element.taskId==tasks[i].taskId && tasks[i].category=='Other' ).toList().length;
        }

    });
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

        work=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.precent==100.0 && task.category=='Work') // Filter out null users
            .toList().length;
        print('Work: $work');

        life=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.precent==100.0 && task.category=='Personal') // Filter out null users
            .toList().length;
        print('Life: $life');

        other=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.precent==100.0 && task.category=='None') // Filter out null users
            .toList().length;
        print('Other: $other');

        twork=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.category=='Work') // Filter out null users
            .toList().length;
        print('Work: $work');

        tlife=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.category=='Personal') // Filter out null users
            .toList().length;
        print('Life: $life');

        tother=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((task) => task.usId == uid && task.category=='None') // Filter out null users
            .toList().length;
        print('Other: $other');

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
                builder: (context) => homepg(gotoIndex: 1,)));
          },
          icon:  Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        title: Text('Your Stats',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body:  todotask.length==0? Center(child:Text('Completed Tasks are visible here', style: TextStyle(color: Colors.black),)) :
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:8.0),
              child: Text("Work life Balance Graph",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 20),),
            ),
            Center(
                child: SfCircularChart(
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                      dataSource: _getData(),
                      xValueMapper: (ChartData data, _) => data.category,
                      yValueMapper: (ChartData data, _) => data.value,
                      dataLabelMapper: (ChartData data, _) => '${data.value}%',
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        // Positioning of the data label
                        labelPosition: ChartDataLabelPosition.inside,
                        //color: Colors.black,
                      ),
                      pointColorMapper: (ChartData data, _) {
                        return data.category == 'Work'
                            ? Colors.redAccent.withOpacity(0.4) // Work segment color
                            : data.category == 'Life' ? Colors.deepOrangeAccent.withOpacity(0.2): Colors.orangeAccent; // Life segment color
                      },
                    )
                  ],
                ),
            ),
            Padding(
              padding: EdgeInsets.only(left:80.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.square,color: Colors.redAccent ,), Text("Work",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300)), SizedBox(width: 15,),
                  Icon(Icons.square,color: Colors.deepOrangeAccent ,), Text("Life",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300)),SizedBox(width: 15,),
                  Icon(Icons.square,color: Colors.orangeAccent ,), Text("Other",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300)),SizedBox(width: 15,),
                ],
              ),
            ),
            // Center(
            //     child: CustomPaint(
            //       size: Size(300, 300),
            //       painter: ChartPainter(),
            //     ),
            //     ),
            // Center(
            //   child: SfCircularChart(
            //     series: <DoughnutSeries<ChartData2, String>>[
            //       DoughnutSeries<ChartData2, String>(
            //         dataSource: _getData2(),
            //         xValueMapper: (ChartData2 data, _) => data.category,
            //         yValueMapper: (ChartData2 data, _) => data.value,
            //         dataLabelSettings: DataLabelSettings(isVisible: true),
            //       )
            //     ],
            //   ),
            // ),
            // Center(
            //   child: SfCircularChart(
            //     series: <RadialBarSeries<ChartData2, String>>[
            //       RadialBarSeries<ChartData2, String>(
            //         dataSource: _getData2(),
            //         xValueMapper: (ChartData2 data, _) => data.category,
            //         yValueMapper: (ChartData2 data, _) => data.value,
            //         dataLabelSettings: DataLabelSettings(isVisible: true),
            //         maximumValue: 100, // Set the maximum value for the radial bar
            //       )
            //     ],
            //   ),
            // ),
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
              taskslist(context,i,todotask[i].taskName,todotask[i].taskDesc,todotask[i].createDate, todotask[i].precent, todotask[i].taskId!, todotask[i].priority),
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
  // List<ChartData2> _getData2() {
  //   return <ChartData2>[
  //     ChartData2('Work', 70),
  //     ChartData2('Life', 30),
  //   ];
  // }
  List<ChartData> _getData() {
    final List<ChartData> chartData = [
      ChartData('Work', double.parse((work+s_c_w).toString())),
      ChartData('Life', double.parse((life+s_c_p).toString())),
      ChartData('Other', double.parse((other+s_c_o).toString())),
    ];
    return chartData;
  }
  List<ChartData2> _getData2() {
    return <ChartData2>[
      ChartData2('Work', (work/twork)),
      ChartData2('Life', 50),
      ChartData2('Other', 75),
    ];
  }
}

class ChartData2 {
  ChartData2(this.category, this.value);

  final String category;
  final double value;
}

class ChartData {
  ChartData(this.category, this.value);

  final String category;
  final double value;
}

// class ChartPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     double radius = size.width / 3;
//     Paint paint = Paint()
//       ..color = Colors.blue // Work segment color
//       ..style = PaintingStyle.fill;
//
//     canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
//
//     paint.color = Colors.green; // Life segment color
//     double startAngle = -0.5 * 3.14;
//     double sweepAngle = 0.7 * 3.14;
//     Rect rect = Rect.fromLTRB(
//         size.width / 2 - radius,
//         size.height / 2 - radius,
//         size.width / 2 + radius,
//         size.height / 2 + radius);
//     canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
//
//     // Draw labels
//     TextPainter textPainter = TextPainter(
//       text: TextSpan(
//         text: 'Work',
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 16.0,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout();
//     textPainter.paint(canvas, Offset(size.width / 2 - 30, size.height / 2 + 30));
//
//     textPainter = TextPainter(
//       text: TextSpan(
//         text: 'Life',
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 16.0,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout();
//     textPainter.paint(canvas, Offset(size.width / 2 - 20, size.height / 2 - 50));
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }