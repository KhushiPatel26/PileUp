// import 'package:flutter/material.dart';
// import '../DB/models.dart';
//
// class SearchResultsPage extends StatelessWidget {
//   final List<PSContact> searchResults;
//
//   SearchResultsPage({required this.searchResults});
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pop(context);
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Search Results'),
//         ),
//         body: ListView.builder(
//           itemCount: searchResults.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(searchResults[index].fname),
//               subtitle: Text(searchResults[index].phnnum),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../DB/ApiService3.dart';
import '../DB/models.dart';
import '../project/addproj.dart';
import 'contview.dart'; // Make sure to import your models

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textController = TextEditingController();
  List<PSContact> searchResults = []; // List to store search results
  List<PSContact> pcont = [];
  List<PSContact> displayedContacts = [];
  ApiService3 api = ApiService3();
  List<String> lname = [];
  List<String> lphnnum = [];
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    uid = user?.uid;
    _fetchData();
    print("uid:" + uid!);
  }

  Future<void> _fetchData() async {
    final data = await api.readRecords('pscontact');
    setState(() {
      pcont = data.map((json) => PSContact.fromJson(json)).where((element) => element.uid == uid).toList();
    });
    print('pcont: $pcont');
    for (int i = 0; i < pcont.length; i++) {
      lname.add(pcont[i].fname);
      lphnnum.add(pcont[i].phnnum);
    }
    // Set displayedContacts to all contacts initially
    displayedContacts = List.from(pcont);
  }
  void filterContacts() {
    String searchText = textController.text.toLowerCase();

    setState(() {
      searchResults = pcont.where((contact) {
        bool match = contact.fname.toLowerCase().contains(searchText) || contact.phnnum.contains(searchText);
        return match;
      }).toList();
      print('Searching for: $searchText');
      print('Search results: $searchResults');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Search contacts...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              filterContacts();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchResults[index].fname,style: TextStyle(color: Colors.black)),
            subtitle: Text(searchResults[index].phnnum,style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => contview(contact: searchResults[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}