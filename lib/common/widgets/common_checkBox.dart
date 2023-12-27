import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/common/constants/image_constants.dart';

class CommonCheckBox extends StatelessWidget {
  final bool isCheck;
  final void Function() onTap;

  const CommonCheckBox({Key? key, required this.isCheck,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: isCheck ? SvgPicture.asset(ImageConstants.svgIcCheckedSquare) : SvgPicture.asset(ImageConstants.svgIcSquare));
  }
}
