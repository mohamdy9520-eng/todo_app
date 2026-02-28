import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/core/app_constant.dart';
import '../../../core/widgets/task_item.dart';
import '../models/task_models.dart';

class TasksListview extends StatefulWidget {
  const TasksListview({super.key});

  @override
  State<TasksListview> createState() => _TasksListviewState();
}

class _TasksListviewState extends State<TasksListview> {

  @override
  void initState() {
    allTasks=Hive.box<TaskModels>(AppConstant.taskbox).values.toList();
    super.initState();
  }
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
            background:Container(
              width: double.infinity,
              color: Colors.green,
              alignment: Alignment.centerLeft,
              child: Text("Complete", style:TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold
              ),),
            ),
            secondaryBackground: Container(
              width: double.infinity,
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Text("Delete", style:TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold
              ),),
            ),
            onDismissed:(value){
              if (value==DismissDirection.startToEnd){
                var task=Hive.box<TaskModels>(AppConstant.taskbox).getAt(index);
                task?.statusText=("Completed");
                Hive.box<TaskModels>(AppConstant.taskbox).putAt(index, task!);
                setState(() {
                  allTasks=Hive.box<TaskModels>(AppConstant.taskbox).values.toList();
                });
              }else{
                Hive.box<TaskModels>(AppConstant.taskbox).deleteAt(index);
                setState(() {
                  allTasks=Hive.box<TaskModels>(AppConstant.taskbox).values.toList();
                });

              }
            },
            key: UniqueKey(),
            child: TaskItem(
              taskModels: allTasks[index],
            ));
      }, separatorBuilder: (context,index)=>SizedBox(height: 10.h,), itemCount: allTasks.length),
    );
  }
}
