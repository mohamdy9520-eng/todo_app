import 'package:hive/hive.dart';

part 'task_models.g.dart';

@HiveType(typeId: 3)
class TaskModels extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String startTime;

  @HiveField(2)
  String endTime;

  @HiveField(3)
  String description;

  @HiveField(4)
  String statusText;

  @HiveField(5)
  int color;

  @HiveField(6)
  bool isCompleted;

  TaskModels({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.statusText,
    required this.color,
    this.isCompleted = false,
  });
}