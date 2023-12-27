part of 'scan_qr_code_bloc.dart';

class ScanQRCodeState extends Equatable {
  const ScanQRCodeState({
    this.message = '',
    this.status = LoadStatus.initial,
  });
  final String message;
  final LoadStatus status;

  ScanQRCodeState copyWith({
    LoadStatus? status,
    String? message,
  }) {
    return ScanQRCodeState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    message,
    status,
  ];
}