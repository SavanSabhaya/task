part of 'connect_device_bloc.dart';

@immutable
abstract class ConnectDeviceEvent extends Equatable {
  const ConnectDeviceEvent();
  @override
  List<Object?> get props => [];
}

class ConnectDeviceInitEvent extends ConnectDeviceEvent{
  final String macAddress;
  final String ssid;
  final String password;
  const ConnectDeviceInitEvent(this.macAddress,this.ssid,this.password);
}

class ConnectDeviceChangedEvent extends ConnectDeviceEvent {
  final bool isObscureText;
  const ConnectDeviceChangedEvent(this.isObscureText);
}