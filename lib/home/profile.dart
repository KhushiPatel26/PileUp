import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){
          Navigator.of(context).pop();
        },),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset("lib/assets/profile.png"),
            radius: 20,
          ),
          Text("username",style: TextStyle(color: Colors.black),),
          Text("username",style: TextStyle(color: Colors.black),),
          Text("username",style: TextStyle(color: Colors.black),),
          Text("username",style: TextStyle(color: Colors.black),),
        ],
      ),
    );
  }
}
