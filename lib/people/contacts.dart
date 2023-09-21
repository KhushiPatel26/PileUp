import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class contacts extends StatefulWidget {
  const contacts({Key? key}) : super(key: key);

  @override
  State<contacts> createState() => _contactsState();
}

class _contactsState extends State<contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Contacts",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: double.infinity,
        child: FutureBuilder(
          future: getContacts(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == null) {
              print(snapshot.data);
              return const Center(
                child: SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator(),),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
             Contact contact =snapshot.data[index];
             print(contact);
             return ListTile(
               leading: CircleAvatar(
                 radius: 20,
                 child: Icon(Icons.person),
               ),
               title: Text(contact.displayName,style: TextStyle(color: Colors.black),),
               subtitle: Column(
                 children: [
                   Text(contact.phones[0] as String,style: TextStyle(color: Colors.black),),
                   Text(contact.emails[0] as String,style: TextStyle(color: Colors.black),),
                 //  Text(contact.phones[0].toString()),
                 ],
               ),
             );
            }
            );
          }
        ),
      ),
    );
  }

  Future<List<Contact>> getContacts() async{
    bool isGranted = await Permission.contacts.status.isGranted;
    if(!isGranted){
isGranted = await Permission.contacts.request().isGranted;
    }
    // if(isGranted){
      print(FastContacts.getAllContacts());
      return await FastContacts.getAllContacts();
    // }
    // return [];
  }
}
