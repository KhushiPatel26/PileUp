import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:pup/people/addcont.dart';

import '../home/profile.dart';

class cont extends StatefulWidget {
  const cont({Key? key}) : super(key: key);

  @override
  State<cont> createState() => _contState();
}

class _contState extends State<cont> {
  TextEditingController textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
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
        title: Text('Contacts',style: TextStyle(color: Colors.black),),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: IconButton(icon: Icon(Icons.add,color: Colors.black,), onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => addcont()));
              },)
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(icon: Icon(Icons.more_vert,color: Colors.black,), onPressed: (){},)
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),

            /// In AnimSearchBar widget, the width, textController, onSuffixTap are required properties.
            /// You have also control over the suffixIcon, prefixIcon, helpText and animationDurationInMilli
            child: AnimSearchBar(
              width: 400,
              color: Colors.white70,
              textController: textController,
              onSuffixTap: () {
                setState(() {
                  textController.clear();
                });
              }, onSubmitted: (String ) {  },
            ),

          ),
        ],
      ),
    );
  }
}
