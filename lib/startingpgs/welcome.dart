import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pup/startingpgs/login/signin.dart';
import 'package:pup/startingpgs/signup/signup.dart';
import 'package:pup/startingpgs/signup/sup1.dart';


class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  List<String> title = ['Team Work', 'Keep Target', 'Discuss', 'Communicate'];
  List<String> descp = ['Team Work', 'Keep Target', 'Discuss', 'Communicate'];
  List<String> img = [
    'lib/assets/teamwork.png',
    'lib/assets/keeptarget.png',
    'lib/assets/discuss.png',
    'lib/assets/communicate.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: 560,
              color: Colors.white,
              child: CarouselSlider.builder(
                itemCount: img.length,
                itemBuilder: (BuildContext context, int index, int _) {
                  return InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                            height: 150,
                            width: 300,
                            child: Image.asset(img[index])),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            title[index],
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 280,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
              )),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: SizedBox(
              height: 250,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:28.0,left: 28.0),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text('Welcome to PileUp',
                        style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:18.0,left: 28.0),
                      child: Text('Manage projects with Teamwork and start working together.',
                      style: TextStyle(fontSize: 13,color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:18.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF71D3D3),
                          foregroundColor: Colors.black,//Theme.of(context).colorScheme.tertiary,
                          shadowColor: Colors.white38,//Theme.of(context).colorScheme.tertiary,
                          minimumSize: Size(300, 50),
                          // padding: EdgeInsets.only(top: 7.0),
                        ),
                        //style: raisedButtonStyle,
                        onPressed: ()  {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>sup1()));//Navigator.pushNamed(context, 'signuppg');
                        },
                        child: Text('Create an account'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,//Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,//Theme.of(context).colorScheme.tertiary,
                          shadowColor: Colors.white38,//Theme.of(context).colorScheme.tertiary,
                          minimumSize: Size(300, 50),
                          // padding: EdgeInsets.only(top: 7.0),
                        ),
                        //style: raisedButtonStyle,
                        onPressed: ()  {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>signin()));
                          //MongoDatabase.insert({"fname":tf_fname.text,"lname":tf_lname.text,"phone":tf_phone.text,"email":tf_email.text,"password":tf_pw.text});
                          //print('data stored');
                        },
                        child: Text('Log in'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
