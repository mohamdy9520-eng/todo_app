import 'dart:ui';

import 'package:flutter/material.dart' show Colors;
import 'package:hive/hive.dart';
part 'task_models.g.dart';
@HiveType(typeId:3)

class TaskModels {
  @HiveField(0)
  String title;
  @HiveField(6)
  String startTime;
  @HiveField(2)
  String endTime;
  @HiveField(3)
  String description;
  @HiveField(4)
  String statusText;
  @HiveField(5)
  int color;

  TaskModels({required this.title,required this.startTime,required this.endTime,required this.description,
     required this.statusText,required this.color});


}
List<TaskModels>allTasks=[




];
