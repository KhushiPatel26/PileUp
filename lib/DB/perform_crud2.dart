import 'dart:convert';

import 'package:flutter/material.dart';

import 'ApiService2.dart';

class perform_crud2 extends StatefulWidget {
  const perform_crud2({Key? key}) : super(key: key);

  @override
  State<perform_crud2> createState() => _perform_crud2State();
}

class Ex2 {
  int? nid;
  String name;

  Ex2({this.nid, required this.name});

  factory Ex2.fromJson(Map<String, dynamic> json) {
    return Ex2(
      nid: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': nid,
      'name': name,
    };
  }
}

class ApiServiceEx2 extends ApiService2<Ex2> {
  @override
  Ex2 dataFromJson(Map<String, dynamic> json) {
    return Ex2.fromJson(json);
  }
}

class _perform_crud2State extends State<perform_crud2> {
  TextEditingController _nameController = TextEditingController();
  List<Ex2> _dataList = [];
  final ApiServiceEx2 apiService = ApiServiceEx2();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await apiService.readRecords('ex2');
    setState(() {
      _dataList = data;
    });
  }

  bool _isLoading = false;

  Future<void> _createRecord(String name) async {
    setState(() {
      _isLoading = true;
    });

    final record = Ex2(name: name);
    final data = {'name': name};
    final response = await apiService.createRecord('ex2', record);
    _fetchData();
    // if (response != null && response['message'] is String) {
    //   final recordId = int.tryParse(response['message']!);
    //   if (recordId != null) {
    //     // Update the record with the obtained ID
    //     record.nid = recordId;
    //
    //     await apiService.updateRecord('ex2', record.nid, record);
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
    await apiService.deleteRecord('ex2', id!);
    _fetchData();
  }

  // Future<void> _updateRecord(int id, String newName) async {
  //   await apiService.updateRecord('ex2', id, Ex2(id: id, name: newName));
  //   _fetchData();
  // }

  Future<void> _updateRecord(int id, String newName) async {
    final condition = 'nid=$id'; // Replace with your desired condition
    print('update api call before');
    await apiService.updateRecord('ex2', condition,'nid=$id' ,Ex2(nid: id, name: newName));
    print('update api call');
    _fetchData();
  }

  Future<void> _showUpdateDialog(int id) async {
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
                _updateRecord(id, _updateNameController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Enter Name'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                _createRecord(_nameController.text);
                _nameController.clear();
              },
              child: _isLoading ? CircularProgressIndicator() : Text('Add Name'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _dataList.length,
                itemBuilder: (context, index) {
                  final record = _dataList[index];
                  print(record.nid);
                  return ListTile(
                    title: Text(record.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                       //     _showUpdateDialog(record.nid);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteRecord(record.nid);
                          },
                        ),
                      ],
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
}
