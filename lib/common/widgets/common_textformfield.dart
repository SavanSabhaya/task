import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/utils/app_theme.dart';
import 'package:task/utils/componets.dart';

class CommonTextFormField extends StatefulWidget {
  CommonTextFormField({
    Key? key,
    required this.editController,
    required this.focusNode,
    required this.labelText,
    this.labelColor,
    required this.onChange,
    // required this.onValidate,
    this.onFieldSubmitted,
    this.maxLength,
    this.backgroundColor,
    this.isEnabled = true,
    this.textAlign = TextAlign.start,
    required this.textInputType,
    this.maxLines = 1,
    this.minLines = 1,
    this.textCounter,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixIcon,
    this.contentPadding,
    this.isAlignLabelWithHint,
    this.isPassword = false,
    this.isObscureText = false,
    this.textInputAction,
  }) : super(key: key);

  final TextEditingController editController;
  final FocusNode focusNode;
  final int? maxLength;
  final String labelText;
  final Color? labelColor;
  final Color? backgroundColor;
  bool isEnabled = true;
  TextAlign textAlign;
  bool isPassword;
  bool isObscureText;
  TextInputType textInputType;
  final void Function(String?) onChange;
  // final String? Function(String?) onValidate;
  final void Function(String?)? onFieldSubmitted;
  int maxLines = 1;
  int minLines = 1;
  final Widget? textCounter;
  final Widget? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final bool? isAlignLabelWithHint;
  TextInputAction? textInputAction;

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.contentPadding ?? EdgeInsets.only(left: 20.w, right: 5.w, top: 0, bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.prefixWidget == null ? Container() : widget.prefixWidget!,
          SizedBox(
            width: widget.prefixWidget != null ? 10.w : 0.0,
          ),
          Expanded(
            child: TextFormField(
                autofocus: false,
                enableInteractiveSelection: false,
                textInputAction: widget.textInputAction ?? TextInputAction.next,
                controller: widget.editController,
                focusNode: widget.focusNode,
                enabled: widget.isEnabled,
                textAlign: widget.textAlign,
                obscuringCharacter: '*',
                inputFormatters: onGetInputFormatter(),
                keyboardType: widget.textInputType,
                onChanged: widget.onChange,
                obscureText: widget.isObscureText,
                cursorColor: widget.labelColor ?? ColorConstants.textTwoColor,
                textCapitalization: widget.textInputType == TextInputType.emailAddress || widget.isPassword ? TextCapitalization.none : TextCapitalization.sentences,
                minLines: widget.minLines,
                maxLength: widget.maxLength ?? 100,
                onFieldSubmitted: widget.onFieldSubmitted,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  alignLabelWithHint: widget.isAlignLabelWithHint ?? false,
                  // prefixIcon: widget.prefixIcon,
                  // prefix: widget.prefixWidget,
                  // suffixIcon: widget.suffixIcon,
                  counter: null,
                  isDense: true,
                  counterText: "",
                  hintText: widget.labelText,
                  hintStyle: AppThemeState().textStyleMedium(widget.labelColor ?? ColorConstants.textTwoColor, fontSize: FontConstants.font_16, decoration: TextDecoration.none),
                  filled: false,
                  fillColor: widget.backgroundColor ?? ColorConstants.whiteColor,
                  border: InputBorder.none,
                  // disabledBorder: AppThemeState.disabledBorderStyle(),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                style: AppThemeState().textStyleMedium(widget.labelColor ?? ColorConstants.textTwoColor, fontSize: FontConstants.font_16, decoration: TextDecoration.none)),
          ),
          SizedBox(
            width: widget.prefixWidget != null ? 10.w : 0.0,
          ),
          widget.suffixIcon == null ? Container() : widget.suffixIcon!,
        ],
      ),
    );
  }

  List<TextInputFormatter> onGetInputFormatter() {
    List<TextInputFormatter> inputFormatter = [];
    inputFormatter.addAll([FilteringTextInputFormatter.deny(RegExp('(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')), InitialSpaceInputFormatter()]);
    if (widget.textInputType == TextInputType.name) {
      inputFormatter.addAll([InitialZeroInputFormatter(), FilteringTextInputFormatter.allow(RegExp(r'^-?[A-Za-z0-9\s]*')),LengthLimitingTextInputFormatter(70),]);
    } else if (widget.textInputType == TextInputType.phone || widget.textInputType == TextInputType.number) {
      inputFormatter.addAll([
        FilteringTextInputFormatter.allow(RegExp(
          r'^-?\d*',
        )),
        InitialZeroInputFormatter()
      ]);
      // inputFormatter.addAll([FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*',)), InitialZeroInputFormatter()]);
    } else if (widget.textInputType == TextInputType.none) {
      inputFormatter.addAll([FilteringTextInputFormatter.allow(RegExp("(^[+A-Z+a-z+0-9]+\$)"))]);
    }
    return inputFormatter;
  }
}
