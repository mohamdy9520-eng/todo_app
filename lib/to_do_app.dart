import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
        home:Splash() ,
      ),

    );

  }
}
