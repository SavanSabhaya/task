import 'package:flutter/material.dart';
import 'package:task/common/constants/color_constants.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  bool isObscureText;

  CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.isObscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: isObscureText,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: prefixIcon,
              prefixIconColor: ColorConstants.primaryColor,
              suffixIcon: suffixIcon,
              suffixIconColor: ColorConstants.primaryColor,
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: ColorConstants.primaryColor, width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: ColorConstants.primaryColor, width: 2),
              ),
            ),
          ),
        ),
        // suffixIcon == null ? Container() : suffixIcon!,
      ],
    );
  }
}
