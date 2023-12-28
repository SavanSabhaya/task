import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/api_service/api_constant.dart';
import 'package:task/api_service/repository.dart';
import 'package:task/common/constants/string_constants.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/reponseModel/login_model.dart';
import 'package:task/utils/logger_util.dart';
import 'package:task/utils/shared_preferences.dart';
import 'package:task/utils/validator.dart';
import 'package:http/http.dart' as http;
part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({this.apiRepository}) : super(LoginState()) {
    on<LoginPasswordChangedEvent>(_showHidePass);
    on<ValidateEvent>(_validateEvent);
  }

  final ApiRepository? apiRepository;

  FutureOr<void> _showHidePass(
      LoginPasswordChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isObscureText: event.isObscureText));
  }

  FutureOr<void> _validateEvent(ValidateEvent event, Emitter<LoginState> emit) {
    if (Validator.isEmpty(event.email)) {
      emit(state.copyWith(
          message: emptyEmailError, status: LoadStatus.validationError));
    } else if (Validator.isEmail(event.email)) {
      emit(state.copyWith(
          message: invalidEmailError, status: LoadStatus.validationError));
    } else if (Validator.isEmpty(event.password)) {
      emit(state.copyWith(
          message: emptyPasswordError, status: LoadStatus.validationError));
    } else if (Validator.isEmpty(event.password)) {
      emit(state.copyWith(
          message: emptyPasswordError, status: LoadStatus.validationError));
    } else if (Validator.isPassword(event.password)) {
      emit(state.copyWith(
          message: invalidValidError, status: LoadStatus.validationError));
    } else {
      loginApi(event);
    }
    emit(state.copyWith(message: '', status: LoadStatus.initial));
  }

  Future<Map<String, dynamic>> loginApi(ValidateEvent event) async {
    final apiUrl = Uri.parse(ApiConstant.baseUrl +
        ApiConstant.login); // Replace 'upload' with your actual API endpoint
    logger.d('url ${apiUrl}');

    var request = http.MultipartRequest('POST', apiUrl)
      ..fields['email'] = event.email
      ..fields['password'] = event.password;

    var response = await request.send();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      LoginModel loginModel = LoginModel.fromJson(data);
      // SharePref().saveToken(loginModel.authToken.toString());
      logger.d(' get token${loginModel.authToken}');
      emit(state.copyWith(status: LoadStatus.success, loginModel: loginModel));
      return data;
    } else {
      throw Exception('Failed to upload data');
    }
  }
}
