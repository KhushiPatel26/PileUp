import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pup/startingpgs/signup/signup.dart';
import 'package:pup/startingpgs/signup/sup3.dart';

class sup2 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String phoneNum;
  final String password;

  const sup2({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.phoneNum, required this.password,
  }) : super(key: key);
  @override
  State<sup2> createState() => _sup2State();
}

class _sup2State extends State<sup2> {
  int cntr=2;
  TextEditingController pinCodeController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            // FocusScopeNode currentFocus = FocusScope.of(context);
            //
            // if (!currentFocus.hasPrimaryFocus) {
            //   currentFocus.unfocus();
            // }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 10, 12, 5),
                    child:  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text(
                                  'Enter OTP below',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Text(
                                'Confirm your Code',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF101213),
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(44, 8, 44, 0),
                                child: Text(
                                  'This code helps keep your account safe and secure.',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                                child: PinCodeTextField(
                                  // autoDisposeControllers: false,
                                  appContext: context,
                                  length: 6,
                                  textStyle:
                                  TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  enableActiveFill: false,
                                  autoFocus: true,
                                  enablePinAutofill: true,
                                  errorTextSpace: 0,
                                  showCursor: true,
                                  cursorColor: Color(0xFF212121),
                                  obscureText: false,
                                  hintCharacter: '-',
                                  keyboardType: TextInputType.number,
                                  pinTheme: PinTheme(
                                    fieldHeight: 50,
                                    fieldWidth: 50,
                                    borderWidth: 3,
                                    borderRadius: BorderRadius.circular(12),
                                    shape: PinCodeFieldShape.box,
                                    activeColor: Colors.black,
                                    inactiveColor: Color(0xFFF1F4F8),
                                    selectedColor: Color(0xFF57636C),
                                    activeFillColor: Colors.black,
                                    inactiveFillColor: Color(0xFFF1F4F8),
                                    selectedFillColor: Color(0xFF57636C),
                                  ),
                                  controller: pinCodeController,
                                  onChanged: (_) {},
                                  autovalidateMode: AutovalidateMode.onUserInteraction,

                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:380.0,right: 10,left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: true,//cntr==1? false:true,
                                child: ElevatedButton(onPressed: (){
                                  setState(() {
                                    cntr-=1;
                                    print(cntr);
                                  });
                                  Navigator.of(context).pop();
                                },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0, bottom: 10.0, left: 8.0, right: 8.0),
                                      child: Text("Back",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      //primary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)),
                                      elevation: 4.0,
                                    )
                                ),
                              ),
                              ElevatedButton(onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => sup3(firstName: widget.firstName, lastName: widget.lastName, emailAddress:widget.emailAddress, phoneNum: widget.phoneNum, password: widget.password,)),
                                );
                                setState(() {

                                  cntr+=1;
                                  print(cntr);
                                });

                              }, child: Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 10.0, left: 8.0, right: 8.0),
                                child: Text("Next",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),),
                              ),
                                  style: ElevatedButton.styleFrom(
                                    //primary: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)),
                                    elevation: 4.0,
                                  )
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 90,left: 90),
                  child: Row(
                    children: [
                      Icon(cntr>=2?Icons.check_circle:Icons.circle_outlined,
                        color: Colors.green,size: 18,),
                      Expanded(
                        child: new Container(
                            margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                            child: Divider(
                              color: cntr>=2?Colors.green:Colors.lightGreenAccent,
                              height: 50,
                            )),
                      ),
                      Icon(cntr>=3?Icons.check_circle:Icons.circle_outlined,
                        color: cntr>=2?Colors.green:Colors.lightGreenAccent,size: 18,),
                      Expanded(
                        child: new Container(
                            margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                            child: Divider(
                              color: cntr>=3?Colors.green:Colors.lightGreenAccent,
                              height: 50,
                            )),
                      ),
                      Icon(cntr>=4?Icons.check_circle:Icons.circle_outlined,
                        color: cntr>=3?Colors.green:Colors.lightGreenAccent,size: 18,
                      ),
                      Expanded(
                        child: new Container(
                            margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                            child: Divider(
                              color: cntr>=4?Colors.green:Colors.lightGreenAccent,
                              height: 50,
                            )),
                      ),
                      Icon(cntr>=5?Icons.check_circle:Icons.circle_outlined,
                        color: cntr>=4?Colors.green:Colors.lightGreenAccent,size: 18,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
      //body: Text("page2 \n Verification"),

  }
}
