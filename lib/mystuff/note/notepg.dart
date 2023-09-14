import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class notepg extends StatefulWidget {
  const notepg({Key? key}) : super(key: key);

  @override
  State<notepg> createState() => _notepgState();
}

class _notepgState extends State<notepg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text("My Notess",style: TextStyle(fontSize: 50,color: Colors.black),),
      SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(12),
          child: MasonryGridView.builder(
            crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
              ),
              itemCount: 5,
              itemBuilder: (context,index){
                return Container(
                  color: Colors.black,
                  width: index+10,
                  height: index+20,
                );
              }
          ),
        ),
      ),


        ],
      ),
    );
  }
}

/*
Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text("My Notes",style: TextStyle(fontSize: 50,color: Colors.black),)
        ],
      ),
    );
* */