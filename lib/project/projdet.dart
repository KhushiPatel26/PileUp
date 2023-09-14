import 'package:flutter/material.dart';
import 'package:pup/project/projview/activities.dart';
import 'package:pup/project/projview/files.dart';
import 'package:pup/project/projview/threads.dart';

class projdet extends StatefulWidget {
  const projdet({Key? key}) : super(key: key);

  @override
  State<projdet> createState() => _projdetState();
}

class _projdetState extends State<projdet> {
  List<String> tabs=["Thread Tasks", "Activities","Files"];
  List ontab=[threads(),activities(),files()];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 190.0,
            floating: true,
            pinned: true,
            snap: true,
            leading: Padding(
              padding: const EdgeInsets.only(top:5.0,left: 20),
              child: Container(
                height: 100,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'Team: ',
                          style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300),),
                        TextSpan(text: '... Design',
                          style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),)
                      ]
                    ),
                    ),
                    ),
                    SizedBox(width: 10.0),
                    Icon(Icons.edit),
                  ],
                ),
              ),
            ),
            leadingWidth: 300,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {},
              ),
            ],
            //centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Sliver App Bar Example",
                style: TextStyle(fontSize: 15),
              ),
            ),
            bottom: PreferredSize(preferredSize: Size.fromHeight(50), child: Text("Hii Pratham"),),
            collapsedHeight: 100,
          ),
      SliverList(
        delegate: SliverChildListDelegate([
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

