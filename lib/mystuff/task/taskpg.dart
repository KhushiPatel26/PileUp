import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pup/mystuff/task/addtask.dart';
import 'package:pup/mystuff/mystuff.dart';

import '../../colors.dart';


class taskpg extends StatefulWidget {
  const taskpg({Key? key}) : super(key: key);

  @override
  State<taskpg> createState() => _taskpgState();
}


class _taskpgState extends State<taskpg> {
  int _selectedIndex=0;
  int _selected=0;
  Map<String,List<String>> _tags = {
    "All":[],
    "Personal":["1","2","3"],
    "Office":["a","b","c"]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(top:15.0,right: 20.0,left: 8.0,bottom: 8.0),
          child: CircleAvatar(
            child: Image.asset(
              'lib/assets/profile.png',
              height: 30,
              width: 30,
            ),
            backgroundColor: Colors.white,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 70.0),
                child: Text(
                  'Hello!',
                  style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.w200, fontSize: 15
                  ),
                ),
              ),
              Text(
                'Khushi Patel',
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0,top:5),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.query_stats,color: Colors.black,)),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16.0,right: visible?100:150, left: 20),
                  child: Text("My Tasks",style: TextStyle(fontSize: 30,color: Colors.black, fontWeight: FontWeight.bold),),
                ),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>addtask()));
                  }, icon:Icon(Icons.add, color: Colors.white,size: 15,),),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20,left: 20,top: 15),
                      child: Container(
                        width: 370,
                        height: 120,

                        decoration: BoxDecoration(
                            color: Color(0xFFDEECEC),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0,top:10,bottom: 12),
                                    child: Text("Your today's task\n"
                                        "almost done!",
                                      softWrap: true,
                                      style: TextStyle(color: Colors.black,
                                          fontFamily: 'Readex Pro',
                                          fontWeight: FontWeight.w300,
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 17
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => homepg()),
                                        // );
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
                                            borderRadius: BorderRadius.circular(30)),
                                        elevation: 4.0,
                                      )),
                                ]
                            ),
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
                                backgroundColor: Colors.black12,//Color(0xFFF9EB95),//Colors.yellow.shade200,
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
                        padding: const EdgeInsets.only(top:8.0,left:10),
                        child: Row(
                          children: [
                            Wrap(
                              spacing: 1,
                              direction: Axis.horizontal,
                              children: choiceChips(_tags),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 16.0,right: visible?130:180, left: 20),
                            child: Row(
                              children: [
                                Text("In Progress ",style: TextStyle(fontSize: 25,color: Colors.black),),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:1.0,bottom: 1.0,left:5,right: 5),
                                    child: Text(" 4 ",style: TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w500),),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.1),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:10.0,left:20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  taskProg(40,"Title 1","Description...",Color(0xFFEDEBDE)),
                                  SizedBox(width: 10,),
                                  taskProg(60,"Title 2","Description...",Color(0xFFE0EBDD)),
                                  SizedBox(width: 10,),
                                  taskProg(98,"Title 3","Description...",Color(0xFFEBE3FB)),
                                  SizedBox(width: 10,),
                                  taskProg(20,"Title 4","Description...",Color(0xFFEDE0EA)),
                                  SizedBox(width: 10,),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16.0,right: visible?100:150, left: 20),
                            child: Row(
                              children: [
                                Text("Tasks Groups ",style: TextStyle(fontSize: 25,color: Colors.black),),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:1.0,bottom: 1.0,left:5,right: 5),
                                    child: Text(" 2 ",style: TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w500),),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.1),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                )
                              ],
                            ),
                          ),
                          taskGrp(date: '26', mon: 'Sep', taskName: 'PileUp App', noSubT: 5, tag: 'College', desc: 'App Development...', col: pink, per: 0.2,),
                          taskGrp(date: '29', mon: 'Sep', taskName: 'Kerberos PPT', noSubT: 2, tag: 'College', desc: 'Presentation...', col: brown, per: 0.01,),

                        ],
                      ),
                    ),
                    Container(
                      height: 90,
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

  Container taskProg(int perc,String title, String desc, Color col) {
    return Container(
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
                              center: Text("$perc%",//"32%",
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              progressColor: Colors.black,
                              backgroundWidth: 3,
                              backgroundColor: Colors.black12,//Color(0xFFF9EB95),//Colors.yellow.shade200,
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
                          padding: const EdgeInsets.only(top:8.0,left:15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  title,//'Title',
                                  style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    desc,//'description...',
                                    style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.w200, fontSize: 15
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: col,//Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(15))
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
                  Text(_tags.keys.elementAt(i),//_choiceChipsList[],
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0,left: 10, top:4),
                    child: Container(
                      height: 22,
                      width: 22,
                      child: Center(
                        child: Text(
                          '5',
                          style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.black, fontSize: 10),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: _selectedIndex==i?
                          Colors.white : Colors.black.withOpacity(0.5) ,
                          borderRadius: BorderRadius.circular(30)
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
              selected: _selectedIndex == i,
              selectedColor: Colors.black,
              onSelected: (bool value) {
                setState(() {
                  _selectedIndex = i;
                });
              },
            ),
          ),
          if(_tags[_tags.keys.elementAt(_selectedIndex)]?.length!=0)
          Visibility(
            visible: _selectedIndex==i,
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
              Text(_tags[_tags.keys.elementAt(_selectedIndex)]!.elementAt(i),//_choiceChipsList[],
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0,left: 10, top:4),
                child: Container(
                  height: 22,
                  width: 22,
                  child: Center(
                    child: Text(
                      '5',
                      style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Colors.black,
                          fontSize:9),
                    ),
                  ),

                  decoration: BoxDecoration(
                      color: _selected==i?
                      Colors.white : Colors.black.withOpacity(0.5) ,
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

class taskGrp extends StatelessWidget {
  final String date;
  final String mon;
  final String taskName;
  final int noSubT;
  final String tag;
  final String desc;
  final Color col;
  final double per;

  const taskGrp({
    super.key,
    required this.date, required this.mon, required this.taskName, required this.noSubT, required this.tag, required this.desc, required this.col, required this.per
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top:10.0,left:20,right: 20),
        child: Container(
          //width: 350,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(date,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),),
                    Text(mon,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),),
                  ],
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
                // indent: 20,
                // endIndent: 0,
                color: Colors.black,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:8,bottom:8,right: visible?70:10),
                    child: Container(
                      width: visible?190:260,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(taskName,style: TextStyle(color: Colors.black,fontSize: 18),),
                          Text("$noSubT Subtasks",style: TextStyle(color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w300),)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: visible?220:220.0,bottom: 5),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top:3.0,bottom:3.0,left: 4,right: 4),
                        child: Text(tag,style: TextStyle(color: Colors.black,fontSize: 8),),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
                          border: Border.all(color: Colors.black,width: 1),
                          color: Colors.black.withOpacity(0.1)
                      ),
                    ),
                  ),
                  Container(
                      width: 250,
                      height: 50,
                      child: Text(desc,style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.w300),)
                  ),
                  Padding(
                    padding: EdgeInsets.only(right:visible?45.0:0),
                    child: LinearPercentIndicator(
                      width: visible?220:276,
                      animation: true,
                      animationDuration: 100,
                      lineHeight: 3.0,
                      percent: per,
                      //center: Text("20.0%"),
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: Colors.black,
                      backgroundColor: Colors.transparent//Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: col,
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
          ),
        )
    );
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