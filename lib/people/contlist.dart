// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/material.dart';
//
// class contlist extends StatefulWidget {
//   const contlist({Key? key}) : super(key: key);
//
//   @override
//   State<contlist> createState() => _contlistState();
// }
//
// class _contlistState extends State<contlist> {
//   List<Contact> contacts=[];
//
//   @override
//   void initState(){
//     super.initState();
//     getAllContacts();
//   }
//
//   getAllContacts() async{
//     List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
//     setState(() {
//       contacts=_contacts;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("Contacts Retrive",style: TextStyle(color: Colors.black),),
//         backgroundColor: Colors.white,
//       ),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//              ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: contacts.length,
//                   itemBuilder: (context,index){
//                     Contact contact=contacts[index];
//                     return ListTile(
//                       title: Text(contact.displayName.toString()),
//                       subtitle: Text(contact.phones!.elementAt(0).value.toString()),
//                     );
//                   },
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
