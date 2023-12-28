import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/api_service/api_constant.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/reponseModel/product_model.dart';
import 'package:task/utils/logger_util.dart';
import 'package:http/http.dart' as http;

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeInitEvent>(profile);
  }

  FutureOr<void> profile(HomeInitEvent event, Emitter<HomeState> emit) {
    productDetailApi(event);
  }

  Future<Map<String, dynamic>> productDetailApi(HomeInitEvent event) async {
    emit(state.copyWith(status: LoadStatus.loading));
    final apiUrl = Uri.parse(ApiConstant.baseUrl +
        ApiConstant
            .orderHistory); // Replace 'upload' with your actual API endpoint
    logger.d('url ${apiUrl}');

    var request = http.MultipartRequest('POST', apiUrl)
      ..fields['authToken'] = 'f2d21c9f-54e1-4159-8101-4557670ae845'
      ..fields['userId'] = '1394';

    var response = await request.send();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      logger.d(' get list length===>${data}');
      ProductListModel productListModel = ProductListModel.fromJson(data);
      // SharePref().saveToken(loginModel.authToken.toString());
      logger.d(' get list length===>${productListModel.data?.length}');
      emit(state.copyWith(
          status: LoadStatus.success, productListModel: productListModel));
      return data;
    } else {
      throw Exception('Failed to upload data');
    }
  }
}
