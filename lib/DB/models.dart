class ToDoTask {
  final int usId;
  final int taskId;
  final String taskName;
  String? taskDesc;
  final DateTime startDate;
  final DateTime dueDate;
  String? priority;
  final String remind;
  final String status;
  final String category;
  String? labels;
  final String createDate;

  ToDoTask(
      {
    required this.usId,
    required this.taskId,
    required this.taskName,
    this.taskDesc,
    required this.startDate,
    required this.dueDate,
    this.priority,
    required this.remind,
    required this.status,
    required this.category,
    this.labels,
    required this.createDate,
  });

  factory ToDoTask.fromJson(Map<String, dynamic> json){
    return ToDoTask(
        usId: json['usid'],
        taskId: json['taskId'],
        taskName: json['taskName'],
        startDate: json['startDate'],
        dueDate: json['dueDate'],
        remind: json['remind'],
        status: json['status'],
        category: json['category'],
        createDate: json['createDate']
    );
  }
}