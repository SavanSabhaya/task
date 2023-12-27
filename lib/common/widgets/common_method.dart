import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

VoidCallback? onClickAction;
bool? isCommonList;
bool? isPostedJob;

//close keyboard
void removeFocus() {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
}

bool checkString(String? value) => value == null || value.toString().trim().isEmpty;

bool checkInt(int? value) => value == null || value.toString().trim().isEmpty;

String defaultStringValue(String? value, String def) =>
    value == null || value.toString().trim().isEmpty ? def : value;

bool isEmail(String em) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return !regex.hasMatch(em);
}

bool isNameValid(String em) {
  String pattern = r'^[a-zA-Z]';
  RegExp regex = RegExp(pattern);
  return !regex.hasMatch(em);
}

bool isUrl(String url) {
  return checkString(url) ? false : !(Uri.tryParse(url)?.isAbsolute ?? false);
}

bool validateMobile(String value) {
// Indian Mobile number are of 10 digit only
  if (value.length != 9) {
    return false;
  } else {
    return true;
  }
}

//show progress dialog
showProgressDialog() {
  if (Get.overlayContext != null) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

//dismiss progress dialog
dismissProgressDialog() {
  Get.back();
  // Navigator.pop(Get.overlayContext!);
}

// No Data Found Widget
// Widget noDataFound(String text) {
//   return Center(
//       child: Text(
//     text,
//     textAlign: TextAlign.center,
//     style: FontConstant.lufgaRegular.copyWith(color: colorBlack, fontSize: Dimens.textSize_16),
//   ));
// }
