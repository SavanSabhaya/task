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
import 'package:task/pages/reset_password/bloc/reset_password_bloc.dart';
import 'package:task/utils/app_theme.dart';
import 'package:task/utils/routes.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  final newPasswordController = TextEditingController();
  final cnfPasswordController = TextEditingController();
  final newPasswordFocusNode = FocusNode();
  final cnfPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppBackgroundContainer(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
                child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  labelResetPassword,
                  style: AppThemeState().textStyleBold(ColorConstants.textColor, fontSize: FontConstants.font_32),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  labelPleaseEnterNewPasswordReset,
                  style: AppThemeState().textStyleMedium(ColorConstants.textTwoColor, fontSize: FontConstants.font_14),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        WidgetBackgroundContainer(
                          child: CommonTextFormField(
                            editController: newPasswordController,
                            focusNode: newPasswordFocusNode,
                            labelText: newPassword,
                            contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                            prefixWidget: SvgPicture.asset(ImageConstants.svgIcPassword),
                            textInputType: TextInputType.visiblePassword,
                            isPassword: true,
                            suffixIcon: GestureDetector(
                              child: SvgPicture.asset(state.isNewPasswordObscureText ? ImageConstants.svgIcFieldEye : ImageConstants.svgIcFieldCloseEye),
                              onTap: () {
                                context.read<ResetPasswordBloc>().add(ResetNewPasswordChangedEvent(!state.isNewPasswordObscureText));
                              },
                            ),
                            // suffixIcon: SvgPicture.asset(ImageConstants.svgIcFieldEye),
                            isObscureText: state.isNewPasswordObscureText,
                            onChange: (value) {},
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        WidgetBackgroundContainer(
                          child: CommonTextFormField(
                            editController: cnfPasswordController,
                            focusNode: cnfPasswordFocusNode,
                            labelText: cnfNewPassword,
                            textInputAction: TextInputAction.done,
                            contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                            prefixWidget: SvgPicture.asset(ImageConstants.svgIcPassword),
                            textInputType: TextInputType.visiblePassword,
                            isPassword: true,
                            suffixIcon: GestureDetector(
                              child: SvgPicture.asset(state.isCnfPasswordObscureText ? ImageConstants.svgIcFieldEye : ImageConstants.svgIcFieldCloseEye),
                              onTap: () {
                                context.read<ResetPasswordBloc>().add(CnfNewPasswordChangedEvent(!state.isCnfPasswordObscureText));
                              },
                            ),
                            // suffixIcon: SvgPicture.asset(ImageConstants.svgIcFieldEye),
                            isObscureText: state.isCnfPasswordObscureText,
                            onChange: (value) {},
                          ),
                        ),
                      ],
                    ))
              ],
            )),
            Container(
              margin: EdgeInsets.only(bottom: 24.h),
              child: CommonButton(
                buttonText: labelSavePassword,
                onTap: () {
                  Navigator.popUntil(context,ModalRoute.withName(routeLogin));
                },
              ),
            )
          ]),
        );
      },
    );
  }
}
