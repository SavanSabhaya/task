import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/enums/loading_status.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterPasswordChangedEvent>(_showHidePass);
  }

  FutureOr<void> _showHidePass(RegisterPasswordChangedEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isObscureText: event.isObscureText));
  }
}
