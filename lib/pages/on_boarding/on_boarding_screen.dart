import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/constants/string_constants.dart';
import 'package:task/common/widgets/app_backgound_container.dart';
import 'package:task/pages/on_boarding/onboarding_common_view.dart';
import 'package:task/utils/app_theme.dart';
import 'package:task/utils/routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return AppBackgroundContainer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (currentPage < 2) ...[
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, routeLogin);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        skip,
                        style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_16),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8.w),
                        child: SvgPicture.asset(ImageConstants.svgIcArrowRight),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(color: Color(0xFFDAF0F6), borderRadius: BorderRadius.all(Radius.circular(50.r))),
                  height: 300.h,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.only(top: 22.h),
                    child: Center(
                        child: PageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          print("object $index");
                          currentPage = index;
                        });
                      },
                      children: [
                        OnBoardingCommonView(),
                        OnBoardingCommonView(),
                        OnBoardingCommonView(),
                      ],
                    )),
                  ),
                ),
                Positioned(
                  bottom: 16.h,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          height: 60.h,
                          width: 75.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(60.r), topRight: Radius.circular(60.r)),
                            color: Colors.white,
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (currentPage < 2) {
                                    pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                                  } else {
                                    Navigator.popAndPushNamed(context, routeLogin);
                                  }
                                });
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: ColorConstants.primaryColor,
                                ),
                                child: SvgPicture.asset(ImageConstants.svgIcArrowCircleRight),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
