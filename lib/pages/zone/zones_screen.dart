import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/constants/string_constants.dart';
import 'package:task/common/widgets/squircle.dart';
import 'package:task/common/widgets/widget_background_container.dart';
import 'package:task/pages/zone/bloc/zones_bloc.dart';
import 'package:task/utils/app_theme.dart';
import 'package:task/utils/routes.dart';
import 'package:task/utils/utils.dart';

class ZonesScreen extends StatelessWidget {
  const ZonesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZonesBloc, ZonesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: 8.h),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 20,
                          right: 0,
                          bottom: 20,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pushNamed(context, routeRunTest);
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 24.w, left: 20.h),
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Color.fromARGB(1, 0, 28, 36),
                                  // Color.fromARGB(0, 255, 255, 255),
                                  Color(0x26FFFFFF),
                                ],
                              )),
                              child: Row(
                                children: [
                                  Text(
                                    "Run Test",
                                    style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_14),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  SvgPicture.asset(ImageConstants.svgIcPlay)
                                ],
                              ),
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              labelSprinklingZone,
                              style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_24),
                              textAlign: TextAlign.start,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6.h),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: ColorConstants.backgroundRomance),
                              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "12",
                                      style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_14),
                                      textAlign: TextAlign.start,
                                    ),
                                    const VerticalDivider(
                                      color: ColorConstants.secondaryTextColor,
                                      endIndent: 5,
                                      indent: 5,
                                    ),
                                    Text(
                                      labelTotalZone,
                                      style: AppThemeState().textStyleMedium(ColorConstants.textColor, fontSize: FontConstants.font_14),
                                      textAlign: TextAlign.start,
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
                ),
                SizedBox(
                  height: 40.h,
                ),
                zoneList(context)
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget zoneList(BuildContext context) {
  return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return zone(context, index);
      });
}

Widget zone(BuildContext context, int index) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
    child: Stack(
      children: [
        SizedBox(
          width: 133.w,
          height: 130.h,
          child: Material(
            shape: SquircleBorder(side: BorderSide(width: 1, color: ColorConstants.primaryColor), superRadius: 4.r),
          ),
        ),
        WidgetBackgroundContainer(
          borderRadius: BorderRadius.circular(45.r),
          padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.only(left: 8.w, top: 5.h, bottom: 5.h),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            getNetworkImageView('https://picsum.photos/200/300', width: 100.w, height: 100.h),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 15.w),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Zone ${index + 1}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_16),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "High Shade",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppThemeState().textStyleBold(ColorConstants.textTwoColor, fontSize: FontConstants.font_14),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Upcoming Schedule\n23 Apr - 05:35 PM",
                    style: AppThemeState().textStyleMedium(ColorConstants.textTwoColor, fontSize: FontConstants.font_14),
                    textAlign: TextAlign.start,
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: SvgPicture.asset(ImageConstants.svgIcEdit),
            )
          ]),
        )
      ],
    ),
  );
}
