import 'package:flutter/material.dart';
import 'package:pup/colors.dart';
import 'package:pup/project/projview/activities.dart';
import 'package:pup/project/projview/files.dart';
import 'package:pup/project/projview/threads.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';
import 'package:sticky_headers/sticky_headers.dart';

class projv extends StatefulWidget {
  const projv({Key? key}) : super(key: key);

  @override
  State<projv> createState() => _projvState();
}

class _projvState extends State<projv> {
  final ScrollController _scrollController = ScrollController();
  List<String> tabs=["Message Threads", "Tasks","Files"];
  List ontab=[threads(),activities(),files()];
  int selectedIndex = 0;
  String proj_desc="'PileUp' is a handy productive app that helps user to manage their tasks, projects, and contacts. "
      "Whether you're an individual looking to stay organized or a business needing efficient project management. "
      "It offers tools for creating task lists, taking notes, collaborating on projects, and keeping your contacts in order. "
      "It's like having a digital assistant to help you stay update and work together.";


  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(text: 'Team: ',
                              style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w300),),
                            TextSpan(text: 'PileUp',
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
                child: Text("PileUp Database & UI",
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
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(width: 1, color: Colors.black.withOpacity(0.2))
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.access_time,size: 15,color: Colors.black.withOpacity(0.4),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 5.0),
                                      child: Text("26 September",
                                        style: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15,fontWeight: FontWeight.w600),),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text("3 days left",
                                          style: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 12,fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top:4.0,bottom: 4,right:3 ,left:22 ),
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
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Container(
                                          width: 30,
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 120.0),
                                    child: Container(

                                      width: 40,
                                      height: 30,
                                      child: IconButton(onPressed: (){},
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
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.0),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:3.0,bottom:3.0,left: 8,right: 8),
                                        child: Text("Project",style: TextStyle(color: orange,fontSize: 10),),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
                                          border: Border.all(color: orange,width: 0.7),
                                          color: orange.withOpacity(0.4)
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.0),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:3.0,bottom:3.0,left: 8,right: 8),
                                        child: Text("College",style: TextStyle(color: brown,fontSize: 10),),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
                                          border: Border.all(color: brown,width: 0.7),
                                          color: brown.withOpacity(0.4)
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.0),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:3.0,bottom:3.0,left: 8,right: 8),
                                        child: Text("Sem V",style: TextStyle(color: green,fontSize: 10),),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
                                          border: Border.all(color: green,width: 0.7),
                                          color: green.withOpacity(0.4)
                                      ),
                                    ),
                                  ),
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
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black,width: 0.5)
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
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15,bottom: 10),
                              child: Text(proj_desc.length<210?proj_desc:proj_desc.substring(0,200)+" ...",
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                StickyHeader(header: Container(
                  color: Colors.white,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      children: [
                        for(int i=0;i<3;i++)
                          GestureDetector(
                              child: Container(
                                height: 37,
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
                                              '+5',
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
                          )
                      ],
                    ),
                  ),
                ), content:Container(child: ontab[selectedIndex],))


              ],
            ),
          ),
        ),
      ),
    );
  }
}
