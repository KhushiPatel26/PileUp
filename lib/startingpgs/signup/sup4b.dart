import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../DB/ApiService3.dart';
import '../../DB/models.dart';
import '../../homepg.dart';

class sup4b extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String phoneNum;
  final String password;
  final String userType;


  const sup4b({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.phoneNum,
    required this.password,
    required this.userType,

  }) : super(key: key);

  @override
  State<sup4b> createState() => _sup4bState();
}

class _sup4bState extends State<sup4b> {
  TextEditingController CompCode=TextEditingController();

  @override
  void initState() {
    super.initState();
    print('First Name: ${widget.firstName}');
    print('Last Name: ${widget.lastName}');
    print('Email Address: ${widget.emailAddress}');
    print('Phone Number: ${widget.phoneNum}');
  }

  int cntr = 4;
  String _uid='';
  ApiService3 api = ApiService3();
  Future<void> _insert() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: widget.emailAddress, password:  widget.password);
    //String _uid= cred.user!.uid;
    setState(() {
      _uid = cred.user?.uid ?? "";
    });
    print("UIDUIDUIUDI:......"+_uid);
    final record = Userstb(
        name: widget.firstName+' '+widget.lastName,
        email: widget.emailAddress,
        phoneNumber: widget.phoneNum,
        password: widget.password,
        userType: widget.userType+'1',
        uid: _uid
    );
    await api.createRecord('Users', record.toJson());
    print("Ussers row done");
    final record2 = Comp_Mem(
        uid: _uid, companyCode: CompCode.text,
      isHead: 'false'
    );
    await api.createRecord('Comp_Mem', record2.toJson());
    print("Comp_Mem row done");
  }

  List<Company> comp=[];
  Future<void> _fetchData() async {
    final data = await api.readRecords('companies');
    setState(() {
      comp = data.map((json) => Company.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
              EdgeInsetsDirectional.fromSTEB(20, 50, 0, 8),
              child: Text(
                'Join Company',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  color: Color(0xFF101213),
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
              EdgeInsetsDirectional.fromSTEB(12, 0, 0, 25),
              child: Text(
                'Enter Company Code below.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF57636C),
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 10),//Directional.fromSTEB(10, 0, 10, 16),
              child: Container(
                width: 370,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(0, 7),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: CompCode,
                  autofocus: true,
                  autofillHints: [AutofillHints.email],
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Company Code',
                    labelStyle: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFF1F4F8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF5963),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF5963),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF1F4F8),
                  ),
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF101213),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 70.0, right: 30, left: 30),
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
                              top: 8.0, bottom: 10.0, left: 8.0, right: 8.0),
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
                      onPressed: () {
                        bool isCodePresent = false;
                         String matchedComp='';
                         _fetchData();
                        for (var map in comp) {
                          print(map);
                          print(CompCode.text);
                          print(map.companyCode.contains(CompCode.text));
                          if (map.companyCode.contains(CompCode.text)) {
                            setState(() {
                              isCodePresent = true;
                              matchedComp=map.companyName;
                            });
                            break;
                          }
                        }
                        if(isCodePresent)
                          {
                            _insert();
                            _showSnackBar(
                              context: context,
                              title: 'Correct code',
                              message: "You have successfully join the Company ${matchedComp}",
                              contentType: ContentType.success,
                              //backgroundColor: Colors.red,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => homepg(gotoIndex: 0,)),
                            );
                            setState(() {
                              cntr += 1;
                              print(cntr);
                            });
                          }
                        else{
                          _showSnackBar(
                            context: context,
                            title: 'Wrong code',
                            message: "No such code/company",
                            contentType: ContentType.failure,
                            //backgroundColor: Colors.red,
                          );
                        }

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 10.0, left: 8.0, right: 8.0),
                        child: Text(
                          "Join",
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
void _showSnackBar({
  required BuildContext context,  // Accept BuildContext as a parameter
  required String title,
  required String message,
  required ContentType contentType,
  //required Color backgroundColor,
}) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    // backgroundColor: backgroundColor,
    elevation: 0,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

