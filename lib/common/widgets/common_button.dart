import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/enums/font_type.dart';
import 'package:task/utils/app_theme.dart';


class CommonButton extends StatelessWidget {
  CommonButton({
    Key? key,
    this.backgroundColor,
    this.textColor,
    required this.buttonText,
    this.isBorder = true,
    this.borderColor = ColorConstants.primaryColor,
    required this.onTap,
    this.padding,
    this.postWidget,
  }) : super(key: key);

  Color? backgroundColor = ColorConstants.primaryColor;
  Color? textColor = Colors.black;
  final String buttonText;
  final bool isBorder;
  final Color borderColor;
  final void Function() onTap;
  final EdgeInsets? padding;
  final Widget? postWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(30.r),
        color: backgroundColor ?? ColorConstants.primaryColor,
        elevation: 3,
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            border: isBorder
                ? Border.all(
                    color: borderColor,
                    width: 1.0,
                  )
                : const Border.fromBorderSide(BorderSide.none),
          ),
          padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(buttonText,
                  textAlign: TextAlign.center, style: AppThemeState().textStyleBold(textColor ?? ColorConstants.whiteColor, fontSize: FontConstants.font_16, fontFamily: FFT.plusJakartaSans)),
              if(postWidget != null)...[
                SizedBox(width: 10.w,),
                postWidget!
              ]
            ],
          ),
        ),
      ),
    );
  }
}
