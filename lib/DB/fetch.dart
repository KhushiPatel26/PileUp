import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ip.dart';
import 'models.dart';

class fetch extends StatefulWidget {
  const fetch({Key? key}) : super(key: key);

  @override
  State<fetch> createState() => _fetchState();
}

class _fetchState extends State<fetch> {
  late User? user;
  late String? uid;
  List<Userstb> login = [];
  List<ToDoTask> todotask = [];
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = _auth.currentUser;
    uid=user!.uid;
    print("uid:"+uid!);
    fetchUserData();
    fetchTaskData();
    // fetchPostsById(uid);
  }


  Future<void> fetchUserData() async {
    final response = await http.get(Uri.parse('http://$ip:3000/user?email=${user?.email}'));

    if (response.statusCode == 200) {
      setState(() {

        Iterable list = json.decode(response.body);
        login=list
            .map((model) => Userstb.fromJson(model)) // Add a null check here
            .where((user) => user.uid == uid) // Filter out null users
            .toList();
        print(login[0].name);
      });
    } else {
      throw Exception('Failed to load user data'+response.statusCode.toString());
    }
  }
  Future<void> fetchTaskData() async {
    final response = await http.get(Uri.parse('http://$ip:3000/Tasks'));
    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        todotask=list
            .map((model) => ToDoTask.fromJson(model)) // Add a null check here
            .where((user) => user.usId == uid) // Filter out null users
            .toList();
        print(todotask);
        for (int i=0;i<todotask.length;i++) {
          print(todotask[i].toJson());
          // Add your code to process the retrieved data
        }
      });
    } else {
      throw Exception('Failed to load user data'+response.statusCode.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
