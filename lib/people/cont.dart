// import 'package:anim_search_bar/anim_search_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:pup/people/addcont.dart';
// import 'package:pup/people/searchresult.dart';
// import 'dart:math';
// import '../DB/ApiService3.dart';
// import '../DB/models.dart';
// import '../home/profile.dart';
// import 'contacts.dart';
// import 'contview.dart';
//
// class cont extends StatefulWidget {
//   const cont({Key? key}) : super(key: key);
//
//   @override
//   State<cont> createState() => _contState();
// }
//
// class _contState extends State<cont> {
//   TextEditingController textController = TextEditingController();
//   String? uid;
//
//   @override
//   void initState() {
//     super.initState();
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final User? user = _auth.currentUser;
//     uid = user?.uid;
//     _fetchData();
//     print("uid:" + uid!);
//   }
//
//   List<String> lname = [];
//   List<String> lphnnum = [];
//   ApiService3 api = ApiService3();
//   List<PSContact> pcont = [];
//   List<PSContact> displayedContacts = [];
//
//   Future<void> _fetchData() async {
//     final data = await api.readRecords('pscontact');
//     setState(() {
//       pcont = data.map((json) => PSContact.fromJson(json)).where((element) => element.uid == uid).toList();
//     });
//     print('pcont: $pcont');
//     for (int i = 0; i < pcont.length; i++) {
//       lname.add(pcont[i].fname);
//       lphnnum.add(pcont[i].phnnum);
//     }
//     // Set displayedContacts to all contacts initially
//     displayedContacts = List.from(pcont);
//   }
//
//   void filterContacts() {
//     String searchText = textController.text.toLowerCase();
//     print('Searching for: $searchText');
//
//     List<PSContact> searchResults = pcont.where((contact) {
//       bool match = contact.fname.toLowerCase().contains(searchText) ||
//           contact.phnnum.contains(searchText);
//       print('Contact: ${contact.fname}, Match: $match');
//       return match;
//     }).toList();
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SearchResultsPage(searchResults: searchResults),
//       ),
//     );
//   }
//
//
//   final _random = Random();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => profile()));
//             },
//             child: CircleAvatar(
//               child: Image.asset(
//                 'lib/assets/profile.png',
//                 height: 30,
//                 width: 30,
//               ),
//               backgroundColor: Colors.white,
//             ),
//           ),
//         ),
//         title: Text(
//           'Contacts',
//           style: TextStyle(color: Colors.black),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 3.0),
//             child: IconButton(
//               icon: Icon(
//                 Icons.add,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => addcont()));
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: IconButton(
//               icon: Icon(
//                 Icons.more_vert,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => contacts()));
//               },
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: AnimSearchBar(
//                 width: 400,
//                 color: Colors.white70,
//                 textController: textController,
//                 onSuffixTap: () {
//                   setState(() {
//                     textController.clear();
//                     displayedContacts = List.from(pcont);
//                   });
//                 },
//                 onSubmitted: (String) {
//                   filterContacts();
//                 },
//               ),
//             ),
//             textController.text.isEmpty
//                 ? pcont != []
//                 ? SingleChildScrollView(
//               child: Column(
//                 children: [
//                   for (int index = 0; index < displayedContacts.length; index++)
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15, right: 15, top: 8.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => contview(
//                                     contact: displayedContacts[index],
//                                   )));
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             color: CupertinoColors.systemGrey2.withOpacity(0.2),
//                           ),
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               radius: 20,
//                               child: Text(displayedContacts[index].fname[0]),
//                               backgroundColor: Colors.primaries[
//                               _random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 100],
//                               foregroundColor: Colors.primaries[
//                               _random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 200],
//                             ),
//                             title: Text(
//                               displayedContacts[index].fname,
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             subtitle: Text(
//                               displayedContacts[index].phnnum,
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             )
//                 : Center(
//               child: CircularProgressIndicator(),
//             )
//                 : Center(
//               child: Text(
//                 'No contacts found.',
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pup/people/addcont.dart';
// Import the new SearchPage
import 'package:pup/people/searchresult.dart';
import 'dart:math';
import '../DB/ApiService3.dart';
import '../DB/models.dart';
import '../home/profile.dart';
import 'contacts.dart';
import 'contview.dart';

class cont extends StatefulWidget {
  const cont({Key? key}) : super(key: key);

  @override
  State<cont> createState() => _contState();
}

class _contState extends State<cont> {
  String? uid;

  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    uid = user?.uid;
    _fetchData();
    print("uid:" + uid!);
  }

  List<String> lname = [];
  List<String> lphnnum = [];
  ApiService3 api = ApiService3();
  List<PSContact> pcont = [];
  List<PSContact> displayedContacts = [];

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

  final _random = Random();

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
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => profile()));
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
        title: Text(
          'Contacts',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => addcont()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => contacts()));
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            pcont != null && pcont.isNotEmpty
                ? Column(
              children: [
                for (int index = 0; index < displayedContacts.length; index++)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => contview(
                              contact: displayedContacts[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: CupertinoColors.systemGrey2.withOpacity(0.2),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            child: Text(displayedContacts[index].fname[0]),
                            backgroundColor: Colors.primaries[
                            _random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 100],
                            foregroundColor: Colors.primaries[
                            _random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 200],
                          ),
                          title: Text(
                            displayedContacts[index].fname,
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(
                            displayedContacts[index].phnnum,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            )
                : Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}