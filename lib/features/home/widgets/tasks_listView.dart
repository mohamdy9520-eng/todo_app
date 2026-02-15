import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../core/widgets/task_item.dart';
import '../models/task_models.dart';

class TasksListview extends StatelessWidget {
  const TasksListview({super.key});

  @override
  Widget build(BuildContext context) {
    return  allTasks.isEmpty? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 50.h,),
        Lottie.asset("assets/Empty.json"),
      ],
    ):Expanded(
      child: ListView.separated(itemBuilder: (context, index){
        return Dismissible(
            background:Icon(Icons.delete),
            secondaryBackground: Icon(Icons.add_a_photo),
            key: UniqueKey(),
            child: TaskItem(
              taskModels: allTasks[index],
            ));
      }, separatorBuilder: (context,index)=>SizedBox(height: 10.h,), itemCount: allTasks.length),
    );
  }
}
