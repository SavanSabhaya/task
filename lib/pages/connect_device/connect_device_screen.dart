import 'dart:io';

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
import 'package:task/common/widgets/common_button.dart';
import 'package:task/common/widgets/common_textformfield.dart';
import 'package:task/common/widgets/widget_background_container.dart';
import 'package:task/pages/connect_device/bloc/connect_device_bloc.dart';
import 'package:task/utils/CustomSnackBar.dart';
import 'package:task/utils/app_theme.dart';
import 'package:task/utils/componets.dart';
import 'package:task/utils/routes.dart';

class ConnectDeviceScreen extends StatefulWidget {
  const ConnectDeviceScreen({Key? key}) : super(key: key);

  @override
  State<ConnectDeviceScreen> createState() => _ConnectDeviceScreenState();
}

class _ConnectDeviceScreenState extends State<ConnectDeviceScreen> {
  late Socket socket;
  final formKey = GlobalKey<FormState>();
  TextEditingController ssidController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode ssidFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  var macAddress = "";

  @override
  void initState() {
    super.initState();

    ssidController.text = "Team_KR_2.4G";
    passwordController.text = "T#@mKR@1234";

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = (ModalRoute.of(context)?.settings.arguments ?? <String, String>{}) as Map;
    macAddress = arg["macAddress"].toString();
    // macAddress = "A4CF12258150";
    // BlocProvider.of<ConnectDeviceBloc>(context).add(ConnectDeviceInitEvent(macAddress));

    print("DATADATA state.macAddress 0 : $macAddress");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectDeviceBloc, ConnectDeviceState>(listener: (context, state) {
      if (state.status == LoadStatus.success) {
        successSnackBar(state.message);
        Navigator.pushNamedAndRemoveUntil(context, routeDashboard, (_) => false);
      } else if (state.status == LoadStatus.failure) {
        errorSnackBar(state.message);
      } else if(state is OnConnectErrorState){
        showErrorSnackBar(context, state.errorMessage);
      }else if(state is OnConnect){
        Navigator.pushNamedAndRemoveUntil(context, routeDashboard, (_) => false, arguments: {"macAddress": state.macAddress});
      }
    }, builder: (context, state) {
      return AppBackgroundContainer(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 37.h,
              ),
              Text(
                "Connect To Device",
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
                      editController: ssidController,
                      focusNode: ssidFocusNode,
                      labelText: "SSID",
                      contentPadding: const EdgeInsets.all(24.0),
                      textInputType: TextInputType.text,
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
                      // prefixWidget: SvgPicture.asset(ImageConstants.svgIcPassword),
                      textInputType: TextInputType.visiblePassword,
                      isPassword: true,
                      suffixIcon: GestureDetector(
                        child: SvgPicture.asset(state.isObscureText ? ImageConstants.svgIcFieldEye : ImageConstants.svgIcFieldCloseEye),
                        onTap: () {
                          context.read<ConnectDeviceBloc>().add(ConnectDeviceChangedEvent(!state.isObscureText));
                        },
                      ),
                      // suffixIcon: SvgPicture.asset(ImageConstants.svgIcFieldEye),
                      isObscureText: state.isObscureText,
                      onChange: (value) {},
                    ),
                  ],
                ),
              )),
              SizedBox(
                height: 40.h,
              ),
              CommonButton(
                  buttonText: "Connect",
                  onTap: () {
                    BlocProvider.of<ConnectDeviceBloc>(context).add(
                        ConnectDeviceInitEvent(macAddress,ssidController.text.toString(),passwordController.text.toString()));
                    // Navigator.pushNamedAndRemoveUntil(context, routeDashboard, (_) => false);
                  }),
            ],
          ),
        ),
      );
    });
  }
}
