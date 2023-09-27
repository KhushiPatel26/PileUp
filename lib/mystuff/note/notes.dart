import 'package:flutter/material.dart';
import '../../home/profile.dart';
import '../mystuff.dart';
import 'addnote.dart';

class notes extends StatefulWidget {
  const notes({Key? key}) : super(key: key);

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(top:15.0,right: 20.0,left: 8.0,bottom: 8.0),
          child: GestureDetector(
            onTap: (){
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
        ),
        title: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 70.0),
                child: Text(
                  'Hello!',
                  style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.w200, fontSize: 15
                  ),
                ),
              ),
              Text(
                'Khushi Patel',
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.0, right: visible ? 100 : 150, left: 20),
                child: Text("My Notes",style: TextStyle(fontSize: 30,color: Colors.black, fontWeight: FontWeight.bold),),
              ),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>addnote()));
                }, icon:Icon(Icons.add, color: Colors.white,size: 15,),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
