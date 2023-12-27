import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/image_constants.dart';
import 'package:task/common/constants/string_constants.dart';
import 'package:task/common/enums/font_type.dart';
import 'package:task/common/widgets/app_backgound_container.dart';
import 'package:task/common/widgets/common_button.dart';
import 'package:task/common/widgets/common_textformfield.dart';
import 'package:task/common/widgets/widget_background_container.dart';
import 'package:task/pages/register/bloc/register_bloc.dart';
import 'package:task/utils/app_theme.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  final fullNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {},
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
                  height: 36.h,
                ),
                Text(
                  register,
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
                          editController: fullNameController,
                          focusNode: fullNameFocusNode,
                          labelText: fullName,
                          contentPadding: const EdgeInsets.all(24.0),
                          prefixWidget: SvgPicture.asset(ImageConstants.svgIcProfile),
                          textInputType: TextInputType.name,
                          maxLength: 70,
                          onChange: (value) {},
                        ),
                        Divider(
                          height: 2.h,
                          color: ColorConstants.dividerColor,
                        ),
                        CommonTextFormField(
                          editController: emailController,
                          focusNode: emailFocusNode,
                          labelText: emailId,
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
                          editController: phoneNumberController,
                          focusNode: phoneNumberFocusNode,
                          labelText: phoneNumber,
                          contentPadding: const EdgeInsets.all(24.0),
                          prefixWidget: SvgPicture.asset(ImageConstants.svgIcCall),
                          textInputType: TextInputType.phone,
                          maxLength: 10,
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
                              context.read<RegisterBloc>().add(RegisterPasswordChangedEvent(!state.isObscureText));
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
                  height: 60.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    agreeTP,
                    style: AppThemeState().textStyleMedium(ColorConstants.secondaryTextColor.withOpacity(0.6), fontSize: FontConstants.font_14),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CommonButton(
                  buttonText: signUp,
                  onTap: () {
                    Navigator.pop(context);
                  },
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
                        TextSpan(text: alreadyOnPlatform, style: AppThemeState().textStyleMedium(ColorConstants.textColor, fontFamily: FFT.plusJakartaSans, fontSize: FontConstants.font_14)),
                        TextSpan(
                          text: signUp,
                          style: AppThemeState().textStyleMedium(ColorConstants.primaryColor, fontFamily: FFT.plusJakartaSans, fontSize: FontConstants.font_14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
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
            ),
          ),
        );
      },
    );
  }
}
