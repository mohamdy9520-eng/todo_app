import 'dart:ui';

import 'package:flutter/material.dart' show Colors;

class TaskModels {
  String title;
  String startTime;
  String endTime;
  String description;
  String statusText;
  Color color;

  TaskModels({required this.title,required this.startTime,required this.endTime,required this.description,
     required this.statusText,required this.color});


}
List<TaskModels>allTasks=[
  TaskModels(title: "Task 1", startTime:"02:55 PM", endTime: "11:00 PM", description: "i will finish Tomorrow", statusText: "TODO", color:Colors.indigo),
  TaskModels(title: "Task 2", startTime:"09:00 AM", endTime: "05:00 PM", description: "Must Finish Today", statusText: "TODO", color:Colors.orange),
  TaskModels(title: "Task 3", startTime:"08:00 PM", endTime: "6:00 AM", description: "i will finish Tomorrow", statusText: "TODO", color:Colors.green)


];
