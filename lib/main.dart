import 'package:flutter/material.dart';
import 'package:pup/home/profile.dart';
import 'package:pup/project/projdet.dart';
import 'package:pup/project/projv.dart';
import 'package:pup/startingpgs/login/signin.dart';
import 'package:pup/startingpgs/signup/signup.dart';
import 'package:pup/startingpgs/signup/sup1.dart';
import 'package:pup/startingpgs/welcome.dart';
import 'package:pup/themes/dark_theme.dart';
import 'package:pup/themes/light_theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';
import 'homepg.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'mystuff/note/addnote.dart';
import 'notes/pages/home_page.dart';
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
  );//number bollllll oyyeee
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: lightTheme,
    darkTheme: darkTheme,
    home: sup1(),//signin(),//homepg()//Homepage(),//projv()//SplashScreenPage(),////MyLogin(),//reg(),
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