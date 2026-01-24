import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/features/home/home_screen.dart';

class Splash  extends StatefulWidget {
  const Splash ({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    Future.delayed(Duration(seconds: 6),(){
      Navigator.push(context, MaterialPageRoute(builder:(context)=>HomeScreen()));
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/splash_image.json"),
            Text("Taskati",style: TextStyle(fontSize: 50.sp,
            fontWeight: FontWeight.bold),),
            Text("it's time to get Organized",style: TextStyle(
            fontSize: 30),)
          ],

        ),
      ),
    );
  }
}
