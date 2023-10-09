import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:pup/socialmedia.dart';

import '../DB/models.dart';

class contview extends StatefulWidget {
final PSContact contact;
  const contview({required this.contact});

  @override
  State<contview> createState() => _contviewState();
}

class _contviewState extends State<contview> {
  
  Future<void> _delete() async {
    

    ScaffoldMessenger.of(context).showSnackBar (const SnackBar(
        content: Text('contact deleted')));
  }
  final _random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            _delete();
            Navigator.pop(context);
          }, icon: Icon(Icons.delete),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
              CircleAvatar(
                child: Text(widget.contact.fname.toString().toUpperCase()[0],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                radius: 40,
                backgroundColor: Colors.primaries[_random.nextInt(Colors.primaries.length)]
                [_random.nextInt(9) * 100],
                foregroundColor: Colors.primaries[_random.nextInt(Colors.primaries.length)]
                [_random.nextInt(9) * 100],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70.0),
              child: Row(
                children: [
                  Text(widget.contact.fname.split(' ')[0]+' ', style: TextStyle(
                    fontSize: 30, color: Colors.black
                  ),),
                  Text(' '+widget.contact.fname.split(' ')[1], style: TextStyle(
                    fontSize: 30, color: Colors.black
                  ),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(widget.contact.phnnum, style: TextStyle(
                  color: Colors.grey
              ),),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(2.0),
            //   child: Text(widget.contact.phones.toString(), style: TextStyle(
            //     color: Colors.grey,
            //   ),),
            // ),
            Padding(
              padding: const EdgeInsets.only(top:23.0, left: 75),
              child: Row(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      socialmedia.mail(widget.contact.email.toString());
                      //Uri.parse('whatsapp://send?phone=9773884079');
                    },
                    backgroundColor: Colors.red[900],
                    child: const Icon(
                      Icons.mail_outline_sharp, color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () async {
                      socialmedia.phn(widget.contact.phnnum.toString());
                      // Uri.parse("tel://9773884079");
                    },
                    child: const Icon(
                        Icons.call, color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      socialmedia.whatsapp(widget.contact.phnnum.toString());
                      //Uri.parse('whatsapp://send?phone=9773884079');
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(
                        FontAwesomeIcons.whatsapp, color: Colors.white,
                    ),
                  )
                ],
              ),
            ),



            // Padding(
            //   padding: const EdgeInsets.only(top:25.0, left: 100),
            //   child: Row(
            //     children: [
            //
            //       Column(
            //         children: <Widget>[
            //           Icon(
            //             Icons.business,
            //             color: Colors.black12,
            //             size: 46.0,
            //           ),
            //           Text(widget.docID['c_name'], style: TextStyle(
            //             fontSize: 15,
            //           ),),
            //
            //         ],
            //       ),
            //       const SizedBox(
            //         width: 50,
            //       ),
            //       Column(
            //         children: <Widget>[
            //           Text('Department', style: TextStyle(
            //               fontSize: 15, color: Colors.grey
            //           ),),
            //           Padding(
            //             padding: const EdgeInsets.only(top:20.0,left: 8.0),
            //             child: Text(widget.docID['p_dept'], style: TextStyle(
            //               fontSize: 15,
            //             ),),
            //           ),
            //
            //         ],
            //       )
            //
            //     ],
            //   ),
            // ),



    ]),
    ),
        );

      /*floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () async {
                 socialmedia.phn(widget.docID['p_phnnum'].toString());
                  // Uri.parse("tel://9773884079");
                },
                child: const Icon(
                    Icons.call
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  socialmedia.mail(widget.docID['p_email'].toString());
                  //Uri.parse('whatsapp://send?phone=9773884079');
                },
                backgroundColor: Colors.red[900],
                child: const Icon(
                    Icons.mail_outline_sharp,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  socialmedia.whatsapp(widget.docID['p_phnnum'].toString());
                  //Uri.parse('whatsapp://send?phone=9773884079');
                },
                backgroundColor: Colors.green,
                child: const Icon(
                  Icons.whatsapp,
                ),
              )
            ]
        ),*/


  }
}
