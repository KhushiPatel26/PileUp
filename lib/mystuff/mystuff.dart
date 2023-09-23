import 'package:flutter/material.dart';
import 'package:pup/mystuff/note/notepg.dart';
import 'package:pup/mystuff/note/notes.dart';
import 'package:pup/mystuff/note/noteview.py.dart';
import 'package:pup/mystuff/task/taskpg.dart';

class myStuff extends StatefulWidget {
  const myStuff({Key? key}) : super(key: key);

  @override
  State<myStuff> createState() => _myStuffState();
}
bool visible=true;
class _myStuffState extends State<myStuff> {
  bool task=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
      children: [
        AnimatedSize(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300),
          child: Container(
            width: visible?50:0,
            color: Colors.grey.withOpacity(0.2),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:170.0),
                  child: Container(
                    //color: Colors.grey,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Text(
                              'TASKS',
                              style: TextStyle(fontSize: 27,
                                  color: task?Colors.black:Colors.black.withOpacity(0.3),
                                  letterSpacing: 5.0,
                                  fontWeight: task?FontWeight.w200:FontWeight.w100
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                task=true;
                              });
                            },
                          ),
                          if(task)
                            Icon(Icons.circle,size: 8,color: Colors.black,)
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:70.0),
                  child: Container(
                    //color: Colors.grey,
                    //width: 60,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Text(
                              'NOTES',
                              style: TextStyle(
                                  fontSize: 27,
                                  color: task?Colors.black.withOpacity(0.3):Colors.black,
                                  letterSpacing: 5.0,
                                  fontWeight: task?FontWeight.w100:FontWeight.w200
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                task=false;
                              });
                            },
                          ),
                          if(!task)
                            Icon(Icons.circle,size: 8,color: Colors.black,)
                        ],
                      ),
                    ),
                    //Wrap(
                    //   direction: Axis.vertical,
                    //   children: [
                    //     Text("TASKS",style: TextStyle(color: Colors.red),),
                    //     Text("NOTES",style: TextStyle(color: Colors.red),)
                    //   ],
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            AnimatedSize(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 300),
              child: Container(
                color: Colors.blueGrey,
                width: visible?(MediaQuery.of(context).size.width)-50:MediaQuery.of(context).size.width,
                child: task?taskpg():notes(),//#notepg(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 90.0,left: 10),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 45,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          border: Border.all(color: Colors.black),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(onPressed: (){
                        setState(() {
                          visible=!visible;
                        });
                      }, icon: visible?Icon(Icons.navigate_before,color: Colors.black,):Icon(Icons.navigate_next,color: Colors.black,)))
              ),
            ),
          ],
        )
      ],
        ),
    );
  }
}
