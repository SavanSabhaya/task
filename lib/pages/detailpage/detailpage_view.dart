import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/pages/detailpage/bloc/detailpage_bloc.dart';

class DetailpageView extends StatelessWidget {
  const DetailpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailpageBloc, DetailpageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Product',
                style: TextStyle(
                    fontSize: FontConstants.font_24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primaryColor),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      color: ColorConstants.secondaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          titleText(title: 'Product name', data: ''),
                          titleText(title: 'Product ID', data: ''),
                          titleText(title: 'Price', data: '\$'),
                          titleText(title: 'Count', data: ''),
                        ],
                      ),
                    ),
                  ]),
            ),
          );
        });
  }

  Widget titleText({String? title, String? data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? '',
            style: TextStyle(
                color: ColorConstants.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        Text(data ?? '',
            style: TextStyle(
                color: ColorConstants.blackColor,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
        Divider(height: 2, color: ColorConstants.secondaryColor)
      ],
    );
  }
}
