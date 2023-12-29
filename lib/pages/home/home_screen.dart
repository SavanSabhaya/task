import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task/common/constants/color_constants.dart';
import 'package:task/common/constants/font_constants.dart';
import 'package:task/common/constants/storage_key_constants.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/pages/home/bloc/home_bloc.dart';
import 'package:task/reponseModel/product_model.dart';
import 'package:task/utils/CustomSnackBar.dart';
import 'package:task/utils/routes.dart';
import 'package:task/utils/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Data> originalProductList = [];
  List<Data> filteredProductList = [];

  TextEditingController searchController = TextEditingController();
  var preferences = MySharedPref();

  @override
  void initState() {
    super.initState();
// var gettoken=SharePref().getToken();
    setState(() {});
    gettoken();
  }

  void gettoken() async {
    var gettoken =
        await preferences.getStringValue(StorageKeyConstants.cKeyIsToken);
  }

  void filterProductList(String query) {
    print('1');
    setState(() {
      filteredProductList = originalProductList
          .where((product) =>
              product.product!.any((p) =>
                  p.productName!.toLowerCase().contains(query.toLowerCase())) ||
              product.orderID!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
      if (state.status == LoadStatus.success) {
        originalProductList = state.productListModel?.data ?? [];
        filteredProductList = originalProductList;
        EasyLoading.dismiss();
      } else if (state.status == LoadStatus.loading) {
        EasyLoading.show();
      } else if (state.status == LoadStatus.failure) {
        showSuccessSnackBar(context, state.message);
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
              color: ColorConstants.primaryColor,
            ),
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return _buildBody(filteredProductList, orientation);
          },
        ),
      );
    });
  }

  Widget _buildBody(List<Data>? data, Orientation orientation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Divider(
            height: 1,
            color: ColorConstants.primaryColor,
          ),
          SizedBox(height: 10),
          TextField(
              controller: searchController,
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
              onChanged: (query) {
                setState(() {
                  filterProductList(query);
                });
              }),
          SizedBox(height: 10),
          searchController.text != '' && filteredProductList.isEmpty
              ? Expanded(child: Center(child: Text('No data found')))
              : Expanded(
                  child: ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return detailCard(data, index, orientation);
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget detailCard(List<Data>? data, int index, Orientation orientation) {
    return Container(
      height: orientation == Orientation.portrait ? 240 : 240,
      child: Card(
        color: ColorConstants.secondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(title: 'Order ID', data: data?[index].orderID),
              customText(title: 'Date', data: data?[index].date.toString()),
              customText(
                  title: 'Amount', data: data?[index].paidAmount.toString()),
              customText(title: 'Status', data: data?[index].paymentStatus),
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
                    itemCount: data?[index].product?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, routeDetailPage,
                              arguments: {'getData': data?[index].product?[i]});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          height: 100,
                          width: 80,
                          child: Image.network(
                              data?[index]
                                      .product?[i]
                                      .productOtherUrl
                                      .toString() ??
                                  '',
                              fit: BoxFit.contain),
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
            fontSize: 15,
            fontWeight: FontWeight.w400));
  }
}
