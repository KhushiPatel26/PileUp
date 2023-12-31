import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pup/project/projview/activities.dart';
import 'package:pup/project/projview/files.dart';
import 'package:pup/project/projview/threads.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';

class projdet extends StatefulWidget {
  const projdet({Key? key}) : super(key: key);

  @override
  State<projdet> createState() => _projdetState();
}

class _projdetState extends State<projdet> {
  final ScrollController _scrollController = ScrollController();
  List<String> tabs=["Message Threads", "Tasks","Files"];
  List ontab=[];
////not initializing...
  int selectedIndex = 0;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 50,
            backgroundColor: Colors.white,
            expandedHeight: 190.0,
            floating: true,
            pinned: true,
            snap: false,
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
                        borderRadius: BorderRadius.circular(20.0),
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
                    SizedBox(width: 10.0),
                    IconButton(
                      icon: Icon(Icons.edit,color:  Colors.black.withOpacity(0.3),size: 15,),
                      onPressed: () {},
                    ),

                  ],
                ),
              ),
            ),
            leadingWidth: 300,
            actions: <Widget>[
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
            //centerTitle: true,
            // title: Text(
            //   "riyjhgvmcgfzyreyresdygkj",
            //   style: TextStyle(fontSize: 15,color: Colors.black),
            // ),
            // titleSpacing: 100,
            flexibleSpace: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:80.0),
                  child: FlexibleSpaceBar(
                    title: Text(
                      "PileUp App Database",
                      style: TextStyle(fontSize: 15,color: Colors.black),
                    ),
                    centerTitle: false,
                    titlePadding: EdgeInsets.only(top:20,left: 20,bottom: 5),
                  ),
                ),

                ScrollToHide(
                  scrollController: _scrollController,
                  height: 25, // The initial height of the widget.
                  duration: Duration(milliseconds: 300), // Duration of the hide/show animation.
                  child:  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Row(
                          children: [
                            Text("Due Date:",style: TextStyle(fontSize: 15,color: Colors.black)),
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.access_time),
                                  Text(DateFormat.d().format(DateTime.now()).toString())
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                ),

              ]
            ),
            // bottom: PreferredSize(preferredSize: Size.fromHeight(50),
            //   child: Text("Hello",style: TextStyle(fontSize: 15,color: Colors.black)),),
            collapsedHeight: 170,
          ),
      SliverList(
        delegate: SliverChildListDelegate([

          Container(child: ontab[selectedIndex],)
        ]),),
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Container(
              height: 0.0,
                
          ),
            ),
            hasScrollBody: false,
          )
        ],
      ),
    );
  }

}

