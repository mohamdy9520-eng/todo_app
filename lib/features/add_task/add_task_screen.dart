import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/custom_text_form_field.dart';
import 'package:todo_app/core/widgets/custom_app_buttom.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
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
                autovalidateMode:AutovalidateMode.onUserInteraction ,
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),


                    CustomTextFormField(
                      hintText: "Task Title",
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Task Title is Required";
                        }else if(value.length<4){
                          return "title must be at least 4 characters";
                        }

                      },
                      maxlines: 1,
                    ),
                    SizedBox(height: 20.h),

                    CustomTextFormField(
                      hintText: "Enter Description",
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Task Description is Required";
                        }

                      },
                      maxlines: 4,
                    ),
                    SizedBox(height: 20.h),

                    CustomTextFormField(
                      hintText: "Enter Task Date",
                      maxlines: 1,
                      suffixIcon: Icon(Icons.date_range),
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return " Date is Required";
                        }
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
                                colorScheme: ColorScheme.light(
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
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            hintText: "Start Time",
                            maxlines: 1,
                            readOnly: true,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CustomTextFormField(
                            hintText: "End Time",
                            maxlines: 1,
                            readOnly: true,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    CustomAppButtom(
                      title: "Create Task",
                      onPressed: () {
                        formKey.currentState?.validate();
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
