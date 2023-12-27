import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/enums/loading_status.dart';

part 'zones_event.dart';

part 'zones_state.dart';

class ZonesBloc extends Bloc<ZonesEvent,ZonesState>{
  ZonesBloc() : super(const ZonesState()) {
  }
}