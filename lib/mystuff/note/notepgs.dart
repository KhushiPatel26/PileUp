import 'package:flutter/material.dart';
import 'package:pup/mystuff/note/addnote.dart';

class notepgs extends StatefulWidget {
  const notepgs({Key? key}) : super(key: key);

  @override
  State<notepgs> createState() => _notepgsState();
}

class _notepgsState extends State<notepgs> {
  bool listView=false;
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
          'NoteBook Name',
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              //print(data[index]);
                            },
                            title: Text(index.toString()+" Page Name"),
                            subtitle: Text('Notes.......'),
                          ),
                        ),
                      );
                    }),
              ) : Container(
                    child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 8.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blueGrey,
                      child: Column(
                        children: [
                          Text("Page: $index"),
                          Text("Page Description...."),
                        ],
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
                  builder: (context) => addnote(fromnb:true, )));
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
