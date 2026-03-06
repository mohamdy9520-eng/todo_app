import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'auth/models/user_model.dart';

void showChangeNameDialog(
    BuildContext context,
    UserModel user,
    VoidCallback setState,
    ) {
  TextEditingController controller =
  TextEditingController(text: user.name);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Change Name"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter new name",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              user.name = controller.text;

              await user.save();

              setState();

              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      );
    },
  );
}