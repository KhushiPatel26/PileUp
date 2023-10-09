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
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'mystuff/note/SignaturePadPage.dart';
import 'mystuff/note/notes.dart';
import 'mystuff/note/quill.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
void _showNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: null,
  );

  tz.initializeTimeZones(); // Initialize timezones
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata')); // Replace with your timezone

  // Set the desired time (in this example, it's set to 10:00 AM)
  var scheduledTime = tz.TZDateTime(
    tz.local,
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    3, // Hours (24-hour format)
    15,  // Minutes
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'New Notification',
    'This is a notification triggered by a button click',
    scheduledTime,
    platformChannelSpecifics,
    payload: 'item x',
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
  );
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
            return homepg(gotoIndex: 0,);
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

