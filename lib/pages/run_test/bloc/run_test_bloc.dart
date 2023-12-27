import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/models/zones.dart';

part 'run_test_event.dart';

part 'run_test_state.dart';

class RunTestBloc extends Bloc<RunTestEvent, RunTestState> {
  RunTestBloc() : super(RunTestState(zoneList: [
    Zones(title: "Zone 1", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
    Zones(title: "Zone 2", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
    Zones(title: "Zone 3", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
    Zones(title: "Zone 4", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
    Zones(title: "Zone 5", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
    Zones(title: "Zone 6", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
    Zones(title: "Zone 7", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
    Zones(title: "Zone 8", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
    Zones(title: "Zone 9", subTitle: "High Shade", image: "https://picsum.photos/200/300"),
    Zones(title: "Zone 10", subTitle: "High Shade", image: "https://picsum.photos/200/300")
  ])) {
    on<SelectAllEvent>(_isCheckAll);
    on<UpdateStatusEvent>(_updateStatus);
  }

  FutureOr<void> _isCheckAll(SelectAllEvent event, Emitter<RunTestState> emit) {
    emit(state.copyWith(isCheckAll: event.isCheck));
  }

  FutureOr<void> _updateStatus(UpdateStatusEvent event, Emitter<RunTestState> emit) {
    print("object========= ${event.isStart}");
    emit(state.copyWith(isRunning: event.isStart));
  }
}
