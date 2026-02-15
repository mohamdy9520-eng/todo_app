import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/custom_text_form_field.dart';
import 'package:todo_app/core/widgets/custom_app_buttom.dart';
import 'package:todo_app/features/home/models/task_models.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formKey = GlobalKey<FormState>();

  List<Color> taskColors = [
    Colors.indigo,
    Colors.green,
    Colors.red,
  ];

  int activeIndex = 0;

  var titleController = TextEditingController();
  var describtionController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();

  String? date;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.indigo,
        ),
        title: Text(
          "Add Task",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.indigo,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      controller: titleController,
                      hintText: "Task Title",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Task Title is Required";
                        } else if (value.length < 4) {
                          return "Title must be at least 4 characters";
                        }
                        return null;
                      },
                      maxlines: 1,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      controller: describtionController,
                      hintText: "Enter Description",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Task Description is Required";
                        }
                        return null;
                      },
                      maxlines: 4,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      controller: dateController,
                      hintText: "Enter Task Date",
                      maxlines: 1,
                      suffixIcon: const Icon(Icons.date_range),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Date is Required";
                        }
                        return null;
                      },
                      readOnly: true,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2027),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Colors.yellow,
                                  onPrimary: Colors.black,
                                  onSurface: Colors.green,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        ).then((d) {
                          if (d != null) {
                            date = DateFormat.MMMEd().format(d);
                            dateController.text = date!;
                          }
                        }).catchError((error) {});
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: startTimeController,
                            hintText: "Start Time",
                            maxlines: 1,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Start Time is Required";
                              }
                              return null;
                            },
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((time) {
                                if (time != null) {
                                  startTime = time;
                                  startTimeController.text =
                                      time.format(context);
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomTextFormField(
                            controller: endTimeController,
                            hintText: "End Time",
                            maxlines: 1,
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "End Time is Required";
                              } else if (startTime != null &&
                                  endTime != null &&
                                  (endTime!.hour < startTime!.hour ||
                                      (endTime!.hour == startTime!.hour &&
                                          endTime!.minute <
                                              startTime!.minute))) {
                                return "End time must be after start time";
                              }
                              return null;
                            },
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((time) {
                                if (time != null) {
                                  endTime = time;
                                  endTimeController.text =
                                      time.format(context);
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 50.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                          child: CircleAvatar(
                            radius: 25.r,
                            backgroundColor: taskColors[index],
                            child: activeIndex == index
                                ? const Icon(Icons.check, color: Colors.white)
                                : null,
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10.w),
                        itemCount: taskColors.length,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomAppButtom(
                      title: "Create Task",
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          allTasks.add(TaskModels(
                            title: titleController.text,
                            startTime: startTimeController.text,
                            endTime: endTimeController.text,
                            description: describtionController.text,
                            statusText: "ToDo",
                            color: taskColors[activeIndex],
                          ));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
