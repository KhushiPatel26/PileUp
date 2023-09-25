import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pup/startingpgs/welcome.dart';
import 'package:http/http.dart' as http;

import '../DB/ip.dart';
import '../DB/models.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  late User? user;
  late String? uid;
  // Map<String, dynamic>? userData;
  //late Userstb userData;
  List<Userstb> items = [];
  List<Userstb> login = [];
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = _auth.currentUser;
    uid=user!.uid;
    print("uid:"+uid!);
    fetchUserData();
    // fetchPostsById(uid);
  }

  Future<void> fetchUserData() async {
    final response = await http.get(Uri.parse('http://$ip:3000/user?email=${user?.email}'));

    if (response.statusCode == 200) {
      setState(() {

        Iterable list = json.decode(response.body);
        // items = list
        //     .map((model) => Userstb.fromJson(model)) // Add a null check here
        //     .where((user) => user != null) // Filter out null users
        //     .toList();
        // print(items[0].name);
        login=list
            .map((model) => Userstb.fromJson(model)) // Add a null check here
            .where((user) => user.uid == uid) // Filter out null users
            .toList();
        print(login[0].name);
      });

      // final Map<String, dynamic> userDataJson = json.decode(response.body);
      // setState(() {
      //   userData = Userstb.fromJson(userDataJson);
      // });
    } else {
      throw Exception('Failed to load user data'+response.statusCode.toString());
    }
  }

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
      body: login.length==0? Center(child: CircularProgressIndicator()) :
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset("lib/assets/profile.png"),
            radius: 20,
          ),
          Text(login[0].name,style: TextStyle(color: Colors.black),),
          Text(items.length.toString(),style: TextStyle(color: Colors.black),),
          Text(user?.email ?? 'N/A',style: TextStyle(color: Colors.black),),
          Text(user?.uid ?? 'N/A',style: TextStyle(color: Colors.black),),
          ElevatedButton(onPressed: ()async {
            try {
              await FirebaseAuth.instance.signOut();
              // Navigate to the sign-in screen after successful sign-out
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => welcome()),
              );
            } catch (e) {
              print('Error signing out: $e');
              // Handle sign-out error
            }
          },
              child:Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10.0, left: 8.0, right: 8.0),
                child: Text("Log Out",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),),
              ),
              style: ElevatedButton.styleFrom(
                //primary: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 4.0,
              )
          )
        ],
      ),
    );
  }
}
