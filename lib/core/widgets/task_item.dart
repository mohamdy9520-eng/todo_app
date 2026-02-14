import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/features/home/models/task_models.dart';

class TaskItem extends StatelessWidget {
  final TaskModels taskModels;
  const TaskItem({super.key, required this.taskModels});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: taskModels.color,
      ),
      child: Row(
        children: [
          Expanded(child: Column(
            spacing: 10.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(taskModels.title, style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),),
            Text("${taskModels.startTime}  / ${taskModels.endTime}", style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white
            ),),
            Text(taskModels.description, style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white
              ),),



          ],)),
          Container(
            color: Colors.white,
            width: 1.w,
            height: 100.h,
          ),
          SizedBox(width: 10.w,),
          RotatedBox(
            quarterTurns: 3,
            child: Text(taskModels.statusText,style:TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ) ,),
          )

        ],
      ),
    );
  }
}
