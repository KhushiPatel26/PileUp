import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation:5,
        leading: IconButton(
            onPressed: (){

            },
            icon:Icon(Icons.person,color:Colors.black,)
        ),
        title:Text('PileUp',style:TextStyle(color:Colors.black,fontWeight: FontWeight.w100),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.line_weight,color: Colors.black,))
        ],
      ),
      body: Container(
        color: Colors.white,
      ),

    );
  }
}

/*
morning
https://img.freepik.com/free-vector/cartoon-nature-landscape-beautiful-sunset-green-field-with-pond-grass-rocks-conifers-purple-sky-with-red-clouds-picturesque-scenery-background-natural-dusk-scene-vector-illustration_107791-10653.jpg?w=1060&t=st=1685804417~exp=1685805017~hmac=f93e9a83c2dca5cf443787191c13a0047cb79506e290acb547222e03dbe31dcf

afternoon
"https://img.freepik.com/free-vector/sunset-scenery-rural-landscape-field-with-hay-stacks-farm-buildings-colorful-cloudy-sky_107791-6409.jpg?size=626&ext=jpg"

evening
https://img.freepik.com/free-vector/sunset-landscape-with-lake-clouds-red-sky-silhouettes-hills-trees-coast_107791-4670.jpg?w=1380&t=st=1685805539~exp=1685806139~hmac=0cf27f72d32cc59047cda71ea3fb910bfc65baf7f06314954802dbecd1336b8d

night
https://img.freepik.com/premium-vector/colorful-purple-sky-with-cactus-desert-landscape_105940-419.jpg?size=626&ext=jpg

 */