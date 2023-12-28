import 'package:flutter/material.dart';
import 'package:task/common/constants/color_constants.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Icon prefixIcon;
  final Icon? suffixIcon;

  const CustomTextField(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.prefixIcon,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,prefixIconColor: ColorConstants.primaryColor,
        suffixIcon: suffixIcon,suffixIconColor: ColorConstants.primaryColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.primaryColor, width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.primaryColor, width: 2),
        ),
      ),
    );
  }
}
