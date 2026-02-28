import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/features/update_profile/update_profile_screen.dart';
import 'features/splash/splash.dart';

class ToDoApp  extends StatelessWidget {
  const ToDoApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const  Size(375, 812),
      minTextAdapt:true ,
      splitScreenMode: true,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
        home:Splash() ,
      ),

    );

  }
}
