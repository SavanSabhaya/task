import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task/common/enums/loading_status.dart';

part 'detailpage_event.dart';
part 'detailpage_state.dart';

class DetailpageBloc extends Bloc<DetailpageEvent, DetailpageState> {
  DetailpageBloc() : super(DetailpageState()) {
    // on<DetailPageInitEvent>(getDetail);
  }

  FutureOr<void> getDetail(
      DetailPageInitEvent event, Emitter<DetailpageEvent> emit) {
    // emit(state.copyWith(status: LoadStatus.success));
  }
}
