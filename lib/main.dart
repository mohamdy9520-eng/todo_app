import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/app_constant.dart';
import 'package:todo_app/features/auth/models/user_model.dart';
import 'package:todo_app/features/home/models/task_models.dart';
import 'package:todo_app/to_do_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter(); // مهم جدًا
  Hive.registerAdapter(UserModelAdapter()); // لو عندك adapter
  Hive.registerAdapter(TaskModelsAdapter()); // لو عندك adapter

  await Hive.openBox<UserModel>(AppConstant.userBox);
  await Hive.openBox<TaskModels>(AppConstant.taskBox);

  runApp(const ToDoApp());
}