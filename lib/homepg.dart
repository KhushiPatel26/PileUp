import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:pup/home/homeall.dart';

import 'package:pup/mystuff/mystuff.dart';
import 'package:pup/people/contact.dart';
import 'package:pup/people/contactbook.dart';

import 'package:pup/project/projhome.dart';

import 'package:pup/people/contacts.dart';



class homepg extends StatefulWidget {

  const homepg({Key? key}) : super(key: key);

  @override
  State<homepg> createState() => _homepgState();
}

class _homepgState extends State<homepg> {
  int _selectedIndex = 0;
  bool isProf=true;
  // static const TextStyle optionStyle =
  // TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static  List _Professional = [
    homeall(),
    myStuff(),//addtask(),
    projhome(),
    contactBook(),
    contacts()//contlist()//contact()//home(),
    //home(),
    //mystuff(),
    //projects(),
    //calendar(),
    //people(),
  ];
  static const List _Personal = [
    contactBook(),
    myStuff(),//addtask(),
    homeall(),
   // projhome(),
    contact()//home(),
    //home(),
    //mystuff(),
    //projects(),
    //calendar(),
    //people(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          Container(
            color: Colors.transparent,
            child: isProf?_Professional.elementAt(_selectedIndex):_Personal.elementAt(_selectedIndex),
          ),
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 10.0),
                child: Container(

                  //height: 60,
                  //margin: EdgeInsets.only(top: 1),
                  //padding: EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                    //color: Colors.transparent,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFFFFFF).withOpacity(0.7),
                        const Color(0xFFD0CDCD).withOpacity(0.7),
                        const Color(0xFF9F9C9C).withOpacity(0.9),
                      ],
                      //begin: const FractionalOffset(0.0,0.0, 0.0),
                      //end: const FractionalOffset(1.0,0.0, 0.0),
                      stops: [0.0, 1.0,7.0],
                      tileMode: TileMode.mirror,
                    ),
                    //color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withOpacity(.6),

                      )
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 9),
                      child: GNav(
                        backgroundColor: Colors.transparent,
                        //rippleColor: Colors.grey[300]!,
                        //hoverColor: Colors.grey[100]!,
                        gap: 8,
                        //activeColor: Colors.black,
                        iconSize: 24,
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        duration: Duration(milliseconds: 400),
                        //tabBackgroundColor: Colors.grey[100]!,
                        //color: Colors.black,
                        tabs: [
                          GButton(
                            icon: IconData(0xe005, fontFamily: 'pupicon'),//Icons.home_outlined,//IconData(hashCode,fontFamily: 'AppIcon'),
                            text: 'Home',
                            iconColor: Colors.black,//Color(0xFFEA4242),
                            textColor: Colors.white,
                            textStyle: TextStyle(fontWeight: FontWeight.w100),
                            backgroundColor: Colors.black,//.withOpacity(0.5),//red[200],
                            /*backgroundGradient: LinearGradient(
                              colors: [
                               const Color(0xFFE56C6C),
                                const Color(0xFFFFFFFF),

                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.7, 0.0),
                              stops: [0.0, 1.7],
                              tileMode: TileMode.clamp,
                            ),*/
                            //textColor: Colors.redAccent,
                          ),
                          GButton(
                            icon: Icons.note_alt_outlined,
                            text: 'My Stuff',
                            iconColor: Colors.black,//Color(0xFFEA4242),
                            textColor: Colors.white,
                            textStyle: TextStyle(fontWeight: FontWeight.w100),
                            backgroundColor: Colors.black,
                            // iconColor: Color(0xFFFFB700),
                            // textColor: Colors.black,
                            // // backgroundColor: Colors.red[200],
                            // backgroundGradient: LinearGradient(
                            //   colors: [
                            //     const Color(0xFFDEB95D),
                            //     const Color(0xFFFFFFFF),
                            //
                            //   ],
                            //   begin: const FractionalOffset(0.0, 0.0),
                            //   end: const FractionalOffset(1.7, 0.0),
                            //   stops: [0.0, 1.7],
                            //   tileMode: TileMode.clamp,
                            // ),
                            // textColor: Color(0xFFFFB700),
                          ),
                          if(isProf)
                            GButton(
                            icon: Icons.folder_copy_outlined,
                            text: 'Projects',
                            iconColor: Colors.black,//Color(0xFFEA4242),
                            textColor: Colors.white,
                            textStyle: TextStyle(fontWeight: FontWeight.w100),
                            backgroundColor: Colors.black,
                            // backgroundColor: Colors.red[200],
                            // backgroundGradient: LinearGradient(
                            //   colors: [
                            //     const Color(0xFFE88843),
                            //     const Color(0xFFFFFFFF),
                            //
                            //   ],
                            //   begin: const FractionalOffset(0.0, 0.0),
                            //   end: const FractionalOffset(1.7, 0.0),
                            //   stops: [0.0, 1.7],
                            //   tileMode: TileMode.clamp,
                            // ),
                            // textColor: Colors.redAccent,
                          ),
                          GButton(
                            icon: Icons.calendar_month_outlined,
                            text: 'Calendar',
                            iconColor: Colors.black,//Color(0xFFEA4242),
                            textColor: Colors.white,
                            textStyle: TextStyle(fontWeight: FontWeight.w100),
                            backgroundColor: Colors.black,
                            // iconColor: Color(0xFF009DFF),
                            // textColor: Colors.black,
                            // // backgroundColor: Colors.red[200],
                            // backgroundGradient: LinearGradient(
                            //   colors: [
                            //     const Color(0xFF69B4E3),
                            //     const Color(0xFFFFFFFF),
                            //
                            //   ],
                            //   begin: const FractionalOffset(0.0, 0.0),
                            //   end: const FractionalOffset(1.7, 0.0),
                            //   stops: [0.0, 1.7],
                            //   tileMode: TileMode.clamp,
                            // ),
                            //  textColor: Colors.redAccent,
                          ),
                          GButton(
                            icon: IconData(0xe003, fontFamily: 'pupicon'),//Icons.people_outline,
                            text: 'People',
                            iconColor: Colors.black,//Color(0xFFEA4242),
                            textColor: Colors.white,
                            textStyle: TextStyle(fontWeight: FontWeight.w100),
                            backgroundColor: Colors.black,
                            // iconColor: Color(0xFF2DFF00),
                            // // backgroundColor: Colors.red[200],
                            // textColor: Colors.black,
                            // backgroundGradient: LinearGradient(
                            //   colors: [
                            //     const Color(0xFF7CE765),
                            //     const Color(0xFFFFFFFF),
                            //
                            //   ],
                            //   begin: const FractionalOffset(0.0, 0.0),
                            //   end: const FractionalOffset(1.7, 0.0),
                            //   stops: [0.0, 1.7],
                            //   tileMode: TileMode.clamp,
                            // ),
                            // textColor: Colors.redAccent,
                          ),
                        ],
                        selectedIndex: _selectedIndex,
                        onTabChange: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      //bottomNavigationBar:
    );
  }
}
