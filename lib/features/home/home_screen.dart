import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart' show Hive;
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/core/widgets/custom_app_buttom.dart';
import 'package:todo_app/features/home/models/user_model.dart';
import 'package:todo_app/main.dart';

import '../../core/app_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user=Hive.box<UserModel>(AppConstant.userBox).getAt(1);

  final ImagePicker picker = ImagePicker();
  XFile? image;
  TextEditingController nameController=TextEditingController() ;

  void openCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {

    });
  }

  void openGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 100.h,
        ),
        child: Column(
          spacing: 20.h,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: image==null,
              child:CircleAvatar(
                radius: 100.r,
                child:Icon(Icons.person,size: 100.r,),
              ),
              replacement:Container(
                width: 200.w,
                height: 200.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image:Image.file(File(image?.path??"")).image
                  )
                ),
              ),
            ),
            CustomAppButtom(
              title: "Upload from Camera",
              onPressed: () {
                openCamera();
              },
            ),
            CustomAppButtom(
              title: "Upload from Gallery",
              onPressed: () {
                openGallery();
              },
            ),
            const Divider(
              color: Colors.indigo,
            ),
            TextFormField(
              controller:nameController ,
              onTapOutside: (v) {
                FocusScope.of(context).unfocus();
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
              ),
            ),

            CustomAppButtom(
              title: "Log In",
              onPressed: () {
                print("User data: ${user?.image}");
                Hive.box<UserModel>(AppConstant.userBox).add(UserModel(name: nameController.text,
                    image: image?.path??"")).then((h){
                      print(h);
                }).catchError((e){
                  print("error $e");

                });

              },
            ),
            Text(user?.name??""),
            Image.file(File(user?.image??""))


          ],
        ),
      ),
    );
  }
}
