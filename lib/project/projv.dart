import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pup/colors.dart';
import 'package:pup/project/projhome.dart';
import 'package:pup/project/projview/activities.dart';
import 'package:pup/project/projview/assigntask.dart';
import 'package:pup/project/projview/files.dart';
import 'package:pup/project/projview/threads.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../DB/ApiService3.dart';
import '../DB/models.dart';
import 'projview/addmsg.dart';

class projv extends StatefulWidget {
  final Project pid;

  const projv({Key? key, required this.pid}) : super(key: key);

  @override
  State<projv> createState() => _projvState();
}

List<String> selectedMembers = [];
Map<String, Color> mem = {};
Map<String, String> name_id = {};
String? uid;

Random _random = Random();
Color _getRandomColor() {
  int r = _random.nextInt(250);
  int g = _random.nextInt(250);
  int b = _random.nextInt(250);
  return Color.fromRGBO(r, g, b, 1.0);
}

class _projvState extends State<projv> {
  final ScrollController _scrollController = ScrollController();
  List<String> tabs=["Message Threads", "Tasks","Files"];

  late List ontab;
  int selectedIndex = 0;
  late QuillEditorController controller;
  // String proj_desc="'PileUp' is a handy productive app that helps user to manage their tasks, projects, and contacts. "
  //     "Whether you're an individual looking to stay organized or a business needing efficient project management. "
  //     "It offers tools for creating task lists, taking notes, collaborating on projects, and keeping your contacts in order. "
  //     "It's like having a digital assistant to help you stay update and work together.";


  String? uid;
  String proj_desc='';
  @override
  void initState() {
    super.initState();
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User? user = _auth.currentUser;
    // uid = user?.uid;
    // print("uid:" + uid!);
    ontab=[threads(projId: widget.pid.projectId!),activities(projId: widget.pid.projectId!),files(projId: widget.pid.projectId!)];
    proj_desc=widget.pid.description;
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    //tabs.addAll(widget.pid.tags.split(','));
    _fetchMem();
    _fetchData();
  }
  ApiService3 api = ApiService3();
List<ProjMem> pmm=[];
List<Userstb> puser=[];
List<Comp_Mem> cmm=[];
  Future<void> _fetchMem() async {
    final data = await api.readRecords('Proj_Mem');
    final data2 = await api.readRecords('Users');
    //final data3 = await api.readRecords('comp_mem');
    setState(() {
      pmm = data.map((json) => ProjMem.fromJson(json)).where((element) => element.projectId==widget.pid.projectId).toList();
      for(int i=0;i<pmm.length;i++){
        puser.addAll(data2.map((json) => Userstb.fromJson(json)).where((element) => element.uid==pmm[i].uid).toList());
      }
      print("CompCode: ${compcode}");
      cmm = data.map((json) => Comp_Mem.fromJson(json)).where((element) => element.companyCode==compcode).toList();
      print(cmm);
    });
  }

//  ApiService3 api = ApiService3();

  List<Project> proj=[];
  List<Comp_Mem> compmem=[];
  List<Userstb> users=[];
  String compCode="";

  Future<void> _fetchData() async {
    final data2 = await api.readRecords('Comp_Mem');
    setState(() {
      // compmem = data2.map((json) => Comp_Mem.fromJson(json)).where((element) => element.uid==uid).toList();
      // compCode=compmem[0].companyCode;
      // print("cc: $compCode");
      compmem = data2.map((json) => Comp_Mem.fromJson(json)).where((element) => element.companyCode==compcode).toList();
    });
    print("Comp_Mem:");
    print(compmem);

    final data3 = await api.readRecords('Users');
    setState(() {
      for(int i=0;i<compmem.length;i++){
        users = data3.map((json) => Userstb.fromJson(json)).where((element) => element.uid==compmem[i].uid).toList();
        mem.putIfAbsent(users[i].name, () => _getRandomColor());
        name_id.putIfAbsent(users[i].name, () => users[i].uid!);
      }
    });
    print("Users:");
    print(users);
  }

  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w300,
      fontFamily: 'Roboto');

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 250,
          leading: Padding(
            padding: const EdgeInsets.only(top:5.0,left: 20),
            child: Container(
              height: 85,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                        border: Border.all(color: Colors.grey,width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(text: 'Team: ',
                              style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w300),),
                            TextSpan(text: widget.pid.name,//'PileUp',
                              style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500),)
                          ]
                      ),
                    ),
                  ),

                  IconButton(
                    icon: Icon(Icons.edit,color:  Colors.black.withOpacity(0.3),size: 15,),
                    onPressed: () {},
                  ),

                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications,color: Colors.black.withOpacity(0.3),),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.cancel,color:  Colors.black.withOpacity(0.3),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          bottom:  PreferredSize(
            preferredSize: Size.fromHeight(35),
            child: Padding(
              padding: const EdgeInsets.only(top:8,left: 20,bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(widget.pid.name,
                  style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(top:10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Due Date: ",
                              style: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 12,fontWeight: FontWeight.w300),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Container(
                                width: 260,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.grey,width: 0.5)
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.access_time,size: 15,color: Colors.black.withOpacity(0.4),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 5.0),
                                      child: Text('${DateFormat.d().format(DateTime.parse(widget.pid.dueDate))} ${DateFormat.MMMM().format(DateTime.parse(widget.pid.dueDate))}',//"26 September",
                                        style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15,fontWeight: FontWeight.w600),),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text('${(DateTime.parse(widget.pid.dueDate)).difference(DateTime.now()).inDays} days left',//"3 days left",
                                          style: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 12,fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top:4.0,bottom: 4,right:3 ,left:40 ),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        child: IconButton(onPressed: (){},icon: Icon(Icons.calendar_month_outlined,color: Colors.white,size: 15,),),
                                          decoration: BoxDecoration(
                                          color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Members: ",
                              style: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 12,fontWeight: FontWeight.w300),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      if(pmm.length==0)
                                        CircleAvatar(
                                          child: Icon(Icons.person_add_alt_sharp),
                                          backgroundColor: Colors.transparent,
                                        ),

                                      if(pmm.length>0)
                                        for(int i=0;i<pmm.length;i++)
                                          Padding(
                                            padding: EdgeInsets.only(left: i.toDouble()*20.0),
                                            child: CircleAvatar(
                                              backgroundColor: _getRandomColor(),
                                              child: Text(puser[i].name[0]),
                                            ),
                                          )
                                    ],
                                  ),
                                  // Stack(
                                  //   children: [
                                  //     Align(
                                  //       alignment: AlignmentDirectional(-1, 0),
                                  //       child: Container(
                                  //         width: 30,
                                  //         height: 30,
                                  //         clipBehavior: Clip.antiAlias,
                                  //         decoration: BoxDecoration(
                                  //           shape: BoxShape.circle,
                                  //
                                  //         ),
                                  //         child: Image.network(
                                  //           'https://source.unsplash.com/random/sig=1',
                                  //           fit: BoxFit.cover,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Padding(
                                  //       padding: EdgeInsetsDirectional.fromSTEB(
                                  //           20, 0, 0, 0),
                                  //       child: Container(
                                  //         width: 30,
                                  //         height: 30,
                                  //         clipBehavior: Clip.antiAlias,
                                  //         decoration: BoxDecoration(
                                  //           shape: BoxShape.circle,
                                  //         ),
                                  //         child: Image.network(
                                  //           'https://source.unsplash.com/random/sig=2',
                                  //           fit: BoxFit.cover,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Padding(
                                  //       padding: EdgeInsetsDirectional.fromSTEB(
                                  //           40, 0, 0, 0),
                                  //       child: Container(
                                  //         width: 30,
                                  //         height: 30,
                                  //         clipBehavior: Clip.antiAlias,
                                  //         decoration: BoxDecoration(
                                  //           shape: BoxShape.circle,
                                  //         ),
                                  //         child: Image.network(
                                  //           'https://source.unsplash.com/random/sig=4',
                                  //           fit: BoxFit.cover,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Padding(
                                  //       padding: EdgeInsetsDirectional.fromSTEB(
                                  //           70, 0, 0, 0),
                                  //       child: //badges.
                                  //       Badge(
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               top: 8.0, right: 8),
                                  //           child: Text(
                                  //             '+5',
                                  //             style: TextStyle(
                                  //                 fontFamily: 'Readex Pro',
                                  //                 color: Colors.black),
                                  //           ),
                                  //         ),
                                  //         backgroundColor:
                                  //         Colors.black.withOpacity(0.5),
                                  //         //largeSize: 5,
                                  //         smallSize: 30,
                                  //         // showBadge: true,
                                  //         // shape: BadgeShape.circle,
                                  //         // badgeColor: Colors.white70,
                                  //         // elevation: 4,
                                  //         // padding: EdgeInsetsDirectional.fromSTEB(
                                  //         //     8, 8, 8, 8),
                                  //         // position: BadgePosition.topEnd(),
                                  //         // animationType: BadgeAnimationType.scale,
                                  //         // toAnimate: true,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 120.0),
                                    child: Container(
                                      width: 40,
                                      height: 30,
                                      child: IconButton(onPressed: () {
                                        _fetchData();
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          enableDrag: true,
                                          context: context,
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadiusDirectional.only(
                                              topEnd: Radius.circular(25),
                                              topStart: Radius.circular(25),
                                            ),
                                          ),
                                          builder: (BuildContext context) {
                                            return SingleChildScrollView(child: MemberListBottomSheet());
                                          },
                                        );
                                      },
                                          icon: Icon(Icons.more_horiz,color: Colors.black,)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:18),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Labels: ",
                              style: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 12,fontWeight: FontWeight.w300),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 23.0),
                              child: Row(
                                children: [
                                  for(int i=0;i<widget.pid.tags.split(',').length;i++)
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.0),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:3.0,bottom:3.0,left: 8,right: 8),
                                        child: Text("${widget.pid.tags.split(',')[i]}",style: TextStyle(color: Colors.black,fontSize: 10),),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
                                          border: Border.all(color: orange,width: 0.7),
                                          color: _getRandomColor().withOpacity(0.2)
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(right: 4.0),
                                  //   child: Container(
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.only(top:3.0,bottom:3.0,left: 8,right: 8),
                                  //       child: Text("College",style: TextStyle(color: brown,fontSize: 10),),
                                  //     ),
                                  //     decoration: BoxDecoration(
                                  //         borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
                                  //         border: Border.all(color: brown,width: 0.7),
                                  //         color: brown.withOpacity(0.4)
                                  //     ),
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(right: 4.0),
                                  //   child: Container(
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.only(top:3.0,bottom:3.0,left: 8,right: 8),
                                  //       child: Text("Sem V",style: TextStyle(color: green,fontSize: 10),),
                                  //     ),
                                  //     decoration: BoxDecoration(
                                  //         borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
                                  //         border: Border.all(color: green,width: 0.7),
                                  //         color: green.withOpacity(0.4)
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:3.0,bottom:3.0,left: 8,right: 8),
                                      child: Text("Add +",style: TextStyle(color: Colors.grey,fontSize: 10),),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
                                        border: Border.all(color: Colors.grey,width: 0.7),
                                        color: Colors.black.withOpacity(0.1)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: blue.withOpacity(0.2),//Colors.blueGrey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: blue,width: 1)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Text("Task Description",
                                  style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),
                                  ),
                                  IconButton(onPressed: (){},
                                      icon: Icon(Icons.edit_note_rounded,color: Colors.grey,))
                                ],
                              ),
                            ),
                            // FutureBuilder<String>(
                            //   future: widget.pid.description,
                            //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            //     if (snapshot.connectionState == ConnectionState.done) {
                            //       return QuillHtmlEditor(
                            //         text: snapshot.data ?? "",
                            //         hintText: 'Type something',
                            //         controller: controller,
                            //         isEnabled: false,
                            //         minHeight: 500,
                            //         textStyle: _editorTextStyle,
                            //         hintTextStyle: TextStyle(
                            //           fontSize: 18,
                            //           color: Colors.black38,
                            //           fontWeight: FontWeight.normal,
                            //         ),
                            //         hintTextAlign: TextAlign.start,
                            //         padding: const EdgeInsets.only(top: 10),
                            //         backgroundColor: widget.bgcolor,
                            //       );
                            //     } else {
                            //       return CircularProgressIndicator();
                            //     }
                            //   },
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left:12.0,bottom: 12,right: 10),
                              child: QuillHtmlEditor(
                                text: widget.pid.description,
                                //hintText: 'Type something',
                                controller: controller,
                                isEnabled: false,
                                minHeight: 30,
                                textStyle: _editorTextStyle,
                                hintTextStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black38,
                                  fontWeight: FontWeight.normal,
                                ),
                                hintTextAlign: TextAlign.start,
                                padding: const EdgeInsets.only(top: 10),
                                backgroundColor: blue.withOpacity(0.2),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 15.0, right: 15,bottom: 10),
                            //   child: Text(proj_desc.length<210?proj_desc:proj_desc.substring(0,200)+" ...",
                            //   style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                StickyHeader(
                    header: Container(
                  color: Colors.white,
                  // height: 40,
                  // width: 500,
                  child: Row(
                    children: [
                      for(int i=0;i<tabs.length;i++)
                        GestureDetector(
                            child: Container(
                              height: 39,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(tabs[i],
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 11
                                      ),),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 6.0,left: 10, top:4),
                                      child: Container(
                                        height: 20,
                                        width: 25,
                                        child: Center(
                                          child: Text(
                                            '15',
                                            style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                color: selectedIndex==i? Colors.white:Colors.black,
                                                fontSize: 10),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: selectedIndex==i?
                                            Colors.black : Colors.black.withOpacity(0.5) ,
                                            borderRadius: BorderRadius.circular(30)
                                        ),
                                        // backgroundColor: _selectedIndex==i?
                                        // Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.5) ,
                                        // smallSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,

                                  border: Border(
                                      bottom: selectedIndex == i ?BorderSide(color: Colors.black, width: 3):BorderSide(width: 0)
                                  )
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                selectedIndex = i;
                              });
                            }
                        ),
                     //SizedBox(width: 22,)
                      Container(
                        color: Colors.white,
                        height: 40,
                        width: 27,
                      )
                    ],
                  ),
                ), content:Container(child: ontab[selectedIndex],))


              ],
            ),
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: ()async {
            await showDialog<void>(
                context: context,
                builder: (context) => Container(
                  height: 600,
                  width: 720,
                 // color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 150,top:400),//,top:320),
                        child: AlertDialog(
                          shape: CircleBorder(side: BorderSide(color: Colors.black)),
                          backgroundColor: Colors.white,
                          content:  GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => assigntask(projid:widget.pid.projectId!)));
                            },
                            child: Container(
                              // height: 200,
                              // width: 100,
                              child: Column(
                                children: [
                                  Icon(Icons.task_alt,color: Colors.black,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Assign Task",style: TextStyle(color: Colors.black,fontSize: 12),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:0), //560
                        child: AlertDialog(
                          shape: CircleBorder(side: BorderSide(color: Colors.black)),
                          backgroundColor: Colors.white,
                          content: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addmsg(projId: widget.pid.projectId!)));
                            },
                            child: Container(
                              // height: 200,
                              //width: 90,
                              child: Column(
                                children: [
                                  //Image.asset("lib/assets/makeanote.png",width: 70,height: 90,),
                                  Icon(Icons.messenger,color: Colors.black),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Post a message/\nupdate",style: TextStyle(color: Colors.black,fontSize: 12),softWrap: true,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ));
          },
          child: Icon(Icons.add,color: Colors.white,),
        ),
      ),
    );
  }
}

class MemberListBottomSheet extends StatefulWidget {
  @override
  _MemberListBottomSheetState createState() => _MemberListBottomSheetState();
}

class _MemberListBottomSheetState extends State<MemberListBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Add Members",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontSize: 20)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                if(selectedMembers.length==0)
                  CircleAvatar(
                    child: Icon(Icons.person_add_alt_sharp),
                    backgroundColor: Colors.transparent,
                  ),

                if(selectedMembers.length>0)
                  for(int i=0;i<selectedMembers.length;i++)
                    Padding(
                      padding: EdgeInsets.only(left: i.toDouble()*10.0),
                      child: CircleAvatar(
                        backgroundColor: mem[selectedMembers[i]],
                        child: Text(selectedMembers[i][0]),
                      ),
                    )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mem.length,
              itemBuilder: (context, index) {
                return name_id[mem.keys.elementAt(index)]!=uid? ListTile(
                  leading: CircleAvatar(child: Text(mem.keys.elementAt(index)[0]),
                    backgroundColor: mem.values.elementAt(index),
                  ),
                  title: Text(mem.keys.elementAt(index),
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Checkbox(
                    side: BorderSide(color: Colors.black),
                    shape: CircleBorder(),
                    activeColor: Colors.black,
                    value: selectedMembers.contains(mem.keys.elementAt(index)),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedMembers.add(mem.keys.elementAt(index));
                        } else {
                          selectedMembers.remove(mem.keys.elementAt(index));
                        }
                      });
                    },
                  ),
                ) : Container();
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Do something with the selected members
              setState(() {
                selectedMembers=selectedMembers;
              });
              print('Selected Members: $selectedMembers');
              Navigator.pop(context);
            },
            child: Text('Add Members',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}