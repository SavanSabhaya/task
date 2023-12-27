import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/widgets/squircle.dart';

void removeFocus() {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
}
/* 
Widget getNetworkImageView(
  String imageURL, {
  double? height,
  double? width,
  BoxFit? boxFit,
}) {
  return Material(
    clipBehavior: Clip.antiAlias,
    shape: const SquircleBorder(),
    child: Image.asset(
      ImageConstants.imgGarden,
      fit: boxFit ?? BoxFit.cover,
      height: height ?? 100.h,
      width: width ?? 100.w,
    ),
  );
} */
