import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/constants/string_constants.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/common/widgets/app_backgound_container.dart';
import 'package:task/common/widgets/common_bottomsheet.dart';
import 'package:task/common/widgets/common_button.dart';
import 'package:task/common/widgets/common_checkBox.dart';
import 'package:task/common/widgets/squircle.dart';
import 'package:task/common/widgets/widget_background_container.dart';
import 'package:task/main.dart';
import 'package:task/models/zones.dart';
import 'package:task/pages/run_test/bloc/run_test_bloc.dart';
import 'package:task/utils/app_theme.dart';
import 'package:task/utils/utils.dart';

class RunTestScreen extends StatefulWidget {
  const RunTestScreen({Key? key}) : super(key: key);

  @override
  State<RunTestScreen> createState() => _RunTestScreenState();
}

class _RunTestScreenState extends State<RunTestScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RunTestBloc, RunTestState>(
      listener: (context, state) {
        if (state.status == LoadStatus.initial) {
          if (state.isCheckAll) {
          } else {}
        }
      },
      builder: (context, state) {
        return AppBackgroundContainer(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 26.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(padding: EdgeInsets.only(top: 10.h, right: 10.w, bottom: 10.h), child: SvgPicture.asset(ImageConstants.svgIcBack)),
                ),
                Text(
                  state.isRunning ? labelRunningTest : labelRunATest,
                  style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_18),
                  textAlign: TextAlign.start,
                ),
                state.isRunning
                    ? Container()
                    : CommonCheckBox(
                        isCheck: state.isCheckAll,
                        onTap: () {
                          if (state.isCheckAll) {
                            for (int i = 0; i < zoneList.length; i++) {
                              zoneList[i].isCheck = false;
                            }
                          } else {
                            for (int i = 0; i < zoneList.length; i++) {
                              zoneList[i].isCheck = true;
                            }
                          }
                          context.read<RunTestBloc>().add(SelectAllEvent(!state.isCheckAll));
                        },
                      )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: state.isRunning
                  ? zoneListView(context)
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 16.h, crossAxisSpacing: 20.w, childAspectRatio: 0.70.r),
                      itemCount: zoneList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 204.h,
                              width: 154.w,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: const Material(
                                shape: SquircleBorder(
                                  side: BorderSide(width: 1, color: ColorConstants.primaryColor),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.h),
                                getNetworkImageView(zoneList[index].image, width: 100.w, height: 90.h),
                                SizedBox(height: 10.h),
                                Text(
                                  zoneList[index].title,
                                  style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_16),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  zoneList[index].subTitle,
                                  style: AppThemeState().textStyleBold(ColorConstants.textTwoColor, fontSize: FontConstants.font_14),
                                ),
                              ],
                            ),
                            Positioned(
                                bottom: 0,
                                child: CommonCheckBox(
                                  isCheck: zoneList[index].isCheck,
                                  onTap: () {
                                    //context.read<RunTestBloc>().add(SelectZoneEvent(!state.zoneList[index].isCheck, index));
                                    setState(() {
                                      zoneList[index].isCheck = !zoneList[index].isCheck;
                                    });
                                  },
                                ))
                          ],
                        );
                      },
                    ),
            ),
            SizedBox(height: 15.h),
            CommonButton(
              buttonText: state.isRunning ? labelStopTest : labelRunTest,
              onTap: () {
                if(state.isRunning){
                  stopTest(context,state);
                }else{
                  runTest(context, state);
                }
              },
              postWidget: SvgPicture.asset(
                state.isRunning ? ImageConstants.svgIcStop : ImageConstants.svgIcPlay,
                color: ColorConstants.secondaryTextColor,
              ),
            ),
            SizedBox(height: 15.h),
          ],
        ));
      },
    );
  }

  void runTest(BuildContext context, RunTestState state) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: false,
        useSafeArea: true,
        useRootNavigator: true,
        enableDrag: false,
        context: context,
        builder: (builder) {
          return CommonBottomSheet(
              title: labelSetTheTimer,
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text(startTime, style: AppThemeState().textStyleBold(ColorConstants.textTwoColor, fontSize: FontConstants.font_14), textAlign: TextAlign.center),
                          Container(
                            width: 140.w,
                            height: 35.h,
                            margin: EdgeInsets.only(top: 5.h),
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ColorConstants.whiteColor),
                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
                                    child: SvgPicture.asset(ImageConstants.svgIcClock),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 12,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ColorConstants.whiteColor),
                                    padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 15.w),
                                    child: Text(
                                      "12:00 PM",
                                      style: AppThemeState().textStyleBold(ColorConstants.blackColor, fontSize: FontConstants.font_14),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Text(endTime, style: AppThemeState().textStyleBold(ColorConstants.textTwoColor, fontSize: FontConstants.font_14), textAlign: TextAlign.center),
                          Container(
                            width: 140.w,
                            height: 35.h,
                            margin: EdgeInsets.only(top: 5.h),
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ColorConstants.whiteColor),
                                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
                                    child: SvgPicture.asset(ImageConstants.svgIcClock),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 12,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ColorConstants.whiteColor),
                                    padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 15.w),
                                    child: Text(
                                      "12:30 PM",
                                      style: AppThemeState().textStyleBold(ColorConstants.blackColor, fontSize: FontConstants.font_14),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                  CommonButton(
                    buttonText: setTimer,
                    onTap: () {
                      context.read<RunTestBloc>().add(UpdateStatusEvent(!state.isRunning));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
        });
  }

  void stopTest(BuildContext context, RunTestState state) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: false,
        useSafeArea: true,
        useRootNavigator: true,
        enableDrag: false,
        context: context,
        builder: (builder) {
          return CommonBottomSheet(
              title: setAreYouSure,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(labelStopTestMessage, style: AppThemeState().textStyleMedium(ColorConstants.textTwoColor, fontSize: FontConstants.font_14), textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                          child: CommonButton(
                              buttonText: cancel,
                              isBorder: true,
                              backgroundColor: ColorConstants.backgroundColor,
                              textColor: ColorConstants.primaryColor,
                              onTap: () {
                                Navigator.pop(context);
                              })),
                      const SizedBox(width: 20),
                      Expanded(
                          child: CommonButton(
                              buttonText: stop,
                              onTap: () {
                                context.read<RunTestBloc>().add(UpdateStatusEvent(!state.isRunning));
                                Navigator.pop(context);
                              })),
                    ],
                  )
                ],
              ));
        });
  }
}

Widget zoneListView(BuildContext context) {
  return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: 3,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return zone(context, index);
      });
}

Widget zone(BuildContext context, int index) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.h),
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
          child: Row(children: [
            getNetworkImageView('https://picsum.photos/200/300', width: 100.w, height: 100.h),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10.w),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Zone ${index + 1}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_16),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(ImageConstants.svgIcClock),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "20:22 / remaining",
                        style: AppThemeState().textStyleMedium(ColorConstants.primaryColor, fontSize: FontConstants.font_14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    width: 100.w,
                    height: 35.h,
                    margin: EdgeInsets.only(top: 5.h),
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Positioned(
                          top: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.r),
                                  bottomLeft: Radius.circular(15.r),
                                  topRight: Radius.circular(20.r),
                                  bottomRight: Radius.circular(20.r),
                                ),
                                color: ColorConstants.whiteColor),
                            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
                            child: SvgPicture.asset(ImageConstants.svgIcStop),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 10,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(15.r),
                                  bottomRight: Radius.circular(15.r),
                                ),
                                color: ColorConstants.whiteColor),
                            padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 15.w),
                            child: Text(
                              stop,
                              style: AppThemeState().textStyleBold(ColorConstants.blackColor, fontSize: FontConstants.font_14),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            )
          ]),
        )
      ],
    ),
  );
}
