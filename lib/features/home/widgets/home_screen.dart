import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/core/app_constant.dart';
import 'package:todo_app/core/widgets/add_task_row.dart';
import 'package:todo_app/core/widgets/task_item.dart';
import 'package:todo_app/features/auth/models/user_model.dart';
import 'package:todo_app/features/filter.dart';
import 'package:todo_app/features/home/models/task_models.dart';
import 'package:todo_app/features/home/widgets/tasks_listView.dart';

import '../../add_task/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex=0;
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning!";
    } else if (hour < 18) {
      return "Good Evening!";
    } else {
      return "Good Evening!";
    }
  }

  @override
  Widget build(BuildContext context) {
    var userData =
    Hive.box<UserModel>(AppConstant.userBox).getAt(0);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 20.h),

              if (userData != null) ...[
                Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData.name,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${getGreeting()}  ${userData.name}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12.w),

                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage:
                      userData.image.isNotEmpty
                          ? FileImage(File(userData.image))
                          : null,
                      child: userData.image.isEmpty
                          ? Icon(Icons.person, size: 30.r)
                          : null,
                    ),
                  ],
                ),
              ],

              SizedBox(height: 30.h),
              AddTaskRow(
                onPressed: ()async{
                  await Navigator.push(context, MaterialPageRoute(builder:(co)=>AddTaskScreen(),
                    ),
                  );
                   setState(() {

                   });
                },
              ),
              SizedBox(height: 20.h,),
              Row(
                children: [
                  Expanded(child: FilterButton(title: "All", isActive:activeIndex==0,
                  onTap: (){
                    setState(() {
                      allTasks=Hive.box<TaskModels>(AppConstant.taskbox).values.toList();
                      activeIndex=0;
                    });
                  })),
                  SizedBox(width: 10.w),
                  Expanded(child: FilterButton(title: "ToDo", isActive:activeIndex==1,
                  onTap: (){
                    setState(() {
                      allTasks=Hive.box<TaskModels>(AppConstant.taskbox).values.toList().where((e)=>e.statusText.toLowerCase()=="todo").toList();

                      activeIndex=1;
                    });
                  },)),
                  SizedBox(width: 10.w),
                  Expanded(child: FilterButton(title: "Completed", isActive:activeIndex==2,
                  onTap: (){
                    setState(() {
                      allTasks=Hive.box<TaskModels>(AppConstant.taskbox).values.toList().where((e)=>e.statusText.toLowerCase()=="completed").toList();
                      activeIndex=2;
                    });
                  },)),
                ],
              ),
              SizedBox(height: 20.h,),
              TasksListview()

            ],
          ),
        ),
      ),
    );
  }
}


