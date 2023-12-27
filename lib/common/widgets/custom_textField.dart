import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';

class CustomTextFields {
  //Text
  /*static Text textField(
      {String text = "",
        Color textColor = ColorConstants.blackColor,
        double fontSize = FontConstants.font_16,
        double? wordSpacing,
        int maxLine = 50,
        double height = 1.0,
        String? fontFamily = FontFamilyConstants.cabin,
        FontWeight? fontWeight,
        FontStyle? fontStyle,
        TextAlign textAlign = TextAlign.center,
        TextOverflow textOverflow = TextOverflow.ellipsis,
        TextDecoration textDecoration = TextDecoration.none}) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        wordSpacing: wordSpacing,
        decoration: textDecoration,
        height: height,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      maxLines: maxLine,
      overflow: textOverflow,
      textAlign: textAlign,
    );
  }

  ///Simple Text

  static TextFormField textFormField(
      {TextEditingController? textEditingController,
        bool? enabled,
        bool readOnly = false,
        bool obscureText = false,
        bool allowValidation = true,
        EdgeInsetsGeometry contentPadding = EdgeInsets.zero,
        bool autofocus = false,
        bool enableInteractiveSelection = true,
        Color enableBorderColor = ColorConstants.whiteColor,
        Color textColor = ColorConstants.whiteColor,
        Color errorBorder = ColorConstants.whiteColor,
        Color focusedErrorBorder = ColorConstants.whiteColor,
        Color fillColor = ColorConstants.whiteColor,
        String? hintText,
        Color hintColor = ColorConstants.whiteColor,
        double? hintFontSize = FontConstants.font_16,
        String? labelText,
        Color? labelColor,
        double? labelFontSize,
        String? errorMessage,
        String? validationMessage,
        String? validationRegex,
        String? initialValue,
        String? valueMessage,
        String? lengthMessage,
        String fontFamily = FontFamilyConstants.cabin,
        FontWeight? fontWeight,
        FontStyle? fontStyle,
        double errorFontSize = FontConstants.font_12,
        int maxLine = 1,
        FocusNode? focusNode,
        String? suffixText,
        Widget? suffixIcon,
        Widget? prefix,
        Widget? prefixIcon,
        TextInputFormatter? inputFormatter,
        FocusNode? nextFocus,
        TextInputAction textInputAction = TextInputAction.done,
        TextInputType? keyBroadType,
        TextCapitalization? textCapitalization,
        TextAlign textAlign = TextAlign.center,
        int? length,
        int? value,
        BoxConstraints prefixIconConstraints =
        const BoxConstraints(maxWidth: 40, maxHeight: 40),
        BoxConstraints suffixIconConstraints =
        const BoxConstraints(maxWidth: 40, maxHeight: 40),
        double cursorWidth = 2.0,
        Function(String)? onFieldSubmit,
        Function(String)? onChanged,
        VoidCallback? onEditingComplete,
        double fontSize = FontConstants.font_16,
        Color errorColor = ColorConstants.selectedLightGreen,
        Color? validationColor,
        Color focusColor = ColorConstants.whiteColor,
        double prefixWidth = 40,
        double prefixHeight = 40}) {
    return TextFormField(
      validator: (text) {
        if (textEditingController!.text.trim().isEmpty && allowValidation) {
          return errorMessage ?? "Invalid Value";
        } else if (value != null &&
            (int.parse(textEditingController.text.trim().trim()) > value)) {
          return valueMessage ?? "Invalid Value";
        } else if (length != null && lengthMessage != null) {
          if (textEditingController.text.trim().length < length ||
              textEditingController.text.trim().length > length) {
            return lengthMessage;
          }
        } else if (validationRegex != null) {
          if (!RegExp(validationRegex).hasMatch(text!.trim())) {
            return validationMessage ?? 'Invalid Value';
          }
        }
        return null;
      },
      cursorWidth: cursorWidth,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmit,
      enabled: enabled,
      autofocus: autofocus,
      controller: textEditingController,
      maxLines: maxLine,
      maxLength: length,
      enableInteractiveSelection: enableInteractiveSelection,
      focusNode: focusNode,
      obscureText: obscureText,
      textInputAction: textInputAction,
      textAlign: textAlign,
      keyboardType: keyBroadType,
      inputFormatters:
      inputFormatter != null ? <TextInputFormatter>[inputFormatter] : null,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
      decoration: InputDecoration(
          filled: false,
          alignLabelWithHint: true,
          hintText: hintText,
          prefixIconConstraints: prefixIconConstraints,
          suffixIconConstraints: suffixIconConstraints,
          border: new UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.black)),
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: hintFontSize,
            fontWeight: fontWeight,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelColor,
            fontSize: labelFontSize,
            fontWeight: fontWeight,
          ),
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffixText: suffixText,
          suffixIcon: suffixIcon,
          fillColor: fillColor,
          errorStyle: TextStyle(
            color: errorColor,

            ///validation Color
            fontSize: errorFontSize,
            fontWeight: fontWeight,
          ),
          contentPadding: contentPadding,
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: focusColor,
                width: 1.0,
              )),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: errorBorder,
                width: 1.0,
              )),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: focusColor, width: 1.0)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: enableBorderColor, width: 1.0))),
    );
  }*/
}