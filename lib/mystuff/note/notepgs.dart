import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pup/mystuff/note/addnote.dart';
import 'package:pup/mystuff/note/viewnote.dart';

import '../../DB/ApiService3.dart';
import '../../DB/models.dart';

class notepgs extends StatefulWidget {
  final Notebook nb;
  const notepgs({Key? key, required this.nb}) : super(key: key);

  @override
  State<notepgs> createState() => _notepgsState();
}

class _notepgsState extends State<notepgs> {
  bool listView=false;

  String? uid;
  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    uid = user?.uid;
    print("uid:" + uid!);
    _fetchData();
  }
  ApiService3 api = ApiService3();
  List<NotebookPage> nbpg=[];
  Future<void> _fetchData() async {
    final data = await api.readRecords('NotebookPage');
    setState(() {
      nbpg = data.map((json) => NotebookPage.fromJson(json)).where((element) => element.nbid==widget.nb.nbid).toList();
      print(nbpg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //black.withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () async {
            SnackBar(content: Text('note saved'));
            Navigator.pop(
              context,
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.nb.nbname,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              listView=!listView;
            });
          }, icon: Icon(listView?Icons.filter_list:Icons.grid_view_rounded,color: Colors.black,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.black,)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: listView?
              Container(
                height: 670,
                child: ListView.builder(
                    itemCount: nbpg.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              //print(data[index]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) => viewnote(nbpgid: nbpg[index])));
                            },
                            title: Text(nbpg[index].pgtitle!),
                            //subtitle: Text('Notes.......'),
                          ),
                        ),
                      );
                    }),
              ) : Container(
                    child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 8.0,
                ),
                itemCount: nbpg.length,
                itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => viewnote(nbpgid: nbpg[index])));
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.8),
                        child: Column(
                          children: [
                            Text(nbpg[index].pgtitle!),
                            //Text(nbpg[index].pgcontent!),
                          ],
                        ),
                      ),
                    );
                },
              ),
                  ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => addnote(fromnb:true, nbid: widget.nb.nbid,)));
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
