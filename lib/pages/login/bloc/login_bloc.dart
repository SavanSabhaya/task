import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/constants/string_constants.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/utils/validator.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginPasswordChangedEvent>(_showHidePass);
    on<ValidateEvent>(_validateEvent);
  }

  FutureOr<void> _showHidePass(LoginPasswordChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isObscureText: event.isObscureText));
  }

  FutureOr<void> _validateEvent(ValidateEvent event, Emitter<LoginState> emit) {
    if (Validator.isEmpty(event.email)) {
      emit(state.copyWith(message: emptyEmailError, status: LoadStatus.validationError));
    } else if (Validator.isEmail(event.email)) {
      emit(state.copyWith(message: invalidEmailError, status: LoadStatus.validationError));
    }else if(Validator.isEmpty(event.password)){
      emit(state.copyWith(message: emptyPasswordError, status: LoadStatus.validationError));
    }else if(Validator.isEmpty(event.password)){
      emit(state.copyWith(message: emptyPasswordError, status: LoadStatus.validationError));
    }else if(Validator.isPassword(event.password)){
      emit(state.copyWith(message: invalidValidError, status: LoadStatus.validationError));
    }else{
      emit(state.copyWith(status: LoadStatus.success));
    }
    emit(state.copyWith(message: '', status: LoadStatus.initial));
  }
}
