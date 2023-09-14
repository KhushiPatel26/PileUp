//import 'package:badges/badges.dart';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pup/project/projdet.dart';

class projhome extends StatefulWidget {
  const projhome({Key? key}) : super(key: key);

  @override
  State<projhome> createState() => _projhomeState();
}

class _projhomeState extends State<projhome> {
  int _selectedIndex=0;
  List<String> _status = [
    "To Do",
    "In Progress",
    "Review",
    "Pending",
    "Completed"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 35,
                    left: 15), //EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      // TextSpan(
                      //   text: 'Hi, ',
                      //   style: TextStyle(
                      //     fontFamily: 'Readex Pro',
                      //     //color: Colors.black54,//FlutterFlowTheme.of(context).primaryText,
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.w300,
                      //     color: Colors.black
                      //   ),
                      // ),
                      // TextSpan(
                      //   text: 'Nici\n',
                      //   style: TextStyle(
                      //     color: Colors.black12, //FlutterFlowTheme.of(context).primary,
                      //     fontWeight: FontWeight.w600,
                      //     fontSize: 18,
                      //   ),
                      // ),
                      TextSpan(
                        text: 'You Have\n',
                        style: TextStyle(fontSize: 21, color: Colors.black),
                      ),
                      TextSpan(
                        text: '4 Projects',
                        style: TextStyle(
                            fontSize: 25,
                            decoration: TextDecoration.underline,
                            color: Colors.black),
                      )
                    ],
                    style: TextStyle(
                      fontFamily: 'Readex Pro',

                      //lineHeight: 1.3,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.only(top: 15, left: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        projProgress(projTitle: "Project 1",category: "Web",contcolor: Color(0xFFEDE0EA), priority: "High", perc: 0.6),
                        SizedBox(
                          width: 12,
                        ),
                        projProgress(projTitle: "Project 2",category: "App",contcolor: Color(0xFFEBE3FB), priority: "Medium", perc: 0.4),
                        // Container(
                        //   width: 260,
                        //   height: 195,
                        //   decoration: BoxDecoration(
                        //     color: Color(0xFFEBE3FB),
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   child: Column(
                        //     mainAxisSize: MainAxisSize.max,
                        //     children: [
                        //       Align(
                        //         alignment: AlignmentDirectional(-1, -1),
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.fromSTEB(
                        //               15, 12, 0, 0),
                        //           child: Text(
                        //             'Priority',
                        //             style: TextStyle(
                        //                 fontFamily: 'Readex Pro',
                        //                 fontWeight: FontWeight.w100,
                        //                 color: Colors.black),
                        //           ),
                        //         ),
                        //       ),
                        //       Align(
                        //         alignment: AlignmentDirectional(-1, -1),
                        //         child: Padding(
                        //           padding:
                        //               EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                        //           child: Text(
                        //             'Project Title',
                        //             style: TextStyle(
                        //                 fontFamily: 'Readex Pro',
                        //                 fontSize: 25,
                        //                 color: Colors.black),
                        //           ),
                        //         ),
                        //       ),
                        //       Align(
                        //         alignment: AlignmentDirectional(-1, -1),
                        //         child: Padding(
                        //           padding:
                        //               EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                        //           child: Text(
                        //             'Category',
                        //             style: TextStyle(
                        //                 fontFamily: 'Readex Pro',
                        //                 fontSize: 20,
                        //                 color: Colors.black),
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                        //         child: Row(
                        //           mainAxisSize: MainAxisSize.max,
                        //           children: [
                        //             Stack(
                        //               children: [
                        //                 Align(
                        //                   alignment: AlignmentDirectional(-1, 0),
                        //                   child: Container(
                        //                     width: 35,
                        //                     height: 35,
                        //                     clipBehavior: Clip.antiAlias,
                        //                     decoration: BoxDecoration(
                        //                       shape: BoxShape.circle,
                        //                     ),
                        //                     child: Image.network(
                        //                       'https://picsum.photos/seed/260/600',
                        //                       fit: BoxFit.cover,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Padding(
                        //                   padding: EdgeInsetsDirectional.fromSTEB(
                        //                       20, 0, 0, 0),
                        //                   child: Container(
                        //                     width: 35,
                        //                     height: 35,
                        //                     clipBehavior: Clip.antiAlias,
                        //                     decoration: BoxDecoration(
                        //                       shape: BoxShape.circle,
                        //                     ),
                        //                     child: Image.network(
                        //                       'https://picsum.photos/seed/260/600',
                        //                       fit: BoxFit.cover,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Padding(
                        //                   padding: EdgeInsetsDirectional.fromSTEB(
                        //                       40, 0, 0, 0),
                        //                   child: Container(
                        //                     width: 35,
                        //                     height: 35,
                        //                     clipBehavior: Clip.antiAlias,
                        //                     decoration: BoxDecoration(
                        //                       shape: BoxShape.circle,
                        //                     ),
                        //                     child: Image.network(
                        //                       'https://picsum.photos/seed/260/600',
                        //                       fit: BoxFit.cover,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Padding(
                        //                   padding: EdgeInsetsDirectional.fromSTEB(
                        //                       75, 0, 0, 0),
                        //                   child: //badges.
                        //                       Badge(
                        //                     child: Padding(
                        //                       padding: const EdgeInsets.only(
                        //                           top: 8.0, right: 8),
                        //                       child: Text(
                        //                         '+5',
                        //                         style: TextStyle(
                        //                             fontFamily: 'Readex Pro',
                        //                             color: Colors.black),
                        //                       ),
                        //                     ),
                        //                     backgroundColor:
                        //                         Colors.black.withOpacity(0.5),
                        //                     //largeSize: 5,
                        //                     smallSize: 35,
                        //                     // showBadge: true,
                        //                     // shape: BadgeShape.circle,
                        //                     // badgeColor: Colors.white70,
                        //                     // elevation: 4,
                        //                     // padding: EdgeInsetsDirectional.fromSTEB(
                        //                     //     8, 8, 8, 8),
                        //                     // position: BadgePosition.topEnd(),
                        //                     // animationType: BadgeAnimationType.scale,
                        //                     // toAnimate: true,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             EdgeInsetsDirectional.fromSTEB(15, 7, 0, 0),
                        //         child: Row(
                        //           mainAxisSize: MainAxisSize.max,
                        //           children: [
                        //             LinearPercentIndicator(
                        //               percent: 0.6,
                        //               width: 150,
                        //               lineHeight: 5,
                        //               animation: true,
                        //               progressColor: Colors.black,
                        //               //FlutterFlowTheme.of(context).primary,
                        //               backgroundColor: Colors.black12,
                        //               //FlutterFlowTheme.of(context).alternate,
                        //               padding: EdgeInsets.zero,
                        //             ),
                        //             Padding(
                        //               padding: EdgeInsetsDirectional.fromSTEB(
                        //                   5, 0, 0, 0),
                        //               child: Text(
                        //                 '60%',
                        //                 style: TextStyle(color: Colors.black),
                        //                 //style: //FlutterFlowTheme.of(context)
                        //                 //.bodyMedium,
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: EdgeInsetsDirectional.fromSTEB(
                        //                   15, 0, 0, 0),
                        //               child: IconButton(
                        //                 icon: Icon(Icons.open_in_new,
                        //                     // color: FlutterFlowTheme.of(context)
                        //                     //     .primaryText,
                        //                     size: 15,
                        //                     color: Colors.black),
                        //                 onPressed: () async {
                        //                   //context.pushNamed('prog_mang1');
                        //                 },
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          width: 12,
                        ),
                        projProgress(projTitle: "Project 3",category: "Other",contcolor: Color(0xFFDEECEC), priority: "Low", perc: 0.1),
                        // Container(
                        //   width: 260,
                        //   height: 195,
                        //   decoration: BoxDecoration(
                        //     color: Color(0xFFDEECEC),
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   child: Column(
                        //     mainAxisSize: MainAxisSize.max,
                        //     children: [
                        //       Align(
                        //         alignment: AlignmentDirectional(-1, -1),
                        //         child: Padding(
                        //           padding: EdgeInsetsDirectional.fromSTEB(
                        //               15, 12, 0, 0),
                        //           child: Text(
                        //             'Priority',
                        //             style: TextStyle(
                        //                 fontFamily: 'Readex Pro',
                        //                 fontWeight: FontWeight.w100,
                        //                 color: Colors.black),
                        //           ),
                        //         ),
                        //       ),
                        //       Align(
                        //         alignment: AlignmentDirectional(-1, -1),
                        //         child: Padding(
                        //           padding:
                        //               EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                        //           child: Text(
                        //             'Project Title',
                        //             style: TextStyle(
                        //                 fontFamily: 'Readex Pro',
                        //                 fontSize: 25,
                        //                 color: Colors.black),
                        //           ),
                        //         ),
                        //       ),
                        //       Align(
                        //         alignment: AlignmentDirectional(-1, -1),
                        //         child: Padding(
                        //           padding:
                        //               EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                        //           child: Text(
                        //             'Category',
                        //             style: TextStyle(
                        //                 fontFamily: 'Readex Pro',
                        //                 fontSize: 20,
                        //                 color: Colors.black),
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
                        //         child: Row(
                        //           mainAxisSize: MainAxisSize.max,
                        //           children: [
                        //             Stack(
                        //               children: [
                        //                 Align(
                        //                   alignment: AlignmentDirectional(-1, 0),
                        //                   child: Container(
                        //                     width: 35,
                        //                     height: 35,
                        //                     clipBehavior: Clip.antiAlias,
                        //                     decoration: BoxDecoration(
                        //                       shape: BoxShape.circle,
                        //                     ),
                        //                     child: Image.network(
                        //                       'https://picsum.photos/seed/260/600',
                        //                       fit: BoxFit.cover,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Padding(
                        //                   padding: EdgeInsetsDirectional.fromSTEB(
                        //                       20, 0, 0, 0),
                        //                   child: Container(
                        //                     width: 35,
                        //                     height: 35,
                        //                     clipBehavior: Clip.antiAlias,
                        //                     decoration: BoxDecoration(
                        //                       shape: BoxShape.circle,
                        //                     ),
                        //                     child: Image.network(
                        //                       'https://picsum.photos/seed/260/600',
                        //                       fit: BoxFit.cover,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Padding(
                        //                   padding: EdgeInsetsDirectional.fromSTEB(
                        //                       40, 0, 0, 0),
                        //                   child: Container(
                        //                     width: 35,
                        //                     height: 35,
                        //                     clipBehavior: Clip.antiAlias,
                        //                     decoration: BoxDecoration(
                        //                       shape: BoxShape.circle,
                        //                     ),
                        //                     child: Image.network(
                        //                       'https://picsum.photos/seed/260/600',
                        //                       fit: BoxFit.cover,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Padding(
                        //                   padding: EdgeInsetsDirectional.fromSTEB(
                        //                       75, 0, 0, 0),
                        //                   child: //badges.
                        //                       Badge(
                        //                     child: Padding(
                        //                       padding: const EdgeInsets.only(
                        //                           top: 8.0, right: 8),
                        //                       child: Text(
                        //                         '+5',
                        //                         style: TextStyle(
                        //                             fontFamily: 'Readex Pro',
                        //                             color: Colors.black),
                        //                       ),
                        //                     ),
                        //                     backgroundColor:
                        //                         Colors.black.withOpacity(0.5),
                        //                     //largeSize: 5,
                        //                     smallSize: 35,
                        //                     // showBadge: true,
                        //                     // shape: BadgeShape.circle,
                        //                     // badgeColor: Colors.white70,
                        //                     // elevation: 4,
                        //                     // padding: EdgeInsetsDirectional.fromSTEB(
                        //                     //     8, 8, 8, 8),
                        //                     // position: BadgePosition.topEnd(),
                        //                     // animationType: BadgeAnimationType.scale,
                        //                     // toAnimate: true,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             EdgeInsetsDirectional.fromSTEB(15, 7, 0, 0),
                        //         child: Row(
                        //           mainAxisSize: MainAxisSize.max,
                        //           children: [
                        //             LinearPercentIndicator(
                        //               percent: 0.6,
                        //               width: 150,
                        //               lineHeight: 5,
                        //               animation: true,
                        //               progressColor: Colors.black,
                        //               //FlutterFlowTheme.of(context).primary,
                        //               backgroundColor: Colors.black12,
                        //               //FlutterFlowTheme.of(context).alternate,
                        //               padding: EdgeInsets.zero,
                        //             ),
                        //             Padding(
                        //               padding: EdgeInsetsDirectional.fromSTEB(
                        //                   5, 0, 0, 0),
                        //               child: Text(
                        //                 '60%',
                        //                 style: TextStyle(color: Colors.black),
                        //                 //style: //FlutterFlowTheme.of(context)
                        //                 //.bodyMedium,
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: EdgeInsetsDirectional.fromSTEB(
                        //                   15, 0, 0, 0),
                        //               child: IconButton(
                        //                 icon: Icon(Icons.open_in_new,
                        //                     // color: FlutterFlowTheme.of(context)
                        //                     //     .primaryText,
                        //                     size: 15,
                        //                     color: Colors.black),
                        //                 onPressed: () async {
                        //                   //context.pushNamed('prog_mang1');
                        //                 },
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ]),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0, top: 15, bottom: 15),
                child: Text("Your Progress",
                style: TextStyle(color: Colors.black,
                fontSize: 20,
                ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text('Priority Task',
                              style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.bold
                              ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(onPressed: (){}, icon: Icon(Icons.check_circle),color: Colors.black45,iconSize: 18),
                              Text('Design HomePg',
                                style: TextStyle(color: Colors.black45,
                                    fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_outline_sharp),color: Colors.black,iconSize: 18),
                              Text('Design Logo',
                                style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w300
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(onPressed: (){}, icon: Icon(Icons.check_circle_outline_sharp),color: Colors.black,iconSize: 18),
                              Text('Splashscreen',
                                style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w300
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color:Color(0xFFEDEBDE),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Container(
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color:Color(0xFFE0EBDD),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularPercentIndicator(
                                radius: 22.0,
                                lineWidth: 3.0,
                                percent: ((100-(64-56)).toDouble()) / 100,
                                center: Text((100-(64-56)).toString()+"%",
                                    style: TextStyle(
                                      color: Colors.black,

                                    )),
                                progressColor: Colors.black,
                                backgroundWidth: 4,
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
                            Column(
                              children: [
                                Text("Completed",
                                style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.w300,
                                ),),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text:"56/64 ",
                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)
                                      ),
                                      TextSpan(text:" Task",
                                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)
                                      ),
                                    ]
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          Container(
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color:Color(0xFFEDE3DE),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.data_exploration_sharp,color: Colors.black,size: 35,)
                                ),
                                Column(
                                  children: [
                                    Text("In Progress",
                                      style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),),
                                    RichText(
                                      text: TextSpan(
                                          children: [
                                            TextSpan(text:"6 ",
                                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)
                                            ),
                                            TextSpan(text:" Task",
                                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)
                                            ),
                                          ]
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container()
                        ],
                      )
                    ],
                  ),
                ],
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
                      children: choiceChips(_status),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ));
  }
  List<Widget> choiceChips(_choiceChipsList) {
    List<Widget> chips = [];
    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 5, right: 2),
        child: ChoiceChip(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          label: Row(
            children: [
              Text(_choiceChipsList[i],
              style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0,left: 10, top:4),
                child: Container(
                  height: 25,
                  width: 25,
                  child: Center(
                    child: Text(
                      '+5',
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
      );
      chips.add(item);
    }
    return chips;
  }
}

class projProgress extends StatelessWidget {
  Color contcolor;
  String priority;
  String projTitle;
  String category;
  double perc;

  projProgress({
    Key? key,
    required this.contcolor,
    required this.priority,
    required this.projTitle,
    required this.category,
    required this.perc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 195,
      decoration: BoxDecoration(
        color: contcolor,//Color(0xFFEDE0EA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: AlignmentDirectional(-1, -1),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  15, 12, 0, 0),
              child: Text(
                priority,//'Priority',
                style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontWeight: FontWeight.w100,
                    color: Colors.black),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-1, -1),
            child: Padding(
              padding:
                  EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
              child: Text(
                projTitle,//'Project Title',
                style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 25,
                    color: Colors.black),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-1, -1),
            child: Padding(
              padding:
                  EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
              child: Text(
                category,//'Category',
                style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Container(
                        width: 35,
                        height: 35,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://picsum.photos/seed/260/600',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20, 0, 0, 0),
                      child: Container(
                        width: 35,
                        height: 35,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://picsum.photos/seed/260/600',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          40, 0, 0, 0),
                      child: Container(
                        width: 35,
                        height: 35,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://picsum.photos/seed/260/600',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          75, 0, 0, 0),
                      child: //badges.
                          Badge(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, right: 8),
                          child: Text(
                            '+5',
                            style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Colors.black),
                          ),
                        ),
                        backgroundColor:
                            Colors.black.withOpacity(0.5),
                        //largeSize: 5,
                        smallSize: 35,
                        // showBadge: true,
                        // shape: BadgeShape.circle,
                        // badgeColor: Colors.white70,
                        // elevation: 4,
                        // padding: EdgeInsetsDirectional.fromSTEB(
                        //     8, 8, 8, 8),
                        // position: BadgePosition.topEnd(),
                        // animationType: BadgeAnimationType.scale,
                        // toAnimate: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsetsDirectional.fromSTEB(15, 7, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                LinearPercentIndicator(
                  percent: perc,//0.6,
                  width: 150,
                  lineHeight: 5,
                  animation: true,
                  progressColor: Colors.black,
                  //FlutterFlowTheme.of(context).primary,
                  backgroundColor: Colors.black12,
                  //FlutterFlowTheme.of(context).alternate,
                  padding: EdgeInsets.zero,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      5, 0, 0, 0),
                  child: Text(
                    (perc*100).toString(),
                    style: TextStyle(color: Colors.black),
                    //style: //FlutterFlowTheme.of(context)
                    //.bodyMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      10, 0, 0, 0),
                  child: IconButton(
                    icon: Icon(Icons.open_in_new,
                        // color: FlutterFlowTheme.of(context)
                        //     .primaryText,
                        size: 15,
                        color: Colors.black),
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>projdet()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
