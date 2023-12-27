import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/common/constants/color_constants.dart';

class WidgetBackgroundContainer extends StatelessWidget {
  Widget child;
  BorderRadius? borderRadius;
  EdgeInsets? padding;
  EdgeInsets? margin;

  WidgetBackgroundContainer({Key? key, required this.child, this.borderRadius, this.padding,this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.symmetric(vertical: 10.w),
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(color: ColorConstants.backgroundColor, borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(24.r))),
      child: child,
    );
  }
}
