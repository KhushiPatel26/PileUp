import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'ApiService3.dart';

class perform_crud3 extends StatefulWidget {
  const perform_crud3({Key? key}) : super(key: key);

  @override
  State<perform_crud3> createState() => _perform_crud3State();
}

class _perform_crud3State extends State<perform_crud3> {
  ApiService3 api = ApiService3();
  TextEditingController taskNameController=TextEditingController();
  List<TaskModel> tasks=[];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await api.readRecords('example3');
    setState(() {
      tasks = data.map((json) => TaskModel.fromJson(json)).toList();
    });
  }

  Future<void> _addTask(String taskName) async {
    final record = TaskModel(tname: taskName);
    await api.createRecord('example3', record.toJson());
    _fetchData();
    taskNameController.clear();
  }

  Future<void> _deleteTask(int tid) async {
    await api.deleteRecord('example3', 'tid=$tid');
    _fetchData();
  }

  // Future<void> _update_Task(Map<String,dynamic> data, String condition) async {
  //   await api.updateRecord('example3', data, condition);
  //   _fetchData();
  // }

  Future<void> _updateTask(TaskModel task) async {
    final condition = 'tid=${task.tid}';
    await api.updateRecord('example3', task.toJson(), condition);
    _fetchData();
  }

  // Future<void> _toggleTaskCompletion(TaskModel task) async {
  //   task.isCompleted = !task.isCompleted;
  //   _updateTask(task);
  // }
  //
  // Future<void> _incrementSubtask(TaskModel task) async {
  //   task.subtask++;
  //   _updateTask(task);
  // }
  //
  // Future<void> _decrementSubtask(TaskModel task) async {
  //   if (task.subtask > 0) {
  //     task.subtask--;
  //     _updateTask(task);
  //   }
  // }

  Future<void> _showUpdateDialog(TaskModel task) async {
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
                task.tname=_updateNameController.text;
                _updateTask(task);
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
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter task name',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: (){
                    //insert code
                    _addTask(taskNameController.text);
                  } ,
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Dismissible(
                  key: Key(task.tid.toString()),
                  onDismissed: (direction) {
                    //delete code
                    _deleteTask(task.tid!.toInt());
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text(
                          task.tname,
                          style: TextStyle(
                            decoration: task.isCompleted=='true'
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        subtitle: Text('Subtasks: ${task.subtask}'),
                        value: task.isCompleted=='false'?false:true,
                        onChanged: (value) {
                         //update isCompleted true
                          task.isCompleted = task.isCompleted=='false'?'true':'false';
                          _updateTask(task);
                        },
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            //update task name
                            _showUpdateDialog(task);
                          },
                          icon: Icon(Icons.edit),
                          ),
                          IconButton(onPressed: (){
                            //update subtask by adding one
                            task.subtask++;
                            _updateTask(task);
                          },
                            icon: Icon(Icons.add),
                          ),
                          IconButton(onPressed: (){
                            //update subtask by subtracting one
                            if (task.subtask > 0) {
                              task.subtask--;
                              _updateTask(task);
                            }
                          },
                            icon: Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



//
class TaskModel {
  int? tid;
  String tname;
  String isCompleted;
  int subtask;

  TaskModel({this.tid, required this.tname, this.isCompleted = 'false', this.subtask = 0});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      tid: json['tid'],
      tname: json['tname'],
      isCompleted: json['isCompleted'], // SQLite stores bool as 0 or 1
      subtask: json['subtask'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tid': tid,
      'tname': tname,
      'isCompleted': isCompleted,
      'subtask': subtask,
    };
  }
}
