import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/pages/splash/bloc/splash_bloc.dart';
import 'package:task/utils/app_theme.dart';
import 'package:task/utils/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state.status == LoadStatus.success) {
                if (_handleLocationPermission == true) {

                  // Navigator.popAndPushNamed(context, routeDashboard);
                }
                Navigator.popAndPushNamed(context, routeScanQRCode);
                // Navigator.popAndPushNamed(context, routeLogin);
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(ImageConstants.imgSplash, fit: BoxFit.cover),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Logo",
                      style: AppThemeState().textStyleBold(ColorConstants.blackColor, fontSize: FontConstants.font_26),
                    )),
              ],
            )));
  }
}

Future<bool> _handleLocationPermission() async {
  var status = await Permission.location.request();
  if (status != PermissionStatus.granted) {
    openAppSettings();
    return false;
  }
  return true;
}

/*class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state.status == LoadStatus.success) {
                Navigator.popAndPushNamed(context, routeLogin);
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(ImageConstants.imgSplash, fit: BoxFit.cover),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Logo",
                      style: AppThemeState().textStyleBold(ColorConstants.blackColor, fontSize: FontConstants.font_26),
                    )),
              ],
            )));
  }
}*/
