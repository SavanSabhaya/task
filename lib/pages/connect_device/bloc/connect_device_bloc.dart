import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task/api_service/api_constant.dart';
import 'package:task/common/constants/string_constants.dart';
import 'package:task/common/enums/loading_status.dart';
import 'package:task/common/widgets/common_method.dart';
import 'package:task/utils/logger_util.dart';
import 'package:wifi_iot/wifi_iot.dart';

part 'connect_device_event.dart';

part 'connect_device_state.dart';

class ConnectDeviceBloc extends Bloc<ConnectDeviceEvent, ConnectDeviceState> {
  Socket? _socket;
  StreamSubscription? _socketStreamSub;
  ConnectionTask<Socket>? _socketConnectionTask;

  ConnectDeviceBloc() : super(const ConnectDeviceState()) {
    on<ConnectDeviceInitEvent>(_connectToDevice);
    on<ConnectDeviceChangedEvent>(_showHidePass);
  }

  FutureOr<void> _showHidePass(ConnectDeviceChangedEvent event, Emitter<ConnectDeviceState> emit) {
    emit(state.copyWith(isObscureText: event.isObscureText));
  }

  onConnectClick(ConnectDeviceInitEvent event, Emitter<ConnectDeviceState> emit) {
    // if (checkString(event.ssid)) {
    //   emit(OnConnectErrorState(enterSSID));
    // } else if (checkString(event.password)) {
    //   emit(OnConnectErrorState(enterPassword));
    // }else{
    //   _connectToDevice();
    // }
  }

  FutureOr<void> _connectToDevice(ConnectDeviceInitEvent event, Emitter<ConnectDeviceState> emit) async {
    if (checkString(event.ssid)) {
      emit(OnConnectErrorState(enterSSID));
    } else if (checkString(event.password)) {
      emit(OnConnectErrorState(enterPassword));
    } else {
      EasyLoading.show();
      if (Platform.isAndroid) {
        try {
          await state.platform.invokeMethod('connecttaskControllerAndroid', {"ssid": state.ssid, "password": state.password}).then((value) async {
            if (value == "onAvailable") {
              _connectToSocket(event.macAddress, event.ssid, event.password);
              // await WiFiForIoTPlugin.disconnect();
            } else {
              EasyLoading.dismiss();
              emit(state.copyWith(message: "Failed Connect with Controller", status: LoadStatus.failure));
            }
          });
        } on PlatformException catch (e) {
          EasyLoading.dismiss();
          emit(state.copyWith(message: e.message, status: LoadStatus.failure));
        } on Exception catch (e) {
          EasyLoading.dismiss();
          logger.log("Unable to connect: $e", printFullText: true);
          emit(state.copyWith(message: "Failed Connect with Controller", status: LoadStatus.failure));
        }
      } else {
        await WiFiForIoTPlugin.connect(state.ssid, password: state.password, joinOnce: true, security: NetworkSecurity.WPA).then((value) {
          print("AA $value");
          if (value == true) {
            _connectToSocket(event.macAddress, event.ssid, event.password);
          } else {
            EasyLoading.dismiss();
            emit(state.copyWith(message: "Failed Connect with Controller", status: LoadStatus.failure));
          }
        });
      }
    }
  }

  Future<void> _connectToSocket(String macAddress, String ssid, String password) async {
    try {
      _socketConnectionTask = await Socket.startConnect(ApiConstant.baseSocketUrl, ApiConstant.baseSocketPort);
      _socket = await _socketConnectionTask!.socket;

      _socketStreamSub = _socket!.asBroadcastStream().listen((event) async {
        try {
          String response = const Utf8Decoder().convert(event);
          Map<String, dynamic> decodeResponse = jsonDecode(response.substring(0, 40));
          if (decodeResponse["Message"] == "OK") {
            print("if decodeResponse $decodeResponse");
            await state.platform.invokeMethod('disconnectWifi').then((value) {
              EasyLoading.dismiss();
              print("DATADATA state.macAddress: 3 $macAddress");
              emit(OnConnect(macAddress));
            });
            _socketConnectionTask?.cancel();
            await _socketStreamSub?.cancel();
            await _socket?.close();
            // emit(state.copyWith(message: "Connected with Controller", status: LoadStatus.success));
            // await state.platform.invokeMethod('disconnectWifi');
          } else {
            EasyLoading.dismiss();
            emit(state.copyWith(message: "Fail to Connected with Controller", status: LoadStatus.failure));
          }
        } catch (e) {
          EasyLoading.dismiss();
          print("exception------------- $e");
        }
      });

      _socket!.handleError((e) {
        EasyLoading.dismiss();
        print("Error: ${e.toString()}");
      });
      Map<String, dynamic> data = {
        "Message_Type": "Config",
      };
      // Map<String, dynamic> message = {"HOST": MqttConstant.baseMqttUrl, "PORT": MqttConstant.baseMqttPort, "SSID": "Redmi Note", "PWD": "EWW@#123890", "Key": "if ssl"};
      Map<String, dynamic> message = {
        "HOST": MqttConstant.baseMqttUrlForJson,
        "PORT": MqttConstant.baseMqttPort.toString(),
        // "SSID": "IOT",
        // "PWD": "12345678",
        "SSID": ssid,
        "PWD": password,
        "Key": "if ssl"
      };

      data["Message"] = message;
      print("sendDat======== $data");
      _socket!.writeln(jsonEncode(data).trim());

      // Future.delayed(Duration(seconds: 3), ()  {
      //
      // });
    } catch (e) {
      EasyLoading.dismiss();
      logger.log("Unable to connect: $e", printFullText: true);
    }
  }

  @override
  Future<void> close() {
    _socketStreamSub?.cancel();
    _socket?.close();
    return super.close();
  }
}
