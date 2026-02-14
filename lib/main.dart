import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/app_constant.dart';
import 'package:todo_app/features/auth/models/user_model.dart';
import 'package:todo_app/to_do_app.dart';
import 'package:hive_flutter/hive_flutter.dart';





void main() async{

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(AppConstant.userBox);

  runApp(ToDoApp());
}
