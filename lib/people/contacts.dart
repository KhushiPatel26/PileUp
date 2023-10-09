import 'package:fast_contacts/fast_contacts.dart%20';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart' as fz;
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';

import '../DB/ApiService3.dart';

import '../DB/models.dart';
import 'contview.dart';

class contacts extends StatefulWidget {
  const contacts({Key? key}) : super(key: key);

  @override
  State<contacts> createState() => _contactsState();
}

class _contactsState extends State<contacts> {
  List<Contact>? _contacts;
  List<PSContact> psc = [];
  ApiService3 api = ApiService3();
List<String> allcont=[];
  Future<void> _insert(List<Contact> _contacts) async {
    _contacts?.sort((a, b) {
      return (a?.displayName ?? '')
          .toLowerCase()
          .compareTo((b.displayName ?? '').toLowerCase());
    });
    //List<String> nameParts = name.split(' ');
    for (int i = 1; i < _contacts.length; i++) {
      if (_contacts != null && _contacts[i].phones.isNotEmpty && !(allcont.contains(_contacts[i].phones[0].number))) {
        print("inserting...");
        final record = PSContact(
          uid: uid.toString(),
          fname: _contacts[i].displayName ?? '',
          // lname:_contacts[i].displayName.split(' ')[1] ?? '',
          phnnum: _contacts[i].phones[0].number,
          //email: _contacts[i].emails[0].toString() ?? '',
          category: 'All',
        );
        await api.createRecord('pscontact', record.toJson());
      }
    }

    print("all inserted done");
  }

  Future<void> _fetchData() async {
    final data = await api.readRecords('pscontact');
    setState(() {
      psc = data
          .map((json) => PSContact.fromJson(json))
          .where((element) => element.uid == uid)
          .toList();
    }); // bolnai bol ha
    print("psc: ${psc[0].fname} ");
    print('\n${psc.length}');
    for(int j=0;j<psc.length;j++){
      allcont.add(psc[j].phnnum);
    }
    print("allcont");
    print(allcont);
  }

  String? uid;
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    uid = user?.uid;
    _fetchData();
    fetchContacts();
    print("uid:" + uid!);
    // fetchPostsById(uid);
  }

  Future<void> fetchContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }

    if (isGranted) {
      List<Contact> contacts = await FastContacts.getAllContacts();
      setState(() {
        _contacts = contacts;
      });
      _insert(_contacts!);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort contacts alphabetically by displayName
    _contacts?.sort((a, b) {
      return (a?.displayName ?? '')
          .toLowerCase()
          .compareTo((b.displayName ?? '').toLowerCase());
    });
    final _random = Random();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: _contacts != null
          ? ListView.builder(
              itemCount: _contacts!.length,
              itemBuilder: (context, index) {
                Contact contact = _contacts![index];

                // Check if there's a phone number
                bool hasPhoneNumber = contact.phones.isNotEmpty;

                // Skip contacts without phone numbers
                if (!hasPhoneNumber) {
                  return SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => contview(
                      //               contact: contact,
                      //             )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CupertinoColors.systemGrey2.withOpacity(0.2),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          child: Text(
                              contact.displayName[0]), //Icon(Icons.person),
                          // Text(documentSnapshot['p_first'].toString().toUpperCase()[0]),
                          backgroundColor: Colors.primaries[
                                  _random.nextInt(Colors.primaries.length)]
                              [_random.nextInt(9) * 100],
                          foregroundColor: Colors.primaries[
                                  _random.nextInt(Colors.primaries.length)]
                              [_random.nextInt(9) * 200],
                        ),
                        title: Text(
                          contact.displayName ?? 'Unknown',
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          contact.phones[0].number,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
