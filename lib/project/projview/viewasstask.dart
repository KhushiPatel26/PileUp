import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:pup/DB/models.dart';

import '../../DB/ApiService3.dart';
import '../../colors.dart';

class viewasstask extends StatefulWidget {
  final AssTask asst;
  viewasstask({Key? key, required this.asst}) : super(key: key);

  @override
  State<viewasstask> createState() => _viewasstaskState();
}

class _viewasstaskState extends State<viewasstask> {

  @override
  void init(){
    super.initState();
    _fetchData();
  }

  ApiService3 api=ApiService3();
  List<Assmem> assm=[];
  List<Asssubtask> assst=[];
  List<Userstb> users=[];
  Future<void> _fetchData() async {
    final data = await api.readRecords('Assmem');
    final data2 = await api.readRecords('Asssubtask');
    final data3 = await api.readRecords('Users');
    setState(() {
      assm = data.map((json) => Assmem.fromJson(json)).where((element) => element.assid==widget.asst.assid).toList();
      assst = data2.map((json) => Asssubtask.fromJson(json)).where((element) => element.assid==widget.asst.assid).toList();
      users = data3.map((json) => Userstb.fromJson(json)).toList();
    });
    print(assm);
    print(assst);
    print(users);
  }
  Random _random = Random();
  Color _getRandomColor() {
    int r = _random.nextInt(250);
    int g = _random.nextInt(250);
    int b = _random.nextInt(250);
    return Color.fromRGBO(r, g, b, 1.0);
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Assigned Task",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.cancel_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.only(top: 10.0, bottom: 10, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.asst.msg.toString(),style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w500),),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Assigned by:",
                      style: TextStyle(color: Colors.black),
                    ),
                    Chip(
                      labelPadding: EdgeInsets.all(2.0),
                      avatar: CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Text(findName(widget.asst.postedBy)[0].toUpperCase()),
                      ),
                      label: Text(
                        findName(widget.asst.postedBy),
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                      side: BorderSide(color: _getRandomColor()),
                      backgroundColor: _getRandomColor().withOpacity(0.9),
                      elevation: 0.0,
                      shadowColor: Colors.grey[60],
                      padding: EdgeInsets.all(8.0),
                    )

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 10, right: 15),
                child: Text(
                  "Assigned to:",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                width: 300,
                child: chipList(),
              ),
              Container(
                color: Colors.white12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Text(
                        "Task Description:",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Html(
                        data: widget.asst.desc,
                        style: {
                          'p':Style(color: Colors.black)
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Due Date: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(widget.asst.duedate.toString()))}",//
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0, left: 10, bottom: 0),
                      child: Text(
                        "Priority:",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child:Text(widget.asst.priority.toString())
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child:
                    Text("Status:", style: TextStyle(color: Colors.black)),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.green.withOpacity(0.6),
                            size: 10,
                          ),
                          Text("   In Progress",
                              style: TextStyle(
                                  color: Colors.green.withOpacity(0.6))),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: green.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: Colors.green.withOpacity(0.6))),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Subtasks:", style: TextStyle(color: Colors.black)),
              ),

              for(int i=0;i<assst.length;i++)
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {},
                            side: BorderSide(color: Colors.black), // Reduce the checkbox size
                            shape: CircleBorder(),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 200,
                            child: Text(
                              findName(assst[i].subtask),style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),


              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         children: [
              //           Checkbox(
              //             value: false,
              //             onChanged: (bool? value) {},
              //             side: BorderSide(
              //                 color: Colors.black), // Reduce the checkbox size
              //             shape: CircleBorder(),
              //           ),
              //           Text("Subtask 1",
              //               style: TextStyle(color: Colors.black)),
              //         ],
              //       ),
              //       IconButton(
              //           onPressed: () {},
              //           icon: Icon(
              //             Icons.close,
              //             color: Colors.black,
              //             size: 18,
              //           ))
              //     ],
              //   ),
              // ),
              // Row(
              //   children: [
              //     IconButton(
              //         onPressed: () {},
              //         icon: Icon(
              //           Icons.add_circle_outlined,
              //           color: Colors.black,
              //         )),
              //     Text("Attach Files", style: TextStyle(color: Colors.black))
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  chipList() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 4.0,
      children: <Widget>[
        for(int i=0;i<assm.length;i++)
          _buildChip(findName(assm[i].uid)),
        // _buildChip('Hacker', blue),
        // _buildChip('Developer', brown),
        // _buildChip('Racer', orange),
        // _buildChip('Traveller', green),
      ],
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      ),
      // onDeleted: () {
      //   print("delete");
      //   selectedMembers.remove(label);// Do something when the chip is deleted
      // },
      side: BorderSide(color: _getRandomColor()),
      backgroundColor: _getRandomColor().withOpacity(0.9),
      elevation: 0.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }

}
