import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pup/startingpgs/welcome.dart';
import '../DB/ApiService3.dart';
import '../DB/models.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  late User? user;
  late String? uid;
  // Map<String, dynamic>? userData;
  //late Userstb userData;
  // List<Userstb> items = [];
  // List<Userstb> login = [];
  List<Userstb> _profile = [];
  //final ApiService_Userstb apiService = ApiService_Userstb();

  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = _auth.currentUser;
    uid = user!.uid;
    print("uid:" + uid!);
    //fetchUserData();
    _fetchData();
    // fetchPostsById(uid);
  }

  ApiService3 api = ApiService3();
  Future<void> _fetchData() async {
    final data = await api.readRecords('users');
    setState(() {
      _profile = data
          .map((json) => Userstb.fromJson(json))
          .where((element) => element.uid == uid)
          .toList(); //data.where((user) => user.uid==uid).toList();
    });
    print("PROFILE..........");
    print(_profile[0].uid.toString() + " " + _profile[0].name);
  }
  // Future<void> fetchUserData() async {
  //   final response = await http.get(Uri.parse('http://$ip:3000/user?email=${user?.email}'));
  //
  //   if (response.statusCode == 200) {
  //     setState(() {
  //
  //       Iterable list = json.decode(response.body);
  //       // items = list
  //       //     .map((model) => Userstb.fromJson(model)) // Add a null check here
  //       //     .where((user) => user != null) // Filter out null users
  //       //     .toList();
  //       // print(items[0].name);
  //       login=list
  //           .map((model) => Userstb.fromJson(model)) // Add a null check here
  //           .where((user) => user.uid == uid) // Filter out null users
  //           .toList();
  //     });
  //
  //     // final Map<String, dynamic> userDataJson = json.decode(response.body);
  //     // setState(() {
  //     //   userData = Userstb.fromJson(userDataJson);
  //     // });
  //   } else {
  //     throw Exception('Failed to load user data'+response.statusCode.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _profile.length == 0
          ? Center(child: CircularProgressIndicator())
          :
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     CircleAvatar(
          //       backgroundColor: Colors.white,
          //       child: Image.asset("lib/assets/profile.png"),
          //       radius: 20,
          //     ),
          //     Text(_profile[0].name,style: TextStyle(color: Colors.black),),
          //     Text(_profile[0].userType,style: TextStyle(color: Colors.black),),
          //     Text(_profile[0].phoneNumber,style: TextStyle(color: Colors.black),),
          //     Text(user?.email ?? 'N/A',style: TextStyle(color: Colors.black),),
          //     Text(user?.uid ?? 'N/A',style: TextStyle(color: Colors.black),),
          //     ElevatedButton(onPressed: ()async {
          //       try {
          //         await FirebaseAuth.instance.signOut();
          //         // Navigate to the sign-in screen after successful sign-out
          //         Navigator.of(context).pushReplacement(
          //           MaterialPageRoute(builder: (context) => welcome()),
          //         );
          //       } catch (e) {
          //         print('Error signing out: $e');
          //         // Handle sign-out error
          //       }
          //     },
          //         child:Padding(
          //           padding: const EdgeInsets.only(top: 8.0, bottom: 10.0, left: 8.0, right: 8.0),
          //           child: Text("Log Out",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 18),),
          //         ),
          //         style: ElevatedButton.styleFrom(
          //           //primary: Colors.black,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(30)),
          //           elevation: 4.0,
          //         )
          //     )
          //   ],
          // ),
          SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    //child: Image.asset('lib//assets//profile.png'),
                    child: Icon(Icons.person),
                    radius: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "${_profile[0].name}",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: Container(
                  //     child: Row(
                  //       children: [
                  //         CircleAvatar(
                  //           //child: Image.asset('lib//assets//profile.png'),
                  //           child: Icon(Icons.person),
                  //           radius: 40,
                  //         ),
                  //         SizedBox(
                  //           width: 20,
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "${_profile[0].name}",
                  //               style: const TextStyle(
                  //                   fontSize: 20,
                  //                   color: Colors.black,
                  //                   fontWeight: FontWeight.w500),
                  //             ),
                  //
                  //             SizedBox(
                  //               height: 10,
                  //             ),
                  //             Row(
                  //               children: [
                  //                 // GestureDetector(
                  //                 //   onTap: () {
                  //                 //     // nextScreenReplace(context, EditProfile());
                  //                 //   },
                  //                 //   child: Container(
                  //                 //
                  //                 //     height: 30,
                  //                 //     width: 100,
                  //                 //     decoration: BoxDecoration(
                  //                 //       color: Color(0xFF4EDB86),
                  //                 //       borderRadius: BorderRadius.all(
                  //                 //           Radius.circular(10)),
                  //                 //     ),
                  //                 //     child: Center(
                  //                 //       child: Text(
                  //                 //         "Edit Profile",
                  //                 //         style: TextStyle(color: Colors.white),
                  //                 //       ),
                  //                 //     ),
                  //                 //   ),
                  //                 // ),
                  //                 // SizedBox(
                  //                 //   width: 20,
                  //                 // ),
                  //                 GestureDetector(
                  //                   onTap: () {
                  //                     // sp.userSignOut();
                  //                     // nextScreen(context, const LoginScreen());
                  //                   },
                  //                   child: Container(
                  //                     height: 30,
                  //                     width: 100,
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.red,
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(10)),
                  //                     ),
                  //                     child: Center(
                  //                       child: Text(
                  //                         "Sign Out",
                  //                         style: TextStyle(color: Colors.white),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding:
                  //   const EdgeInsets.only(left: 30, right: 30, top: 10),
                  //   child: Wrap(
                  //
                  //     children: [Text("${_profile[0].userType}",style: TextStyle(color: Colors.black),)],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.account_circle_outlined,
                                    color: Colors.black),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Account",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "E-mail",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Text('${_profile[0].email}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone number",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Text("${_profile[0].phoneNumber}",
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Update Profile",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                //Text(">",style: TextStyle(color: Colors.black,)),
                                Icon(Icons.edit_note_rounded,color: Colors.black,)
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "User Guide",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.chrome_reader_mode,
                                      color: Colors.black,
                                      size: 20,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Rate this App",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.star,
                                      color: Colors.black,
                                      size: 20,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "FeedBack",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      color: Colors.black,
                                      Icons.feed,
                                      size: 20,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Terms & Condition",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.receipt_long,
                                      color: Colors.black,
                                      size: 20,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Privacy",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      color: Colors.black,
                                      Icons.privacy_tip_outlined,
                                      size: 20,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await FirebaseAuth.instance.signOut();
                                    // Navigate to the sign-in screen after successful sign-out
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => welcome()),
                                    );
                                  } catch (e) {
                                    print('Error signing out: $e');
                                    // Handle sign-out error
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 10.0,
                                      left: 8.0,
                                      right: 8.0),
                                  child: Text(
                                    "Log Out",
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
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 65,
                  // ),
                ],
              ),
            ),
    );
  }
}
