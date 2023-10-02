import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pup/DB/models.dart';
import 'package:pup/mystuff/note/ntbook.dart';
import '../../DB/ApiService3.dart';
import '../../home/profile.dart';
import '../mystuff.dart';
import 'addnote.dart';

class notes extends StatefulWidget {
  const notes({Key? key}) : super(key: key);

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {

  String? uid;
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    uid = user?.uid;
    print("uid:" + uid!);
    _fetchNoteBook();
    _fetchNotes();
  }
  Map<String, List<Note>> _tags = {
    "All": [],
    "Personal": [],
    "Work": []
  };
  ApiService3 api = ApiService3();
  List<Note> notes=[];
  List<Notebook> nb=[];
  int _selectedIndex = 0;
  int _selected = 0;
  Map<String, int> _tags2={'All':0,'Personal':0,'Work':0};
  String category='';
  String label='';
  Future<void> _fetchNotes() async {
    final data = await api.readRecords('notes');
    setState(() {
      notes = data.map((json) => Note.fromJson(json)).where((element) => element.uid==uid.toString()).toList();
      _tags['All']=(data
          .map((model) => Note.fromJson(model)) // Add a null check here
          .where((notes) => notes.uid == uid) // Filter out null users
          .toList());
      _tags2['All']=(_tags2['All']!+_tags['All']!.length)!;
      _tags['Work']=data
          .map((model) => Note.fromJson(model)) // Add a null check here
          .where((notes) => notes.uid == uid && notes.ncategory=='Work') // Filter out null users
          .toList();
      _tags2['Work']=(_tags2['Work']!+_tags['Work']!.length)!;
      _tags['Personal']=data
          .map((model) => Note.fromJson(model)) // Add a null check here
          .where((notes) => notes.uid == uid && notes.ncategory=='Personal') // Filter out null users
          .toList();
      _tags2['Personal']=(_tags2['Personal']!+_tags['Personal']!.length)!;
    });
    print('motes');
    print(notes);
  }
  Future<void> _fetchNoteBook() async {
    final data = await api.readRecords('notebook');
    setState(() {
      nb = data.map((json) => Notebook.fromJson(json)).where((element) => element.uid==uid.toString()).toList();
      _tags2['All']=(_tags2['All']!+data
          .map((model) => Notebook.fromJson(model)) // Add a null check here
          .where((notes) => notes.uid == uid) // Filter out null users
          .toList().length)!;
      _tags2['All']=(_tags2['All']!+_tags['All']!.length)!;
      _tags2['Work']=(_tags2['Work']!+data
          .map((model) => Notebook.fromJson(model)) // Add a null check here
          .where((notes) => notes.uid == uid && notes.nbcategory=='Work') // Filter out null users
          .toList().length)!;
      _tags2['Work']=(_tags2['Work']!+_tags['Work']!.length)!;
      _tags2['Personal']=(_tags2['Personal']!+data
          .map((model) => Notebook.fromJson(model)) // Add a null check here
          .where((notes) => notes.uid == uid && notes.nbcategory=='Personal') // Filter out null users
          .toList().length)!;
      _tags2['Personal']=(_tags2['Personal']!+_tags['Personal']!.length)!;
    });
    print('motebook');
    print(nb);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(top:15.0,right: 20.0,left: 8.0,bottom: 8.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => profile()));
            },
            child: CircleAvatar(
              child: Image.asset(
                'lib/assets/profile.png',
                height: 30,
                width: 30,
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 70.0),
                child: Text(
                  'Hello!',
                  style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.w200, fontSize: 15
                  ),
                ),
              ),
              Text(
                'Khushi Patel',
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.0, right: visible ? 100 : 150, left: 20),
                child: Text("My Notes",style: TextStyle(fontSize: 30,color: Colors.black, fontWeight: FontWeight.bold),),
              ),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: IconButton(onPressed: ()async {
                  await showDialog<void>(
                      context: context,
                      builder: (context) =>
                          Container(
                            height: 600,
                            width: 720,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 80.0),
                                  child: AlertDialog(
                                    shape: CircleBorder(side: BorderSide(color: Colors.black)),
                                    backgroundColor: Colors.white,
                                    content: GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => addnote(fromnb:false)));
                                      },
                                      child: Container(
                                       // height: 200,
                                        //width: 90,
                                        child: Column(
                                          children: [
                                            Image.asset("lib/assets/makeanote.png",width: 70,height: 90,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Make a Note",style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 150.0,left: 90),
                                  child: AlertDialog(
                                    shape: CircleBorder(side: BorderSide(color: Colors.black)),
                                    backgroundColor: Colors.white,
                                    content:  GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ntbook()));
                                      },
                                      child: Container(
                                        // height: 200,
                                        // width: 100,
                                        child: Column(
                                          children: [
                                            Image.asset("lib/assets/makenotebook.png",width: 70,height: 90,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Make a Notebook",style: TextStyle(color: Colors.black,fontSize: 12),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ));
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>addnote()));
                }, icon:Icon(Icons.add, color: Colors.white,size: 15,),),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10),
              child: Row(
                children: [
                  Wrap(
                    spacing: 1,
                    direction: Axis.horizontal,
                    children: choiceChips(_tags2),
                  ),
                ],
              ),
            ),
          ),
          if(nb!=[])
            for(int i =0; i<nb.length;i++)
            Container(
              color: Color(int.parse(nb[i].nbcolor.toString())),
              child: Column(
                children: [
                  Text(nb[i].nbname),
                  Text(nb[i].isimp)
                ],
              ),
            )
        ],
      ),
    );
  }

  List<Widget> choiceChips(_choiceChipsList) {
    List<Widget> chips = [];
    for (int i = 0; i < _tags2.length; i++) {
      Widget item = Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 2),
            child: ChoiceChip(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
              label: Row(
                children: [
                  Text(
                    _tags2.keys.elementAt(i), //_choiceChipsList[],
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 6.0, left: 10, top: 4),
                    child: Container(
                      height: 22,
                      width: 22,
                      child: Center(
                        child: Text(
                          _tags2.values.elementAt(i).toString(),
                          style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.black,
                              fontSize: 10),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: _selectedIndex == i
                              ? Colors.white
                              : Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30)),
                      // backgroundColor: _selectedIndex==i?
                      // Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.5) ,
                      // smallSize: 25,
                    ),
                  ),
                ],
              ),
              labelStyle: const TextStyle(color: Colors.white),
              backgroundColor: Colors.white70,
              selected: _selectedIndex == i,
              selectedColor: Colors.black,
              onSelected: (bool value) {
                setState(() {
                  _selectedIndex = i;
                  category=_tags2.keys.elementAt(i);
                });
                print('category:'+category);
              },
            ),
          ),
          if (_tags[_tags.keys.elementAt(_selectedIndex)]?.length != 0)
            Visibility(
              visible: _selectedIndex == i,
              child: Wrap(
                spacing: 1,
                direction: Axis.horizontal,
                children: child_choiceChips(_tags[_tags.keys.elementAt(_selectedIndex)]!),
              ),
            ),
        ],
      );
      chips.add(item);
    }
    return chips;
  }

  List<Widget> child_choiceChips(List<Note> _choiceChipsList) {
    List<Widget> chips = [];
    for (int i = 0; i < _choiceChipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 5, right: 2),
        child: ChoiceChip(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
          label: Row(
            children: [
              Text(_choiceChipsList[i].nlabel.toString(),
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 6.0, left: 10, top: 4),
              //   child: Container(
              //     height: 22,
              //     width: 22,
              //     child: Center(
              //       child: Text(
              //         '5',
              //         style: TextStyle(
              //             fontFamily: 'Readex Pro',
              //             color: Colors.black,
              //             fontSize: 9),
              //       ),
              //     ),
              //
              //     decoration: BoxDecoration(
              //       color: _selected == i
              //           ? Colors.white
              //           : Colors.black.withOpacity(0.5),
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //     // backgroundColor: _selectedIndex==i?
              //     // Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.5) ,
              //     // smallSize: 25,
              //   ),
              // ),
            ],
          ),
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.white70,
          selected: _selected == i,
          selectedColor: Colors.black,
          onSelected: (bool value) {
            setState(() {
              _selected = i;
              //label=_tags.values[i];
            });
            print('category:'+category);
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
