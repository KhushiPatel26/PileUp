import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pup/project/projv.dart';
import 'package:pup/project/projview/viewasstask.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import '../../DB/ApiService3.dart';
import '../../DB/models.dart';

class threads extends StatefulWidget {
  final int projId;
  const threads({Key? key, required this.projId}) : super(key: key);

  @override
  State<threads> createState() => _threadsState();
}

class _threadsState extends State<threads> {
  late QuillEditorController controller;
  ApiService3 api = ApiService3();
  String? uid;
  @override
  void initState() {
    controller = QuillEditorController();
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    uid = user?.uid;
    print("uid:" + uid!);
    _fetchData();
  }
List<AssTask> asstask=[];
  List<Userstb> users=[];
  List<Msg> msg=[];
  Future<void> _fetchData() async {
    final data = await api.readRecords('AssTask');
    final data2 = await api.readRecords('Users');
    final data3 = await api.readRecords('Messages');
    setState(() {
      asstask = data.map((json) => AssTask.fromJson(json)).where((element) => element.pid==widget.projId).toList();
      msg = data3.map((json) => Msg.fromJson(json)).where((element) => element.pid==widget.projId).toList();

      users = data2.map((json) => Userstb.fromJson(json)).toList();
    });
    print(asstask);
    print(msg);
  }

  String findName(String id) {
    //String name;
    for(int i=0;i<users.length;i++){
      if(id==users[i].uid){
        return users[i].name;
      }
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if(asstask.length!=0)
            for(int i=0;i<asstask.length;i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => viewasstask(asst:asstask[i])));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,//Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)
                ),
                child: Column(
                  children: [
                      Container(
                        decoration: BoxDecoration(
                         // color: Colors.grey.withOpacity(0.1)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(findName(asstask[i].postedBy),style: TextStyle(color: Colors.black),),
                                      // Text('Project member',
                                      //   style: TextStyle(color: Colors.black.withOpacity(0.8)),)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0,left: 20),
                              child: Text(asstask[i].msg,style: TextStyle(color: Colors.black,fontSize: 20),),
                            ),
                           // QuillHtmlEditor(controller: controller, minHeight: minHeight)
              // QuillHtmlEditor(
              //   text: asstask[i].desc.toString() ?? "",
              //   hintText: 'Type something',
              //   controller: controller,
              //   isEnabled: false,
              //   minHeight: 500,
              //   textStyle: TextStyle(color: Colors.black),
              //   hintTextStyle: TextStyle(
              //     fontSize: 18,
              //     color: Colors.black38,
              //     fontWeight: FontWeight.normal,
              //   ),
              //   hintTextAlign: TextAlign.start,
              //   padding: const EdgeInsets.only(top: 10),
              //   backgroundColor: Colors.white,
              // ),
              // Html(
              //   data: '<p>hello</p>',
              // // style: {
              // //     'p': Style(color: Colors.black,textDecorationColor: Colors.black, )
              // // },
              // ),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0,left: 25),
                              child: Text(asstask[i].desc.toString(),style: TextStyle(color: Colors.black.withOpacity(0.3)),),
                            ),
                            Html(
                              data: asstask[i].desc,
                              style: {
                                'p':Style(color: Colors.black)
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:15.0,left: 20,bottom: 10),
                                  child: Container(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        Icon(Icons.mode_comment_outlined,color: Colors.lightBlueAccent,size: 15,),
                                        SizedBox(width: 10,),
                                        Text('Comment',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 12),)
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Text(DateFormat('dd/MM HH:mm').format(DateTime.parse(asstask[i].timing)),style: TextStyle(color: Colors.black.withOpacity(0.3),fontSize: 12),),
                                ),
                              ],
                            )

                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
          if(msg.length!=0)
            for(int i=0;i<msg.length;i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,//Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white38
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(findName(msg[i].uid),style: TextStyle(color: Colors.black)),
                                   // Text('Project member',style: TextStyle(color: Colors.black))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(msg[i].msg,style: TextStyle(color: Colors.black)),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Html(
                            data: msg[i].msg,
                            style: {
                              'p':Style(color: Colors.black)
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text('Shared Files',style: TextStyle(color: Colors.black)),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:15.0,left: 20,bottom: 10),
                              child: Container(
                                width: 150,
                                child: Row(
                                  children: [
                                    Icon(Icons.mode_comment_outlined,color: Colors.lightBlueAccent,size: 15,),
                                    SizedBox(width: 10,),
                                    Text('Comment',style: TextStyle(color: Colors.lightBlueAccent,fontSize: 12),)
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(DateFormat('dd/MM HH:mm').format(DateTime.parse(msg[i].timing)),style: TextStyle(color: Colors.black.withOpacity(0.3),fontSize: 12),),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          Container(
            height: 900,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
