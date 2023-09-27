import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';

import 'contview.dart';
class contacts extends StatefulWidget {
  const contacts({Key? key}) : super(key: key);

  @override
  State<contacts> createState() => _contactsState();
}

class _contactsState extends State<contacts> {
  List<Contact>? _contacts;
  @override
  void initState() {
    super.initState();
    fetchContacts();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sort contacts alphabetically by displayName
    _contacts?.sort((a, b) {
      return (a.displayName ?? '').toLowerCase().compareTo((b.displayName ?? '').toLowerCase());
    });
    final _random = Random();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body:
      _contacts != null
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
            padding: const EdgeInsets.only(left: 15,right: 15,top: 8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => contview( contact:contact,)));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: CupertinoColors.systemGrey2.withOpacity(0.2),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    child: Text(contact.displayName[0]),//Icon(Icons.person),
                    // Text(documentSnapshot['p_first'].toString().toUpperCase()[0]),
                    backgroundColor: Colors.primaries[_random.nextInt(Colors.primaries.length)]
                    [_random.nextInt(9) * 100],
                    foregroundColor: Colors.primaries[_random.nextInt(Colors.primaries.length)]
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