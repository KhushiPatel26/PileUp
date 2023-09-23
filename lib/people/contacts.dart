import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

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

          return ListTile(
            leading: CircleAvatar(
              radius: 20,
              child: Icon(Icons.person),
            ),
            title: Text(
              contact.displayName ?? 'Unknown',
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Column(
              children: [
                Text(
                  contact.phones[0].number,
                  style: TextStyle(color: Colors.black),
                ),
              ],
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