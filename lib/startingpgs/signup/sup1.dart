import 'package:flutter/material.dart';
import 'package:pup/startingpgs/signup/signup.dart';
import 'package:pup/startingpgs/signup/sup2.dart';


class sup1 extends StatefulWidget {
  const sup1({Key? key}) : super(key: key);

  @override
  State<sup1> createState() => _sup1State();
}

TextEditingController firstNameController=TextEditingController();
TextEditingController lastNameController=TextEditingController();
TextEditingController emailAddressController = TextEditingController();
TextEditingController phoneNumController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController passwordConfirmController = TextEditingController();

class _sup1State extends State<sup1> {
  bool passwordVisibility=false;
  bool passwordConfirmVisibility=false;

  @override
  Widget build(BuildContext context) {
    int cntr=1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        top: true,
        child: SingleChildScrollView(
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
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(12, 10, 0, 8),
                            child: Text(
                              'Create an account',
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
                            EdgeInsetsDirectional.fromSTEB(12, 0, 0, 40),
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
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment:
                                    AlignmentDirectional(-1.00, -1.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 16),
                                      child: Container(
                                        width: 155,
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
                                          controller: firstNameController,
                                          autofocus: true,
                                          autofillHints: [
                                            AutofillHints.namePrefix
                                          ],
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'First Name',
                                            labelStyle: TextStyle(
                                              fontFamily:
                                              'Plus Jakarta Sans',
                                              color: Color(0xFF57636C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFF1F4F8),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(50),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(50),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFFF5963),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(50),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFFF5963),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(50),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFF1F4F8),
                                          ),
                                          style: TextStyle(
                                            fontFamily:
                                            'Plus Jakarta Sans',
                                            color: Color(0xFF101213),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          keyboardType:
                                          TextInputType.emailAddress,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment:
                                    AlignmentDirectional(-1.00, -1.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 16),
                                      child: Container(
                                        width: 155,
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
                                          controller:
                                          lastNameController,
                                          autofocus: true,
                                          autofillHints: [
                                            AutofillHints.nameSuffix
                                          ],
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Last Name',
                                            labelStyle: TextStyle(
                                              fontFamily:
                                              'Plus Jakarta Sans',
                                              color: Color(0xFF57636C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFF1F4F8),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(50),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(50),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFFF5963),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(50),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFFF5963),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(50),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFF1F4F8),
                                          ),
                                          style: TextStyle(
                                            fontFamily:
                                            'Plus Jakarta Sans',
                                            color: Color(0xFF101213),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          keyboardType:
                                          TextInputType.emailAddress,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 10, 16),
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
                                controller: emailAddressController,
                                autofocus: true,
                                autofillHints: [AutofillHints.email],
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Email',
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
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 10, 16),
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
                                controller: phoneNumController,
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
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 10, 16),
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
                                controller: passwordController,
                                autofocus: true,
                                autofillHints: [AutofillHints.password],
                                obscureText: !passwordVisibility,
                                decoration: InputDecoration(
                                  labelText: 'Password',
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
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                          () => passwordVisibility =
                                      !passwordVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xFF57636C),
                                      size: 24,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF101213),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),

                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 10, 16),
                            child: Container(
                              width: 370,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xffd5720f), Color(0xFF57636C)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                             // stops: [0.6, 0.8],
                              tileMode: TileMode.mirror,
                            ),
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 0.5,
                                    offset: Offset(0, 7),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: passwordConfirmController,
                                autofocus: true,
                                autofillHints: [AutofillHints.password],
                                obscureText:
                                !passwordConfirmVisibility,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
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
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF1F4F8),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                          () => passwordConfirmVisibility =
                                      !passwordConfirmVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      passwordConfirmVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xFF57636C),
                                      size: 24,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF101213),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                minLines: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:45.0,right: 15,left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: cntr==1? false:true,
                                  child: ElevatedButton(onPressed: (){
                                    setState(() {
                                      cntr-=1;
                                      print(cntr);
                                    });
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
                                    MaterialPageRoute(builder: (context) => sup2(firstName: firstNameController.text, lastName: lastNameController.text, emailAddress:emailAddressController.text, phoneNum: phoneNumController.text, password: passwordController.text,)),
                                  );
                                  setState(() {

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
      ),
    );
    // body: Container(height: 300,
    //     child: Text("page1 \n user info")),

  }
}
