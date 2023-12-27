import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/enums/loading_status.dart';

part 'reset_password_event.dart';

part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(const ResetPasswordState()) {
    on<ResetNewPasswordChangedEvent>(_showHideNewPass);
    on<CnfNewPasswordChangedEvent>(_showHideCnfPass);
  }

  FutureOr<void> _showHideNewPass(ResetNewPasswordChangedEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(isNewPasswordObscureText: event.isObscureText));
  }

  FutureOr<void> _showHideCnfPass(CnfNewPasswordChangedEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(isCnfPasswordObscureText: event.isObscureText));
  }
}
