import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/enums/loading_status.dart';

part 'scan_qr_code_event.dart';

part 'scan_qr_code_state.dart';

class ScanQRCodeBloc extends Bloc<ScanQRCodeEvent, ScanQRCodeState> {
  ScanQRCodeBloc() : super(const ScanQRCodeState()) {}
}
