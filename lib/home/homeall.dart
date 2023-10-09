import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pup/home/profile.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../DB/ip.dart';
import '../DB/models.dart';

class homeall extends StatefulWidget {

  const homeall({Key? key}) : super(key: key);

  @override
  State<homeall> createState() => _homeallState();
}

class _homeallState extends State<homeall> {
  int _count = 70;
  late User? user;
  late String? uid;
  List<Userstb> login = [];

  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = _auth.currentUser;
    uid=user!.uid;
    print("uid:"+uid!);
    fetchUserData();
    // fetchPostsById(uid);
  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pile Up',
          style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.w100
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {

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
          )
        ],
        elevation: 0,
      ),
      body:  login.length==0? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '  Hi ',
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'Qeilab', fontSize: 30),
                  ),
                  Text(
                    login[0].name.split(' ')[0],
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Qeilab',
                        fontSize: 30),
                  ),
                ],
              ),
              Text(
                'be productive today!',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Qeilab', fontSize: 30),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(37.0),
                        child: Container(
                            height: 127,
                            width: 127,
                            decoration: BoxDecoration(
                              color: Color(0xFFF9EB95),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.yellow.shade300.withOpacity(0.4),
                                  spreadRadius: 20,
                                  blurRadius: 9,
                                  offset: Offset(4, 16), // changes position of shadow
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CircularPercentIndicator(
                            radius: 75.0,
                            lineWidth: 12.0,
                            percent: (_count.toDouble()) / 100,
                            center: Padding(
                              padding: const EdgeInsets.only(top: 40.0,right: 10),
                              child: Column(
                                children: [
                                  Text("   ${(_count)}%",
                                      style: TextStyle(
                                          color: Colors.indigo.shade900,
                                          fontFamily: 'Voyager',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35)),
                                  Text("finished",
                                      style: TextStyle(
                                          color: Colors.indigo.shade900,
                                          fontFamily: 'Voyager',
                                          fontSize: 18)),
                                ],
                              ),
                            ),
                            //progressColor: Colors.green,
                            backgroundWidth: 30,
                            backgroundColor: Color(0xFFF9EB95),//Color(0xFFF9EB95),//Colors.yellow.shade200,
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
                            linearGradient: LinearGradient(
                              colors: [Colors.white,Colors.yellow.shade100],
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            startAngle: 0.0,
                            // animateFromLastPercent: true,
                            //   addAutomaticKeepAlive: true,
                            // arcType: ArcType.HALF,
                            // arcBackgroundColor: Colors.green.shade200,
                            // reverse: true,
                            // maskFilter: MaskFilter.blur(BlurStyle.normal, 5.0),
                            // curve: Curves.linear,
                            // restartAnimation: true,
                            // onAnimationEnd: (){print('progress...');},
                            // widgetIndicator: Text('V'),
                            // rotateLinearGradient: true,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300.withOpacity(0.3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Colors.grey.shade300.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: Offset(
                                          6, 7), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.indigo.shade900,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300.withOpacity(0.3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Colors.grey.shade300.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: Offset(
                                          6, 7), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.auto_graph,
                                  color: Colors.indigo.shade900,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300.withOpacity(0.3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Colors.grey.shade300.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: Offset(
                                          6, 7), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.pause,
                                  color: Colors.indigo.shade900,
                                )),
                          ],),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "32",
                                  style: TextStyle(
                                      color: Colors.indigo.shade900,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "done",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'Linle',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                Text(
                                  "04",
                                  style: TextStyle(
                                      color: Colors.indigo.shade900,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "in progress",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'Linle',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: [
                                Text(
                                  "07",
                                  style: TextStyle(
                                      color: Colors.indigo.shade900,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "pending",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'Linle',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0, left: 20),
                      child: Text( "Recent Tasks",
                        style: TextStyle(color: Colors.black,
                        fontFamily: 'Linle',
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.horizontal_split_outlined,color: Colors.black,))
                ],
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12,left: 12,top: 10),
                    child: Container(
                      width: 370,
                      height: 100,
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
                          color: Color(0xFFEBE3FB),
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
                          color: Color(0xFFEDEBDE),
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
                          color: Color(0xFFDEECEC),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
