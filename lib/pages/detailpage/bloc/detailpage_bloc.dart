import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/reponseModel/product_model.dart';

part 'detailpage_event.dart';
part 'detailpage_state.dart';




class DetailpageBloc extends Bloc<DetailpageEvent, DetailpageState> {
  DetailpageBloc() : super(DetailpageIntial()) {
   
    on<DetailPageInitEvent>(initevent);
  }

  FutureOr<void> initevent(DetailPageInitEvent event, Emitter<DetailpageState> emit) {
    emit(state.copyWith(data: event.data['getData']));
  }
}
