import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task/api_service/api_constant.dart';
import 'package:task/api_service/api_interceptor.dart';
import 'package:task/common/enums/method_type.dart';
import 'package:task/common/widgets/common_widgets.dart';



class DioClient {
  late Dio dio;

  DioClient init() {
    dio = Dio(BaseOptions(baseUrl: ApiConstant.baseUrl))..interceptors.add(ApiInterceptors());
    return this;
  }

  Future<Either<Map<String, dynamic>, Map<String, dynamic>>> request(String url, MethodType method, dynamic params) async {
    try {
      Response response;
      if (await CommonWidgets.checkConnectivity()) {
        if (method == MethodType.post) {
          response = await dio.post(url, data: params);
        } else if (method == MethodType.delete) {
          response = await dio.delete(url);
        } else if (method == MethodType.patch) {
          response = await dio.patch(url);
        } else {
          response = await dio.get(
            url,
            queryParameters: params,
          );
        }

        return right(response.data);
      } else {
        return left({
          "message":"No Internet connection",
          "status" : false
        });
      }
    } on DioError catch (dioError) {
      return left({
        "message":dioError.response?.data["message"],
        "status" : false
      });
    } catch (error) {
      return left({
        "message":error.toString(),
        "status" : false
      });
    }
  }
}



