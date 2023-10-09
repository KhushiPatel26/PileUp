import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pup/home/homeall.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../DB/ip.dart';
import '../../homepg.dart';
import 'package:pup/DB/models.dart';

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  bool passwordVisibility=false;
  TextEditingController emailController= TextEditingController();
  TextEditingController pwController= TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Userstb> _users = [];

  Future<void> _signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Successfully signed in: ${userCredential.user?.uid}');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => homepg(gotoIndex: 0,)));
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in: $e');
    }
  }

  Future<void> fetchItems() async {
    final response = await http.get(Uri.parse('http://$ip:3000/User'));
    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        _users = list.map((model) => Userstb.fromJson(model)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    Future<void> checkCredentials(String email, String password) async {
      final response = await http.post(Uri.parse('http://$ip:3000/check-credentials'),
          body: {'email': email, 'password': password});
      if(email=='' || password==''){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill the details.')),
        );
      }
      else {
        if (response.statusCode == 200) {
          // Successfully authenticated
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => homepg(gotoIndex: 0,)),
          );
        } else if (response.statusCode == 400) {
          // Email not registered or incorrect password
          String errorMessage = response.body;
          if (errorMessage == 'Email not registered') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Email is not registered.')),
            );
          } else if (errorMessage == 'The password is invalid or the user does not have a password') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Incorrect password.')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('An error occurred. $errorMessage')),
            );
          }
        } else if (response.statusCode == 500) {
          // Server error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Server error.')),
          );
        } else {
          // Handle other cases if needed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(
                'An error occurred. Status code: ${response.statusCode}')),
          );
        }
      }
    }

    String? emailError;
    String? passwordError;
    bool validate(BuildContext context){

      emailError = null;

      passwordError = null;

      // if (firstNameController.text.isEmpty) {
      //   fnameError = "Full Name is required";
      //   _showSnackBar(
      //     title: 'Validation Error',
      //     message: fnameError!,
      //     contentType: ContentType.failure,
      //     //backgroundColor: Colors.red.withOpacity(0.5),
      //     context: context,
      //   );
      //   return false;
      // }

      final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      if (emailController.text.isEmpty) {
        emailError = "Email is required";
        _showSnackBar(
          context: context,
          title: 'Validation Error',
          message: emailError!,
          contentType: ContentType.failure,
          //backgroundColor: Colors.red,
        );
        return false;
      } else if (!emailRegex.hasMatch(emailController.text)) {
        emailError = "Invalid Email or Email not registered";
        _showSnackBar(
          context: context,
          title: 'Validation Error',
          message: emailError!,
          contentType: ContentType.failure,
          // backgroundColor: Colors.red,
        );
        return false;
      } else if (emailRegex.hasMatch(emailController.text)) {
        checkCredentials(emailController.text,pwController.text);
      }


      final passwordRegex = RegExp(
          r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+])[A-Za-z0-9!@#$%^&*()_+]{8,}$');
      if (pwController.text.isEmpty) {
        passwordError = "Password is required";
        _showSnackBar(
          context: context,
          title: 'Validation Error',
          message: passwordError!,
          contentType: ContentType.failure,
          // backgroundColor: Colors.red,
        );
        return false;
      } else if (!passwordRegex.hasMatch(pwController.text)) {
        passwordError = "Password is invalid!";
       // "Password must contain at least 8 characters, including 1 uppercase, 1 lowercase, 1 special character, and 1 digit";
        _showSnackBar(
          context: context,
          title: 'Validation Error',
          message: passwordError!,
          contentType: ContentType.failure,
          //  backgroundColor: Colors.red,
        );
        return false;
      }


      return true;
    }

    // Future<void> checkCredentials(String email, String password) async {
    //   // final response = await http.get(
    //   //   Uri.parse('http://$ip:3000/User'),
    //   //   body: jsonDecode({'email': email, 'password': password}),
    //   //   headers: {'Content-Type': 'application/json'},
    //   // );
    //   // final response = await http.get(Uri.parse('http://$ip:3000/User'));
    //
    //   final response = await http.post(
    //     Uri.parse('http://$ip:3000/User'), // Replace with your authentication endpoint
    //     body: {
    //       'email': email,
    //       'password': password,
    //     },
    //   );
    //
    //   if (response.statusCode == 200) {
    //     // Successfully authenticated
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => homepg()),
    //     );
    //   } else if (response.statusCode == 404) {
    //     // Email not registered
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Email is not registered.')),
    //     );
    //   } else if (response.statusCode == 401) {
    //     // Incorrect password
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Incorrect password.')),
    //     );
    //   } else {
    //     // Handle other error cases
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('An error occurred.'+response.statusCode.toString())),
    //     );
    //   }
    // }




    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding:
            EdgeInsetsDirectional.fromSTEB(12, 50, 0, 8),
            child: Text(
              'Login an account',
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
                controller: emailController,
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
                controller: pwController,
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
          ElevatedButton(onPressed: () async {
            //await checkCredentials(emailController.text, pwController.text);
            //if(emailController.text!='' && pwController.text!=''){}
            if(validate(context)) {

              _signInWithEmailAndPassword(
                  emailController.text, pwController.text);
            }


          },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10.0, left: 8.0, right: 8.0),
                child: Text("Sign in",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),),
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
