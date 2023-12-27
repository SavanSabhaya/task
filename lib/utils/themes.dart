import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: ColorConstants.whiteColor,
  primaryColor: ColorConstants.primaryColor,
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  }),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
    color: ColorConstants.whiteColor,
    elevation: 0,
    titleTextStyle: TextStyle(fontSize: FontConstants.font_20, fontWeight: FontWeightConstants.bold),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      fontSize: FontConstants.font_18,
      fontWeight: FontWeightConstants.medium,
    ),
    titleMedium: TextStyle(
      fontSize: FontConstants.font_20,
      fontWeight: FontWeightConstants.medium,
    ),
    headlineMedium: TextStyle(
      fontSize: FontConstants.font_20,
      fontWeight: FontWeightConstants.medium,
    ),
    labelMedium: TextStyle(
      fontSize: FontConstants.font_16,
      fontWeight: FontWeightConstants.medium,
    ),
    displayMedium: TextStyle(
      fontSize: FontConstants.font_18,
      fontWeight: FontWeightConstants.medium,
    ),
    bodyLarge: TextStyle(
      fontSize: FontConstants.font_18,
      fontWeight: FontWeightConstants.medium,
    ),
  ),
);
