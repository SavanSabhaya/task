import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/pages/detailpage/bloc/detailpage_bloc.dart';

class DetailpageView extends StatelessWidget {
  const DetailpageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailpageBloc, DetailpageState>(
      listener: (context, state) {},
      builder: (context, state) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Product',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Replace with your color constant
              ),
            ),
          ),
          body: OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.portrait
                  ? _buildBody(context, orientation)
                  : _buildBodyforLandscap(context, orientation);
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, Orientation orientation) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height / 2
                : MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Colors.lightBlue, // Replace with your color constant
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
        ],
      ),
    );
  }

  Widget _buildBodyforLandscap(BuildContext context, Orientation orientation) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.lightBlue, // Replace with your color constant
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(title: 'Product name', data: ''),
                    titleText(title: 'Product ID', data: ''),
                    titleText(title: 'Price', data: '\$'),
                    titleText(title: 'Count', data: ''),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleText({String? title, String? data}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
