import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/utils/app_theme.dart';

class OnBoardingCommonView extends StatelessWidget {
  const OnBoardingCommonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w,horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Lorem Ipsum is simply dummy text',
            style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_20),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 24.h,
          ),
          Text(
            'Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. Lorem Ipsum Has Been The Industry\'s Standard Dummy Text Ever Since The 1500S',
            style: AppThemeState().textStyleMedium(ColorConstants.textTwoColor, fontSize: FontConstants.font_14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
