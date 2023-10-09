import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pup/helper/pupicon.dart';
import 'package:pup/homepg.dart';

import '../../DB/ApiService3.dart';
import '../../DB/models.dart';

class sup4c extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String phoneNum;
  final String password;
  final String userType;


  const sup4c({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.phoneNum,
    required this.password,
    required this.userType,

  }) : super(key: key);

  @override
  State<sup4c> createState() => _sup4cState();
}

class _sup4cState extends State<sup4c> {
  bool popup=false;

  TextEditingController name=TextEditingController();
  TextEditingController desc=TextEditingController();
  TextEditingController phn=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController addr=TextEditingController();
  TextEditingController website=TextEditingController();
  String code='';
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
        userType: '${widget.userType}2',
        uid: _uid
    );
    await api.createRecord('Users', record.toJson());
    print("Ussers row done");

    final record2 = Company(
      companyCode: code,
      companyName: name.text,
      companyEmail:email.text,
      companyNumber: phn.text,
      companyDescription: desc.text,
      companyAddress: addr.text,
      companyWebsite: website.text
    );
    await api.createRecord('Companies', record2.toJson());
    print("Companies done");

    final record3 = Comp_Mem(
        uid: _uid, companyCode: code,
        isHead: 'true'
    );
    await api.createRecord('Comp_Mem', record3.toJson());
    print("Comp_Mem row done");
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
                'Register a Company',
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
                'Let\'s get started by filling out the form below.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Color(0xFF57636C),
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            CircleAvatar(
              child: Text("Logo",style: TextStyle(fontWeight: FontWeight.w200, letterSpacing: 3),),
              radius: 45,
              backgroundColor: Colors.grey.withOpacity(0.1),
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
                 controller: name,
                  autofocus: true,
                  autofillHints: [AutofillHints.email],
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Company Name',
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
                  controller: desc,
                  autofocus: true,
                  autofillHints: [AutofillHints.email],
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Company Description',
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
                  controller:addr,
                  autofocus: true,
                  autofillHints: [AutofillHints.email],
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Address / Location',
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
                  controller: email,
                  autofocus: true,
                  autofillHints: [AutofillHints.email],
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
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
                  controller: phn,
                  autofocus: true,
                  autofillHints: [AutofillHints.email],
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
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
                  controller: website,
                  autofocus: true,
                  autofillHints: [AutofillHints.email],
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Website',
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
                  Visibility(
                    visible: !popup,
                    child: Padding(
                      padding: const EdgeInsets.only(left:122.0),
                      child: ElevatedButton(
                          onPressed: ()async {
                            print(popup);
                            setState(() {
                              code=generateJoiningCode(8);
                              popup=!popup;
                            });
                            await showDialog<void>(
                                context: context,
                                builder: (context) => Container(
                                  height: 600,
                                  width: 720,
                                  child: AlertDialog(
                                    backgroundColor: Colors.white,

                                    content: Stack(
                                      clipBehavior: Clip.none,
                                      children: <Widget>[
                                        Positioned(
                                          left: -40,
                                          top: -40,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.black,
                                              child: Icon(Icons.close),
                                            ),
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(top: 10.0, left: 20, bottom: 10),
                                                child: Text(
                                                  'Company Registered Successfully ! 🎉',
                                                  style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF101213),
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.only( left: 15, bottom: 5),
                                                child: Text(
                                                  'Invite your Team Members',
                                                  style: TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF101213),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                              Image.asset("lib/assets/share_code.png"),
                                              Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Container(
                                                      width: 440,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black.withOpacity(0.1),
                                                          borderRadius: BorderRadius.all(Radius.circular(30))
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                            child: SelectableText(
                                                              code,
                                                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                                                            ),
                                                          ),
                                                          ElevatedButton(onPressed: (){
                                                            Clipboard.setData(new ClipboardData(text:  code))
                                                                .then((_) {
                                                              // controller.clear();
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(backgroundColor: Colors.black12.withOpacity(0.2),content: Text('Code copied to your clipboard !')));
                                                            });
                                                          }, child:Padding(
                                                            padding: const EdgeInsets.only(
                                                                top: 5.0,
                                                                bottom: 5.0,
                                                                left: 3.0,
                                                                right: 3.0),
                                                            child: Text(
                                                              "Copy Code",
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: Colors.transparent,
                                                              //primary: Colors.black,
                                                              shape: RoundedRectangleBorder(
                                                                  side: BorderSide(color: Colors.black),
                                                                  borderRadius:
                                                                  BorderRadius.circular(30)),
                                                              elevation: 0.0,
                                                            ),
                                                          )
                                                        ],
                                                      ))),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0,
                                                    bottom: 10.0,
                                                    left: 8.0,
                                                    right: 8.0),
                                                child: Text(
                                                  "Invite Members",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 18.0),
                                                child: Row(
                                                  children: [
                                                    IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.whatsapp, color: Colors.green,)),
                                                    IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.telegram, color: Colors.blueAccent,)),
                                                    IconButton(onPressed: (){}, icon: Icon(Icons.email_outlined, color: Colors.redAccent,)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                            popup=true;
                            print(popup);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 10.0, left: 8.0, right: 8.0),
                            child: Text(
                              "Done",
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
                  ),
                  Visibility(
                    visible: popup,
                    child: ElevatedButton(
                        onPressed: () {
                          _insert();
                          print(popup);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => homepg(gotoIndex: 0,)),
                          );

                          setState(() {
                            cntr += 1;
                            print(cntr);
                          });
                        },
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
                  ),
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

  String generateJoiningCode(int length) {
    final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final Random random = Random();
    String result = '';

    for (int i = 0; i < length; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    return result;
  }

}
