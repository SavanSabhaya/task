part of 'connect_device_bloc.dart';

class ConnectDeviceState /*extends Equatable*/ {
  const ConnectDeviceState({
    this.message = '',
    this.isObscureText = true,
    this.status = LoadStatus.initial,
  });

  final String message;
  final LoadStatus status;
  final platform = const MethodChannel('com.task.flutter/connecttaskControllerAndroid');
  final String ssid = "Smart_Controller";
  final String password = "12345678";
  final bool isObscureText;

  ConnectDeviceState copyWith({
    LoadStatus? status,
    String? message,
    bool? isObscureText,
  }) {
    return ConnectDeviceState(
      status: status ?? this.status,
      message: message ?? this.message,
      isObscureText: isObscureText ?? this.isObscureText,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        isObscureText,
      ];
}

class OnConnect extends ConnectDeviceState {
  var macAddress;
  OnConnect(this.macAddress);
}

class OnConnectErrorState extends ConnectDeviceState {
  var errorMessage;
  OnConnectErrorState(this.errorMessage);
}
