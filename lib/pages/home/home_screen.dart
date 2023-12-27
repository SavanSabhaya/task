import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:task/api_service/mqtt_client.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/constants/string_constants.dart';
import 'package:task/common/widgets/common_bottomsheet.dart';
import 'package:task/common/widgets/common_button.dart';
import 'package:task/common/widgets/squircle.dart';
import 'package:task/common/widgets/widget_background_container.dart';
import 'package:task/pages/home/bloc/home_bloc.dart';
import 'package:task/utils/CustomSnackBar.dart';
import 'package:task/utils/app_theme.dart';
import 'package:task/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyMqttClient mqttClientManager = MyMqttClient();
  Timer? timer;
  var macAddress = "";
  var isInsideCalled = false;

  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration(seconds: 15), () {
    //   setupMqttClient();
    //   setupUpdatesListener();
    // });

    // setupMqttClient();
    // setupUpdatesListener();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = (ModalRoute
        .of(context)
        ?.settings
        .arguments ?? <String, String>{}) as Map;

    if (macAddress.isEmpty) {
      macAddress = arg["macAddress"].toString();
    }
    // BlocProvider.of<ConnectDeviceBloc>(context).add(ConnectDeviceInitEvent(macAddress));

    print("DATADATA state.macAddress: 2 $macAddress");

    if (macAddress.isNotEmpty && macAddress != "" && !isInsideCalled) {
      Future.delayed(Duration(seconds: 5), () {
        print("DATADATA inside");
        isInsideCalled = true;
        setupMqttClient();
        setupUpdatesListener();
      });
    }
  }

  @override
  void dispose() {
    mqttClientManager.disconnect();
    super.dispose();
  }

  Future<void> setupMqttClient() async {
    mqttClientManager.connect().then((value) {
      print('DATADATA MQTTClient::Message MAC TX_$macAddress');
      if(value == 1){
        print('DATADATA MQTTClient::Message MAC TX_$macAddress');
        mqttClientManager.subscribe("TX_$macAddress");
        timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => publishMessage());
      }
    });

    // Every 5 second
    // Future.delayed(Duration(seconds: 2), () => /*showSuccessSnackBar(context, "Config Data response")*/ mqttClientManager.publishMessage("RX_34851852330", "Config Data"));
  }

  void publishMessage() {
    // mqttClientManager.publishMessage("RX_34851852330", "Hello! From Server.");
    print('DATADATA MQTTClient::Message MAC RX_$macAddress');
    mqttClientManager.publishMessage("RX_$macAddress", "Hello! From Server.");
  }

  void setupUpdatesListener() {
    mqttClientManager.getMessagesStream()?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
      showSuccessSnackBar(context, pt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: 8.h),
            width: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              top: 0.0,
                              child: Align(alignment: Alignment.centerRight, child: SvgPicture.asset(ImageConstants.svgIcNotification)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  labelControllerZ,
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
                                        Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: ColorConstants.primaryColor),
                                          width: 8,
                                          height: 8,
                                        ),
                                        const VerticalDivider(
                                          color: ColorConstants.secondaryTextColor,
                                          endIndent: 5,
                                          indent: 5,
                                        ),
                                        Text(
                                          active,
                                          style: AppThemeState().textStyleMedium(ColorConstants.textColor, fontSize: FontConstants.font_14),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              child: Container(
                                width: 100.w,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        // Colors.brown,
                                        Color(0xFFDAF0F6),
                                        Color(0xFFFFFFFF),
                                      ],
                                    )),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              right: -65,
                              child: SvgPicture.asset(
                                ImageConstants.svgIcThermometerShap,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 24.w, top: 8.h, bottom: 8.h),
                              child: Text(
                                labelScheduledPrograms,
                                style: AppThemeState().textStyleBold(ColorConstants.primaryColor, fontSize: FontConstants.font_18),
                                textAlign: TextAlign.start,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      zoneList(context),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setupMqttClient();
                    setupUpdatesListener();
                  },
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 240.w,
                        height: 35.h,
                        margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
                        child: Stack(
                          fit: StackFit.loose,
                          children: [
                            Positioned(
                              top: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ColorConstants.backgroundRomance),
                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
                                child: SvgPicture.asset(ImageConstants.svgIcPlay),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 10,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ColorConstants.backgroundRomance),
                                padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 15.w),
                                child: Text(
                                  "Video Guidance for you.",
                                  style: AppThemeState().textStyleBold(ColorConstants.blackColor, fontSize: FontConstants.font_14),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                )
              ],
            ),
          );
        });
  }
}

/*class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: 8.h),
            width: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              top: 0.0,
                              child: Align(alignment: Alignment.centerRight, child: SvgPicture.asset(ImageConstants.svgIcNotification)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  labelControllerZ,
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
                                        Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: ColorConstants.primaryColor),
                                          width: 8,
                                          height: 8,
                                        ),
                                        const VerticalDivider(
                                          color: ColorConstants.secondaryTextColor,
                                          endIndent: 5,
                                          indent: 5,
                                        ),
                                        Text(
                                          active,
                                          style: AppThemeState().textStyleMedium(ColorConstants.textColor, fontSize: FontConstants.font_14),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              child: Container(
                                width: 100.w,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        // Colors.brown,
                                        Color(0xFFDAF0F6),
                                        Color(0xFFFFFFFF),
                                      ],
                                    )),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              right: -65,
                              child: SvgPicture.asset(ImageConstants.svgIcThermometerShap,width: MediaQuery.of(context).size.width,),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 24.w, top: 8.h, bottom: 8.h),
                              child: Text(
                                labelScheduledPrograms,
                                style: AppThemeState().textStyleBold(ColorConstants.primaryColor, fontSize: FontConstants.font_18),
                                textAlign: TextAlign.start,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      zoneList(context),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 240.w,
                      height: 35.h,
                      margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          Positioned(
                            top: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ColorConstants.backgroundRomance),
                              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
                              child: SvgPicture.asset(ImageConstants.svgIcPlay),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 10,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ColorConstants.backgroundRomance),
                              padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 15.w),
                              child: Text(
                                "Video Guidance for you.",
                                style: AppThemeState().textStyleBold(ColorConstants.blackColor, fontSize: FontConstants.font_14),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          );
        });
  }
}*/

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
          child: Row(children: [
            getNetworkImageView('https://picsum.photos/200/300', width: 100.w, height: 100.h),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10.w),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Currently Sprinkling",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_16),
                    textAlign: TextAlign.start,
                  ),
                  if (index == 0) ...[
                    SizedBox(height: 2.h),
                    Text(
                      "Zone 1",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppThemeState().textStyleBold(ColorConstants.textTwoColor, fontSize: FontConstants.font_14),
                      textAlign: TextAlign.start,
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
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ColorConstants.whiteColor),
                              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 11.w),
                              child: SvgPicture.asset(ImageConstants.svgIcStop),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 10,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: ColorConstants.whiteColor),
                              padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 15.w),
                              child: Text(
                                stop,
                                style: AppThemeState().textStyleBold(ColorConstants.blackColor, fontSize: FontConstants.font_14),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ] else
                    ...[
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageConstants.svgIcClock),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "05:35 PM",
                            style: AppThemeState().textStyleMedium(ColorConstants.primaryColor, fontSize: FontConstants.font_14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageConstants.svgIcCalendar),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "Today",
                            style: AppThemeState().textStyleMedium(ColorConstants.primaryColor, fontSize: FontConstants.font_14),
                          ),
                        ],
                      )
                    ],
                ]),
              ),
            )
          ]),
        )
      ],
    ),
  );
}

void locationPermission(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: false,
      useSafeArea: true,
      useRootNavigator: true,
      enableDrag: false,
      context: context,
      builder: (builder) {
        return CommonBottomSheet(
            icon: SvgPicture.asset(ImageConstants.svgLocation),
            title: locationAccess,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(locationAccessDetails, style: AppThemeState().textStyleMedium(ColorConstants.textColor, fontSize: FontConstants.font_14), textAlign: TextAlign.center),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                        child: CommonButton(
                            buttonText: notNow,
                            isBorder: true,
                            backgroundColor: ColorConstants.backgroundColor,
                            textColor: ColorConstants.primaryColor,
                            onTap: () {
                              Navigator.pop(context);
                            })),
                    const SizedBox(width: 20),
                    Expanded(
                        child: CommonButton(
                            buttonText: allow,
                            onTap: () {
                              Navigator.pop(context);
                            })),
                  ],
                )
              ],
            ));
      });
}
