import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/features/splash/widgets/splash.dart';

class ToDoApp  extends StatelessWidget {
  const ToDoApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt:true ,
      splitScreenMode: true,
      child: MaterialApp(
        home:Splash() ,
      ),

    );

  }
}
