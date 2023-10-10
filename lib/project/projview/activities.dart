import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:toggle_switch/toggle_switch.dart';

class activities extends StatefulWidget {
  final int projId;
  const activities({Key? key, required this.projId}) : super(key: key);

  @override
  State<activities> createState() => _activitiesState();
}

class _activitiesState extends State<activities> {

  String tb="All";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:15.0,bottom: 10),
            child: Container(child: ToggleSwitch(
              minWidth: 70.0,
              minHeight: 30.0,
              fontSize: 12.0,
              initialLabelIndex: 0,
              activeBgColor: [Colors.black],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.black26,
              inactiveFgColor: Colors.grey[900],
              totalSwitches: 2,
              animate: true,
              changeOnTap: true,
              animationDuration: 250,
              labels: ['All', 'My'],
              onToggle: (index) {
                tb= index==0?'All':'My';
                print('switched to: $tb');
              },
            ),),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 10.0,),
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 370,
              height: 120,
              decoration: BoxDecoration(
                  color: Color(0xFFEDE0EA),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0,left: 20,bottom: 10),
                          child: Text('AI Assignment',
                            style: TextStyle(color: Colors.black,
                                fontFamily: 'Readex Pro',
                                fontWeight: FontWeight.w300,
                                //fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 32,
                            height: 18,
                            child: Text("2d",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w100),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 18.0),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Container(
                                      width: 27,
                                      height: 30,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,

                                      ),
                                      child: Image.network(
                                        'https://source.unsplash.com/random/sig=1',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://source.unsplash.com/random/sig=2',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        40, 0, 0, 0),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://source.unsplash.com/random/sig=4',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        70, 0, 0, 0),
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
                                      smallSize: 30,
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
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,top:20),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.access_time,color: Colors.black54,size: 18,),
                                  Text(' 11:59 PM',style: TextStyle(color: Colors.black54,fontSize: 14),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 28.0),
                          child: CircularPercentIndicator(
                            radius: 28.0,
                            lineWidth: 5.0,
                            percent: (32.toDouble()) / 100,
                            center: Text("32%",
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
                      ],
                    )
                  ]
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,),
            child: Row(
              children: [
                Text(
                  "Review ",
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
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: 10.0,),
          //   child: Row(
          //     children: [
          //       Text(
          //         "Pending ",
          //         style: TextStyle(
          //             fontSize: 25, color: Colors.black),
          //       ),
          //       Container(
          //         child: Padding(
          //           padding: const EdgeInsets.only(
          //               top: 1.0,
          //               bottom: 1.0,
          //               left: 5,
          //               right: 5),
          //           child: Text(
          //             " 4 ",
          //             style: TextStyle(
          //                 fontSize: 13,
          //                 color: Colors.black,
          //                 fontWeight: FontWeight.w500),
          //           ),
          //         ),
          //         decoration: BoxDecoration(
          //             color: Colors.black.withOpacity(0.1),
          //             borderRadius: BorderRadius.all(
          //                 Radius.circular(10))),
          //       )
          //     ],
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,),
            child: Row(
              children: [
                Text(
                  "Completed ",
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
          Container(
            height: 900,
            color: Colors.white,
          )
        ],
    );
  }
}
