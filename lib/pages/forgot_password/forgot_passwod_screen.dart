import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/constants/string_constants.dart';
import 'package:task/common/widgets/app_backgound_container.dart';
import 'package:task/common/widgets/common_button.dart';
import 'package:task/common/widgets/common_textformfield.dart';
import 'package:task/common/widgets/widget_background_container.dart';
import 'package:task/pages/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:task/utils/app_theme.dart';
import 'package:task/utils/routes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {},
      child: AppBackgroundContainer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 36.h,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(ImageConstants.svgIcBack),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  labelForgetPassword,
                  style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_32),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  labelEnterRegisteredEmail,
                  style: AppThemeState().textStyleMedium(ColorConstants.textColor.withOpacity(0.6), fontSize: FontConstants.font_14),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 40.h,
                ),
                WidgetBackgroundContainer(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonTextFormField(
                          editController: emailController,
                          focusNode: emailFocusNode,
                          labelText: emailId,
                          contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                          prefixWidget: SvgPicture.asset(ImageConstants.svgIcEmail),
                          textInputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          onChange: (value) {},
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
          Container(
            margin: EdgeInsets.only(bottom: 24.h),
            child: CommonButton(
              buttonText: labelSendLink,
              onTap: () {
                Navigator.pushNamed(context, routeResetPassword);
              },
            ),
          )
        ],
      )),
    );
  }
}
