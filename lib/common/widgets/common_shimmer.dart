import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/color_constants.dart';

class CommonShimmer extends StatelessWidget {
  final Widget childWidget;
  final bool isStart;

  const CommonShimmer({Key? key, required this.childWidget, this.isStart = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorConstants.colorShimmerColor,
        highlightColor: ColorConstants.whiteColor,
        child: childWidget
    );
  }
}
