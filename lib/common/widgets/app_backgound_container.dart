import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/utils/utils.dart';

class AppBackgroundContainer extends StatelessWidget {
  Widget child;
  EdgeInsets? padding;

  AppBackgroundContainer({Key? key, required this.child,this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorConstants.whiteColor,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              removeFocus();
            },
            child: Stack(
              children: [
                Container(
                    height: 148.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0x66005975).withOpacity(0.25),
                        const Color(0xFF005975).withOpacity(0.2),
                        const Color(0xFF005975).withOpacity(0.1),
                        const Color(0xFF005975).withOpacity(0),
                      ],
                    ))),
                Container(
                  width: double.infinity,
                  height: 148.h,
                  color: Colors.white.withOpacity(0.4),
                ),
                Padding(
                  padding: padding ?? EdgeInsets.only(left: 24.w, top: 8.h, right: 24.w),
                  child: child,
                )
              ],
            )),
      ),
    );
  }
}
