import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/widgets/custom_app_buttom.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius:100.h,
            child: Icon(Icons.person, size: 100.w),
          ),
          SizedBox(height: 20.h,),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomAppButtom(title: "Change Profile Picture",
            onPressed: (){
              showModalBottomSheet(context: context, builder: (context){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20.h,
                    children: [
                      CustomAppButtom(title: "Upload from Camera",
                      onPressed: (){},),

                      SizedBox(height: 10.h,),
                      CustomAppButtom(title: "Upload from gallery",
                      onPressed: (){},)
                    ],
                  ),
                );
              });
            },),
          )
        ],
      ),
    );
  }
}

