import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/core/custom_text_form_field.dart';
import 'package:todo_app/core/widgets/custom_app_buttom.dart';
import 'package:todo_app/features/auth/models/user_model.dart';
import '../../core/app_constant.dart';
import '../home/widgets/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ImagePicker picker = ImagePicker();

  String? imagePath;
  final TextEditingController nameController = TextEditingController();

  late Box<UserModel> userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<UserModel>(AppConstant.userBox);
    _loadUserData();
  }

  void _loadUserData() {
    if (userBox.isNotEmpty) {
      final user = userBox.getAt(0);
      nameController.text = user!.name;
      imagePath = user.image;
      setState(() {});
    }
  }

  Future<void> openCamera() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        imagePath = picked.path;
      });
    }
  }

  Future<void> openGallery() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imagePath = picked.path;
      });
    }
  }

  void saveUserData() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your name"),
        ),
      );
      return;
    }

    final user = UserModel(
      name: nameController.text.trim(),
      image: imagePath ?? '',
    );

    userBox.put(0, user);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
    );
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100.r,
              backgroundImage:
              imagePath != null && imagePath!.isNotEmpty
                  ? FileImage(File(imagePath!))
                  : null,
              child: imagePath == null || imagePath!.isEmpty
                  ? Icon(Icons.person, size: 100.r)
                  : null,
            ),
            SizedBox(height: 20.h),
            CustomAppButtom(
              title: "Upload from Camera",
              onPressed: openCamera,
            ),
            SizedBox(height: 12.h),
            CustomAppButtom(
              title: "Upload from Gallery",
              onPressed: openGallery,
            ),
            SizedBox(height: 12),
            const Divider(color: Colors.indigo),
            SizedBox(height: 12),

            CustomTextFormField(
              controller: nameController,
              hintText: "Enter your Name", maxlines: 1,
            ),

            SizedBox(height: 20.h),
            CustomAppButtom(
              title: "Log In",
              onPressed: saveUserData,
            ),
          ],
        ),
      ),
    );
  }
}
