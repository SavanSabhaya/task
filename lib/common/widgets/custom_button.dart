import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'common_widgets.dart';
import 'custom_textField.dart';

class CustomButton {
  /*static GestureDetector submitButton(
      {String? text,
        bool? isLoading = false,
        VoidCallback? function,
        double? fontSize,
        FontWeight? fontWeight,
        double width = 200.0,
        double height = 40.0,
        Color? color,
        Color textColor = ColorConstants.whiteColor}) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Center(
          child: CustomTextFields.textField(
            textAlign: TextAlign.center,
            fontFamily: "Roboto",
            textColor: textColor,
            text: text ?? "",
            fontWeight: fontWeight ?? FontWeightConstants.medium,
            fontSize: fontSize ?? FontConstants.font_14, //fontSize
          ),
        ),
      ),
    );
  }

  static GestureDetector fillButton({
    required BuildContext? context,
    Color? backGroundColor,
    Color textColor = ColorConstants.whiteColor,
    String? text,
    FontWeight? fontWeight,
    String? fontFamily = FontFamilyConstants.cabin,
    VoidCallback? function,
    Gradient? gradient,
    double? fontSize,
    double width = 300.0,
    double? height = 42.0,
    bool? isLoading = false,
  }) {
    return GestureDetector(
      onTap: () {
        CommonWidgets().hideKeyboard(context!);
        function?.call();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: backGroundColor,
          gradient: gradient,
        ),
        child: Center(
          child: CustomTextFields.textField(
            textColor: textColor,
            text: text ?? "",
            fontWeight: fontWeight ?? FontWeightConstants.semiBold,
            fontFamily: fontFamily,
            fontSize: fontSize ?? FontConstants.font_14, //fontSize
          ),
        ),
      ),
    );
  }

  static GestureDetector fillButtonWithIcon(
      {String? text,
        String? icon,
        VoidCallback? function,
        double? fontSize,
        double width = 200.0,
        double? height,
        double? iconWidth = 16,
        double? iconHeight = 16,
        EdgeInsetsGeometry? iconMargin =const EdgeInsets.only(right: 16),
        FontWeight? fontWeight = FontWeightConstants.medium,
        Color? color,
        Color textColor = ColorConstants.whiteColor}) {
    return GestureDetector(
      onTap: (){
        function?.call();
      },
      child: Container(
        width: width,
        height: height ?? 45.0,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            color: color),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomTextFields.textField(
              textColor: textColor,
              text: text ?? "",
              fontWeight: fontWeight,
              fontSize: fontSize ?? FontConstants.font_14, //fontSize
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: iconMargin,
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                icon ?? "",
                color: ColorConstants.whiteColor,
                height: iconHeight,
                width: iconWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }*/


}