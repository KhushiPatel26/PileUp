import 'dart:convert';


import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pup/startingpgs/signup/settingup.dart';
import 'package:pup/startingpgs/signup/sup1.dart';
import 'package:pup/startingpgs/signup/sup2.dart';
import 'package:pup/startingpgs/signup/sup3.dart';
import 'package:http/http.dart' as http;

import '../../DB/ip.dart';



class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}
List pages=[sup1()];
int cntr=1;
class _signupState extends State<signup> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              if(cntr<=4)
                Container(
                  height: 500,
                  child: pages[cntr-1],
                ),
              // Padding(
              //   padding: const EdgeInsets.only(top:700.0,right: 50,left: 50),
              //   child: Row(
              //     children: [
              //         Icon(cntr>=2?Icons.check_circle:Icons.circle_outlined,
              //           color: Colors.green,),
              //       Expanded(
              //         child: new Container(
              //             margin: const EdgeInsets.only(left: 3.0, right: 3.0),
              //             child: Divider(
              //               color: cntr>=2?Colors.green:Colors.lightGreenAccent,
              //               height: 50,
              //             )),
              //       ),
              //       Icon(cntr>=3?Icons.check_circle:Icons.circle_outlined,
              //         color: cntr>=2?Colors.green:Colors.lightGreenAccent,),
              //       Expanded(
              //         child: new Container(
              //             margin: const EdgeInsets.only(left: 3.0, right: 3.0),
              //             child: Divider(
              //               color: cntr>=3?Colors.green:Colors.lightGreenAccent,
              //               height: 50,
              //             )),
              //       ),
              //       Icon(cntr>=4?Icons.check_circle:Icons.circle_outlined,
              //         color: cntr>=3?Colors.green:Colors.lightGreenAccent,
              //       ),
              //       Expanded(
              //         child: new Container(
              //             margin: const EdgeInsets.only(left: 3.0, right: 3.0),
              //             child: Divider(
              //               color: cntr>=4?Colors.green:Colors.lightGreenAccent,
              //               height: 50,
              //             )),
              //       ),
              //       Icon(cntr>=5?Icons.check_circle:Icons.circle_outlined,
              //         color: cntr>=4?Colors.green:Colors.lightGreenAccent,),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top:700.0,right: 30,left: 30),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Visibility(
              //         visible: cntr==1? false:true,
              //         child: ElevatedButton(onPressed: (){
              //           setState(() {
              //             cntr-=1;
              //             print(cntr);
              //           });
              //         }, child: Text("Back")),
              //       ),
              //       ElevatedButton(onPressed: (){
              //         setState(() {
              //
              //           cntr+=1;
              //           print(cntr);
              //         });
              //         if(cntr==5){
              //
              //           Navigator.push(context, MaterialPageRoute(builder: (context)=>settingUp()));
              //         }
              //       }, child: Text("Next")),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
