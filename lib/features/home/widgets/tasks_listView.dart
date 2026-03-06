import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/core/app_constant.dart';
import '../../../core/widgets/task_item.dart';
import '../models/task_models.dart';

class TasksListview extends StatefulWidget {
  final List<TaskModels> tasks;

  const TasksListview({
    super.key,
    required this.tasks,
  });

  @override
  State<TasksListview> createState() => _TasksListviewState();
}

class _TasksListviewState extends State<TasksListview> {
  @override
  Widget build(BuildContext context) {
    if (widget.tasks.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          Lottie.asset("assets/Empty.json"),
        ],
      );
    }

    return ListView.separated(
      itemCount: widget.tasks.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final task = widget.tasks[index];
        final box = Hive.box<TaskModels>(AppConstant.taskBox);

        return Dismissible(
          key: UniqueKey(),

          background: Container(
            width: double.infinity,
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "Complete",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          secondaryBackground: Container(
            width: double.infinity,
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "Delete",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          onDismissed: (value) {
            final box = Hive.box<TaskModels>(AppConstant.taskBox);

            onDismissed: (value) {
              final box = Hive.box<TaskModels>(AppConstant.taskBox);

              if (value == DismissDirection.startToEnd) {
                task.isCompleted = true;           // ✅ اضف هذا السطر
                task.statusText = "Completed";     // اختياري لو عايز تحتفظ بالنص
                task.save();
              } else {
                box.delete(task.key);
              }

              setState(() {});
            };

            setState(() {});
          },

          child: TaskItem(
            taskModels: task,
            // إذا فيه Checkbox هنا، يجب نفس الطريقة:
            // كل تغيير isCompleted → await box.put(task.key, task); setState(() {});
          ),
        );
      },
    );
  }
}