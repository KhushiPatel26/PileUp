import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class activities extends StatefulWidget {
  const activities({Key? key}) : super(key: key);

  @override
  State<activities> createState() => _activitiesState();
}

class _activitiesState extends State<activities> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                  color: Color(0xFFE0EBDD),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 22.0,
                            lineWidth: 3.0,
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
            padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                  color: Color(0xFFE0EBDD),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 22.0,
                            lineWidth: 3.0,
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
            padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                  color: Color(0xFFE0EBDD),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 22.0,
                            lineWidth: 3.0,
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
            padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                  color: Color(0xFFE0EBDD),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 22.0,
                            lineWidth: 3.0,
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
            padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                  color: Color(0xFFE0EBDD),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 22.0,
                            lineWidth: 3.0,
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
            padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                  color: Color(0xFFE0EBDD),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 22.0,
                            lineWidth: 3.0,
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
            padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                  color: Color(0xFFE0EBDD),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 22.0,
                            lineWidth: 3.0,
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
            padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                  color: Color(0xFFE0EBDD),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 22.0,
                            lineWidth: 3.0,
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
            padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                  color: Color(0xFFE0EBDD),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: 22.0,
                            lineWidth: 3.0,
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
        ],
    );
  }
}
