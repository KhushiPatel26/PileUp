import 'package:flutter/material.dart';

import 'notes.dart';

class addnote extends StatefulWidget {
  const addnote({Key? key}) : super(key: key);

  @override
  State<addnote> createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  TextEditingController title=TextEditingController();
  TextEditingController hinttxt=TextEditingController();
  TextEditingController tag=TextEditingController();
  bool isPinned=false;
  TextEditingController notepwController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: Text(''),
        leading: IconButton(onPressed: () async {

          SnackBar(
              content: Text('note saved'));
          Navigator.push(
            context,

            MaterialPageRoute(builder: (context) => const notes()),
          );
        },
          icon: Icon(Icons.arrow_back),),
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.undo, color: Colors.white24,),),
          IconButton(onPressed: (){}, icon: Icon(Icons.redo, color: Colors.white24,),),
          IconButton(onPressed: (){
            setState(() {
              isPinned=!isPinned;
            });
          }, icon: isPinned?Icon(Icons.push_pin):Icon(Icons.push_pin_outlined),),
          IconButton(onPressed: (){
            showModalBottomSheet(

                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Column(

                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          tileColor: Colors.grey[800],
                          leading: new Icon(Icons.lock, color: Colors.white,),
                          title: new Text('Note Lock', style: TextStyle(color: Colors.white),),
                          onTap: () async {
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
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(top: 10.0, left: 20, bottom: 10),
                                              child: Text(
                                                'Set a Note-Lock',
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
                                              const EdgeInsets.only( left: 0, bottom: 5),
                                              child: Text(
                                                'Secure Your Note',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF101213),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ),
                                            Image.asset("lib/assets/share_code.png",width: 130,height: 120,),
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
                                                  controller: notepwController,
                                                  autofocus: true,
                                                  autofillHints: [AutofillHints.email],
                                                  obscureText: false,
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
                                                  ),
                                                  style: TextStyle(
                                                    fontFamily: 'Plus Jakarta Sans',
                                                    color: Color(0xFF101213),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  keyboardType: TextInputType.text

                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: ElevatedButton(onPressed: (){

                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(backgroundColor: Colors.white,content: Text('Note-Lock is Set',style: TextStyle(color: Colors.black),)));

                                                }, child:Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 5.0,
                                                      bottom: 5.0,
                                                      left: 3.0,
                                                      right: 3.0),
                                                  child: Text(
                                                    "Set Password",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.black,
                                                    //primary: Colors.black,
                                                    shape: RoundedRectangleBorder(
                                                        side: BorderSide(color: Colors.black),
                                                        borderRadius:
                                                        BorderRadius.circular(30)),
                                                    elevation: 0.0,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ],
                    ),
                  );
                });
          }, icon: Icon(Icons.more_vert),),
        ],
        backgroundColor: Colors.grey[900],
        shadowColor: Colors.transparent,

      ),
      body:
      SingleChildScrollView(
        child: Center(

          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:0,right: 250),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Select Tags",style: TextStyle(fontSize: 12),),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 0.5)
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: TextField(
                  controller: title,
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold,),
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  cursorColor: Colors.white,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(fontSize: 30.0, color: Colors.white30),
                  ),
                ),
              ),

              Container(
                color: Colors.grey[900],
                //height:500,
                child:Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: hinttxt,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: Colors.white,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Type something....",
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.white30),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
margin: EdgeInsets.all(7),
        child: Row(
          children: [
            IconButton(onPressed: (){
              showModalBottomSheet(

                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(

                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            tileColor: Colors.grey[800],
                            leading: new Icon(Icons.check_box_outlined, color: Colors.white,),
                            title: new Text('Checkboxes', style: TextStyle(color: Colors.white),),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  });
            }, icon: Icon(Icons.add_box_outlined, color: Colors.white,),),
            IconButton(onPressed: (){}, icon: Icon(Icons.text_format, color: Colors.white,),),
            IconButton(onPressed: (){}, icon: Icon(Icons.palette_outlined, color: Colors.white,),),
            SizedBox(width: 150),
            IconButton(onPressed: (){
              showModalBottomSheet(

                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(

                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            tileColor: Colors.grey[800],
                            leading: new Icon(Icons.delete_outline, color: Colors.white,),
                            title: new Text('Delete', style: TextStyle(color: Colors.white),),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            tileColor: Colors.grey[800],
                            leading: new Icon(Icons.copy, color: Colors.white,),
                            title: new Text('Make a copy', style: TextStyle(color: Colors.white),),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            tileColor: Colors.grey[800],
                            leading: new Icon(Icons.share, color: Colors.white,),
                            title: new Text('Share', style: TextStyle(color: Colors.white),),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            tileColor: Colors.grey[800],
                            leading: new Icon(Icons.label_outline, color: Colors.white,),
                            title: new Text('Label', style: TextStyle(color: Colors.white),),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  });
            }, icon: Icon(Icons.more_vert, color: Colors.white,),),
          ],
        ),
decoration: BoxDecoration(
  color: Colors.black.withOpacity(0.4),
borderRadius: BorderRadius.circular(10)
),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
