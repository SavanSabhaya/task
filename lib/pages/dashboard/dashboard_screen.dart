import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/widgets/app_backgound_container.dart';
import 'package:task/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:task/pages/home/bloc/home_bloc.dart';
import 'package:task/pages/home/home_screen.dart';
import 'package:task/pages/run_test/bloc/run_test_bloc.dart';
import 'package:task/pages/run_test/run_test_screen.dart';
import 'package:task/pages/zone/bloc/zones_bloc.dart';
import 'package:task/pages/zone/zones_screen.dart';
import 'package:task/utils/utils.dart';

class DashBordScreen extends StatefulWidget {
  const DashBordScreen({Key? key}) : super(key: key);

  @override
  State<DashBordScreen> createState() => _DashBordScreenState();
}

class _DashBordScreenState extends State<DashBordScreen> with TickerProviderStateMixin {
  int selectedPage = 0;
  TabController? tabController;
  final GlobalKey<ConvexAppBarState> _appBarKey = GlobalKey<ConvexAppBarState>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this, animationDuration: const Duration(milliseconds: 700));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {},
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              if (tabController?.index != 0) {
                setState(() {
                  tabController?.index = 0;
                  selectedPage = 0;
                });
                return false;
              } else {
                return true;
              }
            },
            child: Scaffold(
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
                        DefaultTabController(
                          length: 4,
                          initialIndex: selectedPage,
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: tabController,
                            children: [
                              BlocProvider(create: (create) => HomeBloc(), child: const HomeScreen()),
                              BlocProvider(create: (create) => ZonesBloc(), child: const ZonesScreen()),
                              BlocProvider(create: (create) => HomeBloc(), child: const HomeScreen()),
                              BlocProvider(create: (create) => ZonesBloc(), child: const ZonesScreen()),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              bottomNavigationBar: Container(
                margin: EdgeInsets.symmetric(horizontal: 18.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(44.r), topRight: Radius.circular(44.r)),
                  color: ColorConstants.primaryColor,
                ),
                child: Container(
                    margin: const EdgeInsets.only(right: 12, left: 12, top: 12, bottom: 12),
                    decoration: BoxDecoration(color: ColorConstants.backgroundColor, borderRadius: BorderRadius.circular(40)),
                    child: BottomNavigationBar(
                      iconSize: 20,
                      type: BottomNavigationBarType.shifting,
                      enableFeedback: false,
                      onTap: (value) {
                        setState(() {
                          selectedPage = value;
                          tabController?.animateTo(selectedPage);
                        });
                      },
                      backgroundColor: Colors.transparent,
                      showUnselectedLabels: false,
                      showSelectedLabels: false,
                      selectedItemColor: Colors.black,
                      elevation: 0,
                      currentIndex: selectedPage,
                      items: [
                        BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              ImageConstants.svgIcHome,
                            ),
                            label: '',
                            backgroundColor: Colors.transparent,
                            activeIcon: getActiveIcon(SvgPicture.asset(
                              ImageConstants.svgIcHome,
                            ))),
                        BottomNavigationBarItem(
                            icon: SvgPicture.asset(ImageConstants.svgIcMaximize),
                            label: '',
                            backgroundColor: Colors.transparent,
                            activeIcon: getActiveIcon(SvgPicture.asset(
                              ImageConstants.svgIcMaximize,
                            ))),
                        BottomNavigationBarItem(
                            icon: SvgPicture.asset(ImageConstants.svgIcMenuBoard),
                            label: '',
                            backgroundColor: Colors.transparent,
                            activeIcon: getActiveIcon(SvgPicture.asset(
                              ImageConstants.svgIcMenuBoard,
                            ))),
                        BottomNavigationBarItem(
                            icon: SvgPicture.asset(ImageConstants.svgIcSetting),
                            label: '',
                            backgroundColor: Colors.transparent,
                            activeIcon: getActiveIcon(SvgPicture.asset(
                              ImageConstants.svgIcSetting,
                            ))),
                      ],
                    )),
              ),
            ),
          );
        });
  }

  Widget getActiveIcon(Widget icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(24)), color: ColorConstants.whiteColor),
      child: icon,
    );
  }
}
