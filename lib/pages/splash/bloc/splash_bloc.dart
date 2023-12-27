import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:task/api_service/dio_client.dart';
import 'package:task/common/enums/loading_status.dart';

import '../../../utils/repository_manager.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<SplashInitEvent>(_handleSplashInitEvent);
  }

  Future<void> _handleSplashInitEvent(
    SplashInitEvent event,
    Emitter<SplashState> emit,
  ) async {

    await Future.delayed(const Duration(seconds: 3), () {
      emit(state.copyWith(status: LoadStatus.success));
    },);
  }
}

/*Either<Failure, String> validatePhoneNumber(String str) {
  try {
    if (str.isEmpty) throw const FormatException();
    return Right(str);
  } on FormatException {
    return Left(InvalidPhoneNumberFailure());
  }
}*/
