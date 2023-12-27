import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/api_service/mqtt_client.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/constants/string_constants.dart';
import 'package:task/common/enums/font_type.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/common/widgets/app_backgound_container.dart';
import 'package:task/common/widgets/common_bottomsheet.dart';
import 'package:task/common/widgets/common_button.dart';
import 'package:task/common/widgets/common_textformfield.dart';
import 'package:task/common/widgets/widget_background_container.dart';
import 'package:task/pages/login/bloc/login_bloc.dart';
import 'package:task/utils/CustomSnackBar.dart';
import 'package:task/utils/app_theme.dart';
import 'package:task/utils/routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  // MqttClient mqttClientManager = MqttClient();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoadStatus.validationError) {
          showErrorSnackBar(context, state.message);
        } else if (state.status == LoadStatus.success) {
          Navigator.popAndPushNamed(context, routeScanQRCode);
        }
      },
      builder: (context, state) {
        return AppBackgroundContainer(
            child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 37.h,
                    ),
                    Text(
                      signIn,
                      style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_32),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "Lorem Ipsum, Or Lipsum As It Is Sometimes Know.",
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
                              maxLength: 30,
                              contentPadding: const EdgeInsets.all(24.0),
                              prefixWidget: SvgPicture.asset(ImageConstants.svgIcEmail),
                              textInputType: TextInputType.emailAddress,
                              onChange: (value) {},
                            ),
                            Divider(
                              height: 2.h,
                              color: ColorConstants.dividerColor,
                            ),
                            CommonTextFormField(
                              editController: passwordController,
                              focusNode: passwordFocusNode,
                              labelText: password,
                              textInputAction: TextInputAction.done,
                              contentPadding: const EdgeInsets.all(24.0),
                              prefixWidget: SvgPicture.asset(ImageConstants.svgIcPassword),
                              textInputType: TextInputType.visiblePassword,
                              isPassword: true,
                              suffixIcon: GestureDetector(
                                child: SvgPicture.asset(state.isObscureText ? ImageConstants.svgIcFieldEye : ImageConstants.svgIcFieldCloseEye),
                                onTap: () {
                                  context.read<LoginBloc>().add(LoginPasswordChangedEvent(!state.isObscureText));
                                },
                              ),
                              // suffixIcon: SvgPicture.asset(ImageConstants.svgIcFieldEye),
                              isObscureText: state.isObscureText,
                              onChange: (value) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(context, routeForgotPassword);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          labelForgotPassword,
                          style: AppThemeState().textStyleMedium(ColorConstants.secondaryTextColor, fontSize: FontConstants.font_14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CommonButton(
                      buttonText: signIn,
                      onTap: () {
                        context.read<LoginBloc>().add(ValidateEvent(emailController.text, passwordController.text));
                        //Navigator.popAndPushNamed(context, routeScanQRCode);
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        RotationTransition(
                          turns: const AlwaysStoppedAnimation(180 / 360),
                          child: SvgPicture.asset(ImageConstants.svgIcLine),
                        ),
                        Flexible(
                          child: Text(
                            continueWithSocials,
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            style: AppThemeState().textStyleMedium(ColorConstants.textColor.withOpacity(0.5), fontSize: FontConstants.font_14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SvgPicture.asset(ImageConstants.svgIcLine),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(ImageConstants.svgIcGoogle),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              google,
                              style: AppThemeState().textStyleMedium(ColorConstants.textColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(ImageConstants.svgIcApple),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              apple,
                              style: AppThemeState().textStyleMedium(ColorConstants.textColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(ImageConstants.svgIcFacebook),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              facebook,
                              style: AppThemeState().textStyleMedium(ColorConstants.textColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(text: newOnPlatform, style: AppThemeState().textStyleMedium(ColorConstants.textColor, fontFamily: FFT.plusJakartaSans, fontSize: FontConstants.font_14)),
                            TextSpan(
                              text: register,
                              style: AppThemeState().textStyleMedium(ColorConstants.primaryColor, fontFamily: FFT.plusJakartaSans, fontSize: FontConstants.font_14),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, routeRegister);
                                  //Navigator.pushNamed(context, routeWebView, arguments: {"title": privacyPolicyName, "url": '${initModel?.baseUrl}$privacyPolicy'});
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                  ],
                )));
      },
    );
  }
}
