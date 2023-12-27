import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/utils/app_theme.dart';


class CommonBottomSheet extends StatelessWidget {
  Widget body;
  Widget? icon;
  String title;

  CommonBottomSheet({Key? key, required this.title, required this.body, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      color: Colors.transparent,
      child: Wrap(
        children: [
          Container(
            height: 8.h,
            decoration: BoxDecoration(color: ColorConstants.primaryColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(28.r), topRight: Radius.circular(28.r))),
            margin: EdgeInsets.symmetric(horizontal: 25.w),
          ),
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 30.h, bottom: 20.h, left: 20.w, right: 20.w),
              decoration: const BoxDecoration(color: ColorConstants.backgroundColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(28.0), topRight: Radius.circular(28.0))),
              child: Column(
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(height: 10.h),
                  ],
                  Text(title, style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_16)),
                  SizedBox(height: 20.h),
                  CustomPaint(
                    size: Size(300.w, 3.h),
                    painter: CurvePainter(),
                  ),
                  SizedBox(height: 20.h),
                  body
                ],
              )),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = ColorConstants.secondaryTextColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width / 2, size.height / 2, size.width, 0);
    path.quadraticBezierTo(size.width / 2, -size.height / 2, 0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
