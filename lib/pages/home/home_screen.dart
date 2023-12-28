import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/pages/home/bloc/home_bloc.dart';
import 'package:task/reponseModel/product_model.dart';
import 'package:task/utils/CustomSnackBar.dart';
import 'package:task/utils/routes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  ProductListModel? productListModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      if (state.status == LoadStatus.success) {
        productListModel = state.productListModel;
        print('get page list ===>${productListModel?.data?.length}');
        showSuccessSnackBar(context, state.message);
        EasyLoading.dismiss();
      } else if (state.status == LoadStatus.loading) {
        EasyLoading.show();
      } else {
        EasyLoading.dismiss();
      }
    }, builder: (context, state) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Home',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue, // Replace with your color constant
            ),
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return _buildBody(orientation);
          },
        ),
      );
    });
  }

  Widget _buildBody(Orientation orientation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Divider(
            height: 1,
            color: Colors.blue, // Replace with your color constant
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFEDECF5),
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: productListModel?.data?.length ?? 2,
              itemBuilder: (context, index) {
                return detailCard(index, orientation);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget detailCard(int index, Orientation orientation) {
    return Container(
      height: orientation == Orientation.portrait ? 240 : 240,
      child: Card(
        color: ColorConstants.secondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                  title: 'Order ID',
                  data: productListModel?.data?[index].orderID),
              customText(
                  title: 'Date',
                  data: productListModel?.data?[index].date.toString()),
              customText(
                  title: 'Amount',
                  data: productListModel?.data?[index].paidAmount.toString()),
              customText(
                  title: 'Status',
                  data: productListModel?.data?[index].paymentStatus),
              customText(title: 'No of product', data: index.toString()),
              Divider(
                height: 1,
                color: ColorConstants.primaryColor,
              ),
              SizedBox(height: 5),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        productListModel?.data?[index].product?.length ?? 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, routeDetailPage);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          height: 100,
                          width: 80,
                          child: Image.network(
                              productListModel
                                      ?.data?[index].product?[i].productOtherUrl
                                      .toString() ??
                                  '',
                              fit: BoxFit.fill),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customText({String? title, String? data}) {
    return Text("$title : ${data ?? ''}",
        style: TextStyle(
            color: ColorConstants.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600));
  }
}
