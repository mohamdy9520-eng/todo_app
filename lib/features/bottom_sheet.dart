import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/core/app_constant.dart';
import 'package:todo_app/core/widgets/add_task_row.dart';
import 'package:todo_app/features/auth/models/user_model.dart';
import 'package:todo_app/features/filter.dart';
import 'package:todo_app/features/home/widgets/tasks_listView.dart';
import 'package:todo_app/features/add_task/add_task_screen.dart';
import 'home/models/task_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    try {
      final box = Hive.box<UserModel>(AppConstant.userBox);
      final user = box.get('user');

      if (user == null) {
        final newUser = UserModel(name: "User", image: "");
        box.put('user', newUser);
        setState(() => _user = newUser);
      } else {
        setState(() => _user = user);
      }
    } catch (e) {
      debugPrint("Error loading user: $e");
      setState(() => _user = UserModel(name: "Guest", image: ""));
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning!";
    if (hour < 18) return "Good Afternoon!";
    return "Good Evening!";
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose Image"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        final box = Hive.box<UserModel>(AppConstant.userBox);
        _user!.image = image.path;
        await box.put('user', _user!);
        setState(() {});
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void _showNameDialog() {
    TextEditingController controller =
    TextEditingController(text: _user!.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Name"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Enter new name",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () async {
                String newName = controller.text.trim();
                if (newName.isEmpty) return;

                final box = Hive.box<UserModel>(AppConstant.userBox);
                _user!.name = newName;
                await box.put('user', _user!);
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _removePhoto() async {
    if (_user == null) return;
    final box = Hive.box<UserModel>(AppConstant.userBox);
    _user!.image = "";
    await box.put('user', _user!);
    setState(() {});
  }

  void _showProfileOptions() {
    if (_user == null) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image, color: Colors.blue),
              title: const Text("Change Photo"),
              onTap: () {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 100), () {
                  _showImageSourceDialog();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.green),
              title: const Text("Change Name"),
              onTap: () {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 100), () {
                  _showNameDialog();
                });
              },
            ),
            if (_user!.image.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Remove Photo", style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.of(context).pop();
                  _removePhoto();
                },
              ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _user!.name,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "${getGreeting()} ${_user!.name}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: _showProfileOptions,
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _user!.image.isNotEmpty && File(_user!.image).existsSync()
                          ? FileImage(File(_user!.image))
                          : null,
                      child: _user!.image.isEmpty || !File(_user!.image).existsSync()
                          ? Icon(Icons.person, size: 30.r, color: Colors.grey)
                          : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              AddTaskRow(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddTaskScreen()),
                  );
                  setState(() {});
                },
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: FilterButton(
                      title: "All",
                      isActive: activeIndex == 0,
                      onTap: () => setState(() => activeIndex = 0),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: FilterButton(
                      title: "ToDo",
                      isActive: activeIndex == 1,
                      onTap: () => setState(() => activeIndex = 1),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: FilterButton(
                      title: "Completed",
                      isActive: activeIndex == 2,
                      onTap: () => setState(() => activeIndex = 2),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<TaskModels>(AppConstant.taskBox).listenable(),
                  builder: (context, Box<TaskModels> box, _) {
                    final tasks = box.values.toList().cast<TaskModels>();
                    List<TaskModels> filteredTasks;

                    if (activeIndex == 0) {
                      filteredTasks = tasks; // All
                    } else if (activeIndex == 1) {
                      filteredTasks = tasks.where((task) => !task.isCompleted).toList(); // ToDo
                    } else {
                      filteredTasks = tasks.where((task) => task.isCompleted).toList(); // Completed
                    }

                    return TasksListview(tasks: filteredTasks);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}