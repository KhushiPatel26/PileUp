import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pup/DB/perform_crud2.dart';
import 'package:pup/DB/perform_crud.dart';
import 'package:pup/DB/perform_curd3.dart';
import 'package:pup/mystuff/note/addnote.dart';
import 'package:pup/startingpgs/welcome.dart';
import 'package:pup/themes/dark_theme.dart';
import 'package:pup/themes/light_theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'calendar/cal3.dart';
import 'firebase_options.dart';
import 'homepg.dart';
import 'package:firebase_core/firebase_core.dart';

import 'mystuff/note/SignaturePadPage.dart';
import 'mystuff/note/quill.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  var initializationSettingsAndroid = AndroidInitializationSettings('codex_logo');
  // var initializationSettingsIOS = IOSInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //     onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);//, iOS: initializationSettingsIOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,  onSelectNotification: (String? payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: ' + payload);
  //   }
  // }); bol 3rd otp
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    darkTheme: darkTheme,
    home: AuthenticationWrapper(),//SignaturePadPage(),//perform_crud3(),//AuthenticationWrapper(),//signin(),//signin(),//homepg()//Homepage(),//projv()//SplashScreenPage(),////MyLogin(),//reg(),
    /*routes: {
      'welcome':(context)=>welcome(),
      'signup': (context) => signup(),
      'signuppg':(context) => signuppg(),
      'verify':(context)=> verify(),
      'seloption':(context)=>seloption(),
      'getcomp':(context)=>getcomp(),
      'incomp':(context)=>incomp(),
      'signin': (context) => signin(),
      'homepg': (context) => homepg(),
      'stepper': (context) => stepper(),
      'screenprogress':(context)=> ScreenProgress(ticks: 7),
      'navigationbar':(context)=>EntryPoint(),
    },*/
  ));
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            // User not logged in
            return welcome();
          } else {
            // User logged in
            return homepg();
          }
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}