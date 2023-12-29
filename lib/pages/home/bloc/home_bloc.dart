import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/api_service/api_constant.dart';
import 'package:task/common/constants/storage_key_constants.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/reponseModel/login_model.dart';
import 'package:task/reponseModel/product_model.dart';
import 'package:task/utils/logger_util.dart';
import 'package:http/http.dart' as http;
import 'package:task/utils/shared_preferences.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeInitEvent>(profile);
  }
  var preferences = MySharedPref();

  FutureOr<void> profile(HomeInitEvent event, Emitter<HomeState> emit) {
    productDetailApi(event);
  }

  Future<Map<String, dynamic>> productDetailApi(HomeInitEvent event) async {
    emit(state.copyWith(status: LoadStatus.loading));
    final apiUrl = Uri.parse(ApiConstant.baseUrl +
        ApiConstant
            .orderHistory); 
    logger.d('url ${apiUrl}');
LoginModel? loginModel =
        await preferences.getLoginModel(StorageKeyConstants.cKeyIsToken);
    var request = http.MultipartRequest('POST', apiUrl)
      ..fields['authToken'] = loginModel!.authToken.toString()
      ..fields['userId'] = loginModel.userId.toString() ;

    var response = await request.send();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      ProductListModel productListModel = ProductListModel.fromJson(data);
      if (productListModel.success == true) {
        emit(state.copyWith(
            status: LoadStatus.success, productListModel: productListModel));
      } else {
        emit(state.copyWith(
          status: LoadStatus.failure, message: 'Something went wrong...!'));
      }
      return data;
    } else {
       emit(state.copyWith(
          status: LoadStatus.failure, message: 'Something went wrong...!'));
      throw Exception('Failed to upload data');
    }
  }
}
