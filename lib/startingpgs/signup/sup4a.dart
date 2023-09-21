import 'package:flutter/material.dart';
import 'package:pup/homepg.dart';


class sup4a extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String phoneNum;

  const sup4a({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.phoneNum,
  }) : super(key: key);

  @override
  State<sup4a> createState() => _sup4aState();
}

class _sup4aState extends State<sup4a> {
  bool stuteach=false;
  bool bus=false;
  bool other=false;
  @override
  void initState() {
    super.initState();
    print('First Name: ${widget.firstName}');
    print('Last Name: ${widget.lastName}');
    print('Email Address: ${widget.emailAddress}');
    print('Phone Number: ${widget.phoneNum}');
    print('Bus: $bus');
    print('Student/Teacher: $stuteach');
    print('Other: $other');
  }
  int cntr=4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 45.0, left: 35, bottom: 20),
                    child: Text(
                      'You are?',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF101213),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
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
                          bus = true;
                          stuteach = false;
                          other = false;});
                      },
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                            color: bus ? Colors.black : Color(0xFFF1F4F8),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: Text(
                            'Business Man/Woman',
                            style: TextStyle(
                                fontSize: 20,
                                color: bus ? Colors.white : Colors.black),
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
                          bus = false;
                          stuteach = true;
                          other = false;
                        });
                      },
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                            color: stuteach ? Colors.black : Color(0xFFF1F4F8),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: Text(
                            'Student/Teacher',
                            style: TextStyle(
                                fontSize: 20,
                                color: stuteach ? Colors.white : Colors.black),
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
                          bus = false;
                          stuteach = false;
                          other = true;
                        });
                      },
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                            color: other ? Colors.black : Color(0xFFF1F4F8),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: Text(
                            'Other',
                            style: TextStyle(
                                fontSize: 20,
                                color: other ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top:330.0,right: 30,left: 30),
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
                        )
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => homepg()),
                    );
                    setState(() {

                    });

                  },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 10.0,
                            left: 8.0,
                            right: 8.0),
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
                      )
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
}
