import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final int maxlines;
  final Widget? suffixIcon;
  final bool readOnly;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  const CustomTextFormField({super.key, this.controller, required this.hintText, required this.maxlines, this.suffixIcon,
    this.readOnly=false, this.onTap, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly:readOnly ,
      maxLines:maxlines ,
      controller: controller,
      validator: validator ,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        suffixIcon:suffixIcon,
        hintText: hintText,
        border:OutlineInputBorder() ,
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo),
        ),

      ),
    );
  }
}
