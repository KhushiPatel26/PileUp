import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pup/startingpgs/signup/signup.dart';
import 'package:pup/startingpgs/signup/sup4a.dart';
import 'package:pup/startingpgs/signup/sup4b.dart';
import 'package:pup/startingpgs/signup/sup4c.dart';
import 'package:http/http.dart' as http;

import '../../DB/ip.dart';

class sup3 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String phoneNum;
  final String password;

  const sup3({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.phoneNum,
    required this.password,
  }) : super(key: key);

  @override
  State<sup3> createState() => _sup3State();
}

class _sup3State extends State<sup3> {
  bool per = false;
  bool comp = false;
  bool incomp = false;
  bool getcomp = false;
  String userType = "";

  Future<void> createUser(String name, String email, String phoneNumber,
      String password, String userType) async {
    userType = comp ? "company user" : "personal user";
    final response = await http.post(
      Uri.parse('http://$ip:3000/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'userType': userType,
      }),
    );

    if (response.statusCode == 201) {
      print('User created successfully');
    } else {
      print('Failed to create user. Status code: ${response.statusCode}');
    }
  }

  Future<void> insert() async {
    final url =
        'http://$ip:3000/insert'; // Replace with your Node.js server endpoint

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': widget.firstName + " " + widget.lastName,
          'email': widget.emailAddress,
          'phoneNumber': widget.phoneNum,
          'password': widget.password,
          'userType': userType,
          'profilePicture': "hi",
        },
      );

      if (response.statusCode == 200) {
        print('Data inserted successfully.');
      } else {
        print(
            'Failed to insert data. Error ${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    int cntr = 3;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: <Widget>[
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 45.0, left: 35, bottom: 20),
                    child: Text(
                      'Using for?',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF101213),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                    height: 300,
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  per = true;
                                  comp = false;
                                  getcomp = false;
                                  incomp = false;
                                  print(pages);
                                  if (pages.length >= 4) {
                                    pages.removeLast();
                                    print(pages);
                                  }
                                  //pages.add(sup4c());
                                  print(pages);
                                });
                              },
                              child: Container(
                                width: 280,
                                height: 50,
                                decoration: BoxDecoration(
                                    color:
                                        per ? Colors.black : Color(0xFFF1F4F8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Center(
                                  child: Text(
                                    'For Personal use',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            per ? Colors.white : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  per = false;
                                  comp = true;
                                  getcomp = false;
                                  incomp = false;
                                });
                              },
                              child: Container(
                                width: 280,
                                height: 50,
                                decoration: BoxDecoration(
                                    color:
                                        comp ? Colors.black : Color(0xFFF1F4F8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Center(
                                  child: Text(
                                    'For Company use',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            comp ? Colors.white : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (comp)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    getcomp = false;
                                    incomp = true;

                                    print(pages);
                                    if (pages.length >= 4) {
                                      pages.removeLast();
                                      print(pages);
                                    }
                                    //pages.add(sup4a(firstName: widget.firstName, lastName: widget.lastName, emailAddress:widget.emailAddress, phoneNum: widget.phoneNum));
                                    print(pages);
                                  });
                                },
                                child: Container(
                                  width: 280,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF1F4F8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(
                                      color: incomp
                                          ? Colors.black
                                          : Color(0xFFF1F4F8),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Create ID for a Company',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (comp)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    getcomp = true;
                                    incomp = false;

                                    print(pages);
                                    if (pages.length >= 4) {
                                      pages.removeLast();
                                      print(pages);
                                    }
                                    //pages.add(sup4b());
                                    print(pages);
                                  });
                                },
                                child: Container(
                                  width: 280,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF1F4F8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(
                                      color:
                                          getcomp ? Colors.black : Colors.white,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Get into a Company',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    )),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 240.0, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: cntr == 1 ? false : true,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                cntr -= 1;
                                print(cntr);
                              });
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 10.0,
                                  left: 8.0,
                                  right: 8.0),
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              //primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              elevation: 4.0,
                            )),
                      ),
                      ElevatedButton(
                          onPressed: (per == true ||
                                  (comp == true ||
                                      (getcomp == true || incomp == true)))
                              ? () {
                                  print(userType);
                                  insert();
                                  createUser(
                                      widget.firstName,
                                      widget.emailAddress,
                                      widget.phoneNum,
                                      widget.password,
                                      userType);

                                  if (per == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => sup4a(
                                              firstName: widget.firstName,
                                              lastName: widget.lastName,
                                              emailAddress: widget.emailAddress,
                                              phoneNum: widget.phoneNum)),
                                    );
                                  } else if (getcomp == true && comp == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => sup4b(
                                              firstName: widget.firstName,
                                              lastName: widget.lastName,
                                              emailAddress: widget.emailAddress,
                                              phoneNum: widget.phoneNum)),
                                    );
                                  } else if (incomp == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => sup4c(
                                              firstName: widget.firstName,
                                              lastName: widget.lastName,
                                              emailAddress: widget.emailAddress,
                                              phoneNum: widget.phoneNum)),
                                    );
                                  }

                                  setState(() {
                                    cntr += 1;
                                    print(cntr);
                                  });
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 10.0, left: 8.0, right: 8.0),
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            //primary: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            elevation: 4.0,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 90, left: 90),
              child: Row(
                children: [
                  Icon(
                    cntr >= 2 ? Icons.check_circle : Icons.circle_outlined,
                    color: Colors.green,
                    size: 18,
                  ),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                        child: Divider(
                          color: cntr >= 2
                              ? Colors.green
                              : Colors.lightGreenAccent,
                          height: 50,
                        )),
                  ),
                  Icon(
                    cntr >= 3 ? Icons.check_circle : Icons.circle_outlined,
                    color: cntr >= 2 ? Colors.green : Colors.lightGreenAccent,
                    size: 18,
                  ),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                        child: Divider(
                          color: cntr >= 3
                              ? Colors.green
                              : Colors.lightGreenAccent,
                          height: 50,
                        )),
                  ),
                  Icon(
                    cntr >= 4 ? Icons.check_circle : Icons.circle_outlined,
                    color: cntr >= 3 ? Colors.green : Colors.lightGreenAccent,
                    size: 18,
                  ),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                        child: Divider(
                          color: cntr >= 4
                              ? Colors.green
                              : Colors.lightGreenAccent,
                          height: 50,
                        )),
                  ),
                  Icon(
                    cntr >= 5 ? Icons.check_circle : Icons.circle_outlined,
                    color: cntr >= 4 ? Colors.green : Colors.lightGreenAccent,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
