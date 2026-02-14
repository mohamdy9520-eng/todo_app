import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/widgets/custom_app_buttom.dart';
import 'package:todo_app/features/add_task/add_task_screen.dart';

class AddTaskRow extends StatelessWidget {
  const AddTaskRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat.MMMEd().format(DateTime.now()).toString(),
            style: TextStyle(fontWeight:FontWeight.bold,
            fontSize: 20.sp)),

          ],
        )),
        SizedBox(
          width:160.w ,
            child: CustomAppButtom(title: "+ Add Task",
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:(co)=>AddTaskScreen()
              )
              );
            },))
      ],
    );
  }
}
