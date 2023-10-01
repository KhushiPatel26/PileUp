//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'ApiService2.dart';

class perform_crud extends StatefulWidget {
  const perform_crud({Key? key}) : super(key: key);

  @override
  State<perform_crud> createState() => _perform_crudState();
}

class Ex3 {
  int? id;
  String tname;
  int subtask;

  Ex3({this.id, required this.tname, required this.subtask});

  factory Ex3.fromJson(Map<String, dynamic> json) {
    return Ex3(
      id: json['id'],
      tname: json['tname'],
      subtask: json['subtask']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tname': tname,
      'subtask': subtask
    };
  }
}

class ApiServiceEx3 extends ApiService2<Ex3> {
  @override
  Ex3 dataFromJson(Map<String, dynamic> json) {
    return Ex3.fromJson(json);
  }
}

class _perform_crudState extends State<perform_crud> {
  TextEditingController _tnameController = TextEditingController();
  TextEditingController _sbtController = TextEditingController();
  List<Ex3> _dataList = [];
  final ApiServiceEx3 apiService = ApiServiceEx3();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await apiService.readRecords('ex3');
    setState(() {
      _dataList = data;
    });
  }

  bool _isLoading = false;

  Future<void> _createRecord(String name, int subt) async {
    setState(() {
      _isLoading = true;
    });

    final record = Ex3(tname: 'name', subtask: subt);
    //final data = {'name': name};
    final response = await apiService.createRecord('ex3', record);
    _fetchData();
    // if (response != null && response['message'] is String) {
    //   final recordId = int.tryParse(response['message']!);
    //   if (recordId != null) {
    //     // Update the record with the obtained ID
    //     record.id = recordId;
    //
    //     await apiService.updateRecord('ex3', record.id!, record);
    //
    //
    //     setState(() {
    //       _isLoading = false;
    //     });
    //
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Record created successfully')),
    //     );
    //     return;
    //   }
    // }

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error creating record')),
    );
  }


  Future<void> _deleteRecord(int? id) async {
    await apiService.deleteRecord('ex3', id!);
    _fetchData();
  }

  Future<void> _updateRecord(int id, String newName, int sbt) async {
    await apiService.updateRecord('ex3', 'id=$id', 'id=$id',Ex3(id: id, tname: newName, subtask: sbt));
    _fetchData();
  }

  Future<void> _showUpdateDialog(int? id, int index, int num) async {
    TextEditingController _updateNameController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Name'),
          content: TextField(
            controller: _updateNameController,
            decoration: InputDecoration(labelText: 'Enter updated name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                _updateRecord(id!, _updateNameController.text, _dataList[index].subtask+num);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
bool isCompleted=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('SQLite CRUD Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tnameController,
              decoration: InputDecoration(labelText: 'Enter Task'),
            ),
            TextField(
              controller: _sbtController,
              decoration: InputDecoration(labelText: 'subtask num'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                _createRecord(_tnameController.text, int.parse(_sbtController.text));
                _tnameController.clear();
                _sbtController.clear();
              },
              child: _isLoading ? CircularProgressIndicator() : Text('Add Name'),
            ),
            SizedBox(height: 20.0),
            LinearPercentIndicator(
              //width: visible ? 220 : 276,
                animation: true,
                animationDuration: 100,
                lineHeight: 3.0,
                percent: 123/sumofsubtask(),
                //center: Text("20.0%"),
                linearStrokeCap: LinearStrokeCap.butt,
                progressColor: Colors.blueGrey,
                backgroundColor: Colors.black54 //Colors.red,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _dataList.length,
                itemBuilder: (context, index) {
                  final record = _dataList[index];
                  return Padding(
                  padding: const EdgeInsets.only(
                  right: 20.0, left: 20, top: 10),
                  child: Dismissible(

                    // Specify the direction to swipe and delete
                    direction: DismissDirection.endToStart,
                    key: Key(record.toString()),
                    onDismissed: (direction) {
                      // Removes that item the list on swipwe
                      setState(() {
                        _dataList.removeAt(index);
                        print(_dataList);
                      });
                      // Shows the information on Snackbar
                      //howSnackBar(SnackBar(content: Text("$item dismissed")));
                    },
                    background: Container(color: Colors.red, child: Text("Delete"),),
                    child: Container(
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border(right: BorderSide(color: Colors.red, width: 1))
                    ),
                    child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                    children: [
                    Checkbox(
                    value: isCompleted=='true'?true:false,
                    onChanged: (bool? value) {

                    String isdone = value! ? 'true' : 'false';
                    //updateCompleted(subtask[i].stId, isdone);
                    _updateRecord(record.id!, record.tname, record.subtask-1);
                    print(isdone);


                    },
                    //     (bool? value) {
                    //   setState(() {
                    //     checked[0] = value!;lll
                    //   });
                    // },
                    //splashRadius: 210.0,
                    activeColor: Colors
                        .black, // Color when checkbox is checked
                    checkColor: Colors
                        .white, // Color of the checkmark
                    materialTapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Remove extra padding
                    visualDensity: VisualDensity.compact,
                    side: BorderSide(
                    color: Colors
                        .black), // Reduce the checkbox size
                    shape: CircleBorder(),
                    ),
                    Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                    Row(
                    children: [
                    Text(record.tname,
                    style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    decoration: isCompleted == 'true'
                    ? TextDecoration
                        .lineThrough
                        : TextDecoration.none,
                    ),
                    ),
                    ],
                    ),
                    Text(
                    record.subtask.toString(),
                    style: TextStyle(
                    color: Colors.black
                        .withOpacity(0.6),
                    fontWeight: FontWeight.w300),
                    )
                    ],
                    ),
                    ),
                    ],
                    ),
                    )),
                  ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int sumofsubtask(){
    int sumst=0;
    for(int i=0;i<_dataList.length;i++){
      sumst+=_dataList[i].subtask;
    }
    print(sumst);
    return sumst;
  }

}
